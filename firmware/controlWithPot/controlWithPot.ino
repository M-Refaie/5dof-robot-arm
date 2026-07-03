#include <PID_v1.h>

// Motor Control Pins
#define IN1       6
#define IN2       7
#define ENA       5

// Encoder Pins
#define ENCODER_A 2
#define ENCODER_B 3

// Potentiometer Pin
#define POT_PIN   A0

// PID Constants (tune these)
double Kp = 1.2;
double Ki = 0.085;
double Kd = 1.0;

// PID Variables
double Setpoint = 0.0;    // will be set from pot
double Input;             // Measured position (°)
double Output;            // PID output (-255…255)

PID myPID(&Input, &Output, &Setpoint, Kp, Ki, Kd, DIRECT);

volatile long encoderPos = 0;
const float degreesPerPulse = 360.0 / 11560.0;  // set to your encoder CPR×gear ratio

void setup() {
  Serial.begin(9600);

  // Print header for Serial Plotter once
  Serial.println("Setpoint Input Output");

  // Motor pins
  pinMode(IN1, OUTPUT);
  pinMode(IN2, OUTPUT);
  pinMode(ENA, OUTPUT);

  // Encoder pins
  pinMode(ENCODER_A, INPUT_PULLUP);
  pinMode(ENCODER_B, INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(ENCODER_A), updateEncoder, CHANGE);

  // Potentiometer input
  pinMode(POT_PIN, INPUT);

  // PID setup
  myPID.SetMode(AUTOMATIC);
  myPID.SetOutputLimits(-255, 255);
}

void loop() {
  // 1) Read potentiometer and map 0–1023 to 0–360°
  int potRaw = analogRead(POT_PIN);
  Setpoint = (potRaw / 1023.0) * 360.0;

  // 2) Convert encoder count to degrees
  noInterrupts();
    long counts = encoderPos;
  interrupts();
  Input = counts * degreesPerPulse;

  // 3) Compute PID
  myPID.Compute();

  // 4) Drive motor
  if (Output > 0) {
    digitalWrite(IN1, HIGH);
    digitalWrite(IN2, LOW);
    analogWrite(ENA, (int)Output);
  } else if (Output < 0) {
    digitalWrite(IN1, LOW);
    digitalWrite(IN2, HIGH);
    analogWrite(ENA, (int)(-Output));
  } else {
    analogWrite(ENA, 0);
  }

  // 5) Send data for Serial Plotter
  //    Format: Setpoint<space>Input<space>Output<newline>
  Serial.print(Setpoint, 1);
  Serial.print(" ");
  Serial.print(Input, 1);
  Serial.print(" ");
  Serial.println(Output, 1);

  delay(10);  // adjust loop rate if needed
}

void updateEncoder() {
  // Quadrature decode on A-change
  if (digitalRead(ENCODER_A) == digitalRead(ENCODER_B))
    encoderPos++;
  else
    encoderPos--;
}
