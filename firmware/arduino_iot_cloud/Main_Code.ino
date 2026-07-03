#include "arduino_secrets.h"
#include <Arduino.h>
#include "thingProperties.h"
#include <ESP32Servo.h>
#include <Wire.h>
#include <Adafruit_PWMServoDriver.h>

// Initialize the PWM Servo Driver at address 0x40
Adafruit_PWMServoDriver board1 = Adafruit_PWMServoDriver(0x40);

// Define the pulse range for each servo
int SERVOMIN[3] = {105,150,150}; // Minimum pulse length count (out of 4096)
int SERVOMAX[3] = {500,460,420}; // Maximum pulse length count (out of 4096)
int SERVORANGE[3] = {180,180,90}; // Servo angle range for each servo

#define SERVO_FREQ 50 // Frequency of the servos (50 Hz)

// Pin Definitions for limit switches
const int limitSwitchPinA = 2; 
const int limitSwitchPinB = 15; 
bool HomedA = 0; // Flag to check if Motor A has been homed
bool HomedB = 0; // Flag to check if Motor B has been homed

// Servo angles (initial values)
int angle1 = 90;  
int angle2 = 90;
int angle3 = 00;
const int angleinil = 90; // Initial servo angle

// Motor A Pins (DC Motor A)
static const int PWM_PIN_A = 18;
static const int IN1_PIN_A = 25;
static const int IN2_PIN_A = 26;
static const int ENCA_PIN_A = 35;
static const int ENCB_PIN_A = 34;

// Motor B Pins (DC Motor B)
static const int PWM_PIN_B = 19;
static const int IN1_PIN_B = 27;
static const int IN2_PIN_B = 14;
static const int ENCA_PIN_B = 33; 
static const int ENCB_PIN_B = 32; 

// PWM Configuration
#define CH_A 0
#define CH_B 1  
const uint32_t LEDC_FREQ = 5000; // Frequency for PWM signals
const int LEDC_RES = 8; // Resolution of PWM

// PID Variables
volatile long encoderPosA = 0, encoderPosB = 0; // Encoder positions for motors A and B
long prevMicros = 0; // Previous time for PID calculation
float prevErrorA = 0, prevErrorB = 0; // Previous error for PID
float integralA = 0, integralB = 0; // Integral error for PID

// Target & Conversion
const float PULSES2DEG_A = 180.0 / 11560.0;  // Conversion factor for Motor A
const float PULSES2DEG_B = 1296.0 / 22253.0; // Conversion factor for Motor B

// Motor Related Variables
int dirA; // Direction of Motor A
int dirB; // Direction of Motor B
float angleA; // Current angle of Motor A
float angleB; // Current angle of Motor B
long pulsesA; // Pulses for Motor A
long pulsesB; // Pulses for Motor B
int pwmA; // PWM value for Motor A
int pwmB; // PWM value for Motor B
float errorA; // Error for Motor A PID
float errorB; // Error for Motor B PID
float dA; // Derivative term for Motor A PID
float dB; // Derivative term for Motor B PID
float dt; // Time difference for PID
float uA; // Control output for Motor A PID
float uB; // Control output for Motor B PID

// Encoder Interrupt Service Routines (ISRs)
void IRAM_ATTR readEncoderA() {
    if (digitalRead(ENCB_PIN_A) == digitalRead(ENCA_PIN_A)) encoderPosA++;
    else encoderPosA--;  // Update encoder position for Motor A based on the direction
}

void IRAM_ATTR readEncoderB() {
    if (digitalRead(ENCB_PIN_B) == digitalRead(ENCA_PIN_B)) encoderPosB++;
    else encoderPosB--;  // Update encoder position for Motor B based on the direction
}

void IRAM_ATTR stopMotorA() {
    driveMotor(CH_A, IN1_PIN_A, IN2_PIN_A, 0, 0); 
    encoderPosA = 0; // Reset encoder position for Motor A
    angleA = 0; // Reset angle for Motor A
    currentAngle1 = 0; // Reset current angle for Servo 1
}

void IRAM_ATTR stopMotorB() {
    driveMotor(CH_B, IN1_PIN_B, IN2_PIN_B, 0, 0); 
    encoderPosB = 0; // Reset encoder position for Motor B
    angleB = 0; // Reset angle for Motor B
    currentAngle2 = 0; // Reset current angle for Servo 2
}

// Motor Driver Function to control direction and speed
void driveMotor(int pwmChannel, int in1, int in2, int dir, int pwmVal) {
  ledcWrite(pwmChannel, pwmVal); // Set the PWM value
  if (dir > 0) { // Forward direction
    digitalWrite(in1, LOW); 
    digitalWrite(in2, HIGH);
  }
  else if (dir < 0) { // Reverse direction
    digitalWrite(in1, HIGH);
    digitalWrite(in2, LOW);
  }
  else { // Stop the motor
    digitalWrite(in1, HIGH);
    digitalWrite(in2, HIGH);
  }
}

// Function to convert servo angle to PWM pulse width
void SetServoAngle(int servonum, int angle){
  board1.setPWM((servonum+8), 0, map(angle, 0, SERVORANGE[servonum], SERVOMIN[servonum], SERVOMAX[servonum]));
}

//////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\
///////////////////// Scenario \\\\\\\\\\\\\\\\\\\\
//////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\

// Define stop position
#define Stop_At_Pose_No 66

// Scenario array defines the sequence of poses
int Scenario[100][5] = { 
    {  0,  0,  90,  90,    0},
    {  0,  45,  90, 120,   5},
    // A
    {  0,  45,  70, 120,   5},
    {  0,  45,  70, 120,   5},
    {  0,  45,  70, 120,   5},
    // B
    {  0,  45,  25, 120,   5},
    {  0,  45,  25, 120,   5},
    {  0,  45,  25, 120,   5},
    // C
    {  0,  30,  65, 110,   0},
    {  0,  30,  65, 110,   0},
    {  0,  30,  65, 110,   0},
    // D
    {  0,  15,  80, 130,   0},
    {  0,  25,  80, 170,  20},
    {  0,  25,  80, 170,  20},
    // AWAY
    {  0,   0, 180,  90,  10},
    {  0,   0, 180,  90,  90},
    // E
    {  0,  40, 150,  70,  90},
    {  0,  40, 150,  35,  90},
    {  0,  40, 150,  35,  90},
    {  0,  40, 150,  35,  90},                //20
    // F
    {  0,  40,  60,  10,  90},
    {  0,  40,  60,  10,  90},
    // G
    { 10,  40,  60,  10,  90},
    { 20,  40,  55,  15,  90},
    { 30,  40,  50,  20, 80},
    { 30,  40,  45,  25, 70},
    { 30,  55,  35,  30, 65},
    { 30,  55,  35,  30, 65},
    { 30,  55,  35,  30, 65},
    // AWAY
    { 30,  40,   0,  50,  80},
    { 30,  20,   0,  50,  90},
    { 30,   0,   0,  50,  90},
    { 30,   0,   0,  90,   0},
    // Long Travel
    {  50,   0,   0,  90,  20},          
    {  70,   0,  20,  90,  20},          
    {  90,   0,  20,  90,  20},          
    { 110,   0,  20,  90,  20},          
    { 110,   0,  20,  90,  20},          
    { 110,   0,  20,  90,  20},          
    // H
    { 110,   0,  50, 125,  30},          
    { 110,   0,  80, 160,  40},          
    { 110,   0,  80, 160,  40},         
    { 110,   0,  80, 160,  40},         
    { 130,   0,  80, 160,  20},          
    { 150,   0,  80, 160,  20},          
    { 170,   0,  80, 160,  20},          // 46
    // More moves...
};

// Function to move to a specific pose in the scenario
void GoToPose(int currentPose){
    dc1    = Scenario[currentPose][0];  // Motor 1 angle for pose i
    dc2    = Scenario[currentPose][1];  // Motor 2 angle for pose i
    angle1 = Scenario[currentPose][2];  // Motor 3 angle for pose i
    angle2 = Scenario[currentPose][3];  // Motor 4 angle for pose i
    angle3 = Scenario[currentPose][4];  // Motor 5 angle for pose i  
}

// Variables to track time and pose
unsigned long lastMoveTime = 0;   // Store the last time a move was made
int currentPose = 0;               // Track the current pose

// Move function that progresses through the scenario
void Move() {
  unsigned long currentMillis = millis();
     PID_CHECK();

  if (currentMillis - lastMoveTime >= 1500) {  // Check if 1 second has passed
    lastMoveTime = currentMillis;  // Update the time for the next move
     PID_CHECK();
     GoToPose(currentPose); // Move to the next pose
     PID_CHECK();
     if((errorA<5)&&(errorB<5)){
       if (currentPose <= Stop_At_Pose_No)  currentPose++; // Proceed to next pose if error is small
     }  
  }
}

// PID control loop for Motor A and Motor B
void PID_CHECK()
{
 long now = micros();
  dt = (now - prevMicros) * 1e-6; // Time difference for PID calculation
  prevMicros = now;
  // PID Control for Motor A
   errorA = dc1 - angleA;
   dA = (errorA - prevErrorA) / dt; // Derivative term
  integralA += errorA * dt; // Integral term
  prevErrorA = errorA;
  uA = kpA * errorA + kiA * integralA + kdA * dA ; // PID output for Motor A
  pwmA = constrain((int)fabs(uA), 0, 180); // Constrain PWM value
  dirA = (uA > 0 ? 1 : (uA < 0 ? -1 : 0)); // Direction of Motor A
  
  if (fabs(errorA) <= 4.0) { // Stop Motor A if error is small
    pwmA = 0;
    dirA = 0;
    errorA = 0;
  }

  // PID Control for Motor B
   errorB = dc2 - angleB;
  dB = (errorB - prevErrorB) / dt;
  integralB += errorB * dt;
  prevErrorB = errorB;
  uB = kpB * errorB + kiB * integralB + kdB * dB; // PID output for Motor B
  pwmB = constrain((int)fabs(uB), 0, 180); // Constrain PWM value
  dirB = (uB > 0 ? 1 : (uB < 0 ? -1 : 0)); // Direction of Motor B
  
  if (fabs(errorB) <= 2.0) { // Stop Motor B if error is small
    pwmB = 0;
    dirB = 0;
    errorB = 0;
  }

    // Drive Motors
  driveMotor(CH_A, IN1_PIN_A, IN2_PIN_A, dirA, pwmA);
  driveMotor(CH_B, IN1_PIN_B, IN2_PIN_B, dirB, pwmB);
};

// Setup function for initial configurations
void setup() {
  Serial.begin(115200);
  delay(1500);
  
  // Initialize PWM Servo Driver
  board1.begin();
  board1.setOscillatorFrequency(27000000);
  board1.setPWMFreq(SERVO_FREQ);  // Analog servos run at ~50 Hz updates
  delay(100);
  
  // Pin Modes for limit switches and motor pins
  pinMode(limitSwitchPinA, INPUT_PULLUP);
  pinMode(limitSwitchPinB, INPUT_PULLUP);
  pinMode(IN1_PIN_A, OUTPUT);
  pinMode(IN2_PIN_A, OUTPUT);
  pinMode(IN1_PIN_B, OUTPUT);
  pinMode(IN2_PIN_B, OUTPUT);

  // PWM Setup for Motors A and B
  ledcSetup(CH_A, LEDC_FREQ, LEDC_RES);
  ledcAttachPin(PWM_PIN_A, CH_A);
  ledcSetup(CH_B, LEDC_FREQ, LEDC_RES);
  ledcAttachPin(PWM_PIN_B, CH_B);

  // Encoder Setup
  pinMode(ENCA_PIN_A, INPUT_PULLUP);
  pinMode(ENCB_PIN_A, INPUT_PULLUP);
  pinMode(ENCA_PIN_B, INPUT_PULLUP);
  pinMode(ENCB_PIN_B, INPUT_PULLUP);
  
  attachInterrupt(digitalPinToInterrupt(ENCA_PIN_A), readEncoderA, RISING);
  attachInterrupt(digitalPinToInterrupt(ENCA_PIN_B), readEncoderB, RISING);

  prevMicros = micros();

  // Initialize Arduino IoT Cloud
  initProperties();
  ArduinoCloud.begin(ArduinoIoTPreferredConnection);
  setDebugMessageLevel(2);
  ArduinoCloud.printDebugInfo();

  // Homing initialization
  HomedA = 0;
  HomedB = 0;
}

// Main loop function
void loop() {
  ArduinoCloud.update(); // Update IoT Cloud variables
   pulsesA = encoderPosA; // Update encoder pulses for Motor A
   pulsesB = encoderPosB; // Update encoder pulses for Motor B
  interrupts(); // Enable interrupts
  if (HomedA == 0)  dc1 = -500; // Move Motor A to home position if not already homed
  limit_switch_state = digitalRead(limitSwitchPinA); // Read limit switch for Motor A
  limit_switch_state1 = digitalRead(limitSwitchPinB); // Read limit switch for Motor B
   angleA = pulsesA * PULSES2DEG_A; // Calculate angle of Motor A
   angleB = pulsesB * PULSES2DEG_B; // Calculate angle of Motor B
  if ((limit_switch_state == 0) && (dc1 <= angleA)){ // If limit switch for Motor A is pressed
    pulsesA = 0;
    dc1 = 0;
    HomedA = 1;
    driveMotor(CH_A, IN1_PIN_A, IN2_PIN_A, 0, 0); // Stop Motor A
    angleA = 0;
  }

  if(_switch_){Move();} // For Switch between Automatic & Manual Control
  // Update servo positions
  SetServoAngle(0, angle1);
  SetServoAngle(1, angle2);
  SetServoAngle(2, angle3);
  // Update DC Motor Positions
  PID_CHECK(); 
  // Update Cloud Variables
  pWMA = pwmA * dirA;
  pWMB = pwmB * dirB;
  currentAngle1 = angleA;
  currentAngle2 = angleB;
}

// IoT Cloud Callbacks (ensure these match your thingProperties.h)
void onDc1Change() { Serial.print("Target A:"); Serial.println(dc1); }
void onDc2Change() { Serial.print("Target B:"); Serial.println(dc2); }
void onKpAChange() { Serial.print("KpA:"); Serial.println(kpA); }
void onKpBChange() { Serial.print("KpB:"); Serial.println(kpB); }
void onKiAChange() { Serial.print("KiA:"); Serial.println(kiA); }
void onKiBChange() { Serial.print("KiB:"); Serial.println(kiB); }
void onKdAChange() { Serial.print("KdA:"); Serial.println(kdA); }
void onKdBChange() { Serial.print("KdB:"); Serial.println(kdB); }
void onS1Change() { angle1 = s1; Serial.print("Servo1:"); Serial.println(angle1); }
void onS2Change() { angle2 = s2; Serial.print("Servo2:"); Serial.println(angle2); }
void onS3Change() { angle3 = s3; Serial.print("Servo3:"); Serial.println(angle3); }
void onPWMAChange() { /* Handle if needed */ }
void onPWMBChange() { /* Handle if needed */ }
void onSwitchChange()  {/* Handle if needed */ }