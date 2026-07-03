% Simscape(TM) Multibody(TM) version: 24.1

% This is a model data file derived from a Simscape Multibody Import XML file using the smimport function.
% The data in this file sets the block parameter values in an imported Simscape Multibody model.
% For more information on this file, see the smimport function help page in the Simscape Multibody documentation.
% You can modify numerical values, but avoid any other changes to this file.
% Do not add code to this file. Do not edit the physical units shown in comments.

%%%VariableName:smiData


%============= RigidTransform =============%

%Initialize the RigidTransform structure array by filling in null values.
smiData.RigidTransform(13).translation = [0.0 0.0 0.0];
smiData.RigidTransform(13).angle = 0.0;
smiData.RigidTransform(13).axis = [0.0 0.0 0.0];
smiData.RigidTransform(13).ID = "";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(1).translation = [37.689160925797509 15.797764653743371 31.670473087916182];  % mm
smiData.RigidTransform(1).angle = 6.8117176503252188e-15;  % rad
smiData.RigidTransform(1).axis = [-0.96232029674741271 -0.27191845554866534 8.9122010033730459e-16];
smiData.RigidTransform(1).ID = "B[Joint-3:1:-:Joint-2:1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(2).translation = [-196.74573476277993 -209.82549404200716 328.78222383136585];  % mm
smiData.RigidTransform(2).angle = 2.0943951023931926;  % rad
smiData.RigidTransform(2).axis = [0.57735026918962751 0.57735026918962484 0.57735026918962495];
smiData.RigidTransform(2).ID = "F[Joint-3:1:-:Joint-2:1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(3).translation = [-196.74573476277885 -80.704550146631419 180.26279127262495];  % mm
smiData.RigidTransform(3).angle = 2.0943951023931953;  % rad
smiData.RigidTransform(3).axis = [-0.57735026918962773 -0.57735026918962562 0.57735026918962384];
smiData.RigidTransform(3).ID = "B[Joint-2:1:-:base2:1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(4).translation = [-17.376398094364678 -46.498174838763902 -9.3776536359665368];  % mm
smiData.RigidTransform(4).angle = 2.0246965163343926;  % rad
smiData.RigidTransform(4).axis = [-0.55210408450460968 -0.62478969241226112 -0.55210408450646242];
smiData.RigidTransform(4).ID = "F[Joint-2:1:-:base2:1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(5).translation = [35.122596631927181 -13.621997268571253 97.49999959359954];  % mm
smiData.RigidTransform(5).angle = 3.1415926535897931;  % rad
smiData.RigidTransform(5).axis = [1 0 0];
smiData.RigidTransform(5).ID = "B[base1:1:-:]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(6).translation = [0 -7.1054273576010019e-15 0];  % mm
smiData.RigidTransform(6).angle = 3.1415926535897931;  % rad
smiData.RigidTransform(6).axis = [-1 -4.4408920985006252e-16 0];
smiData.RigidTransform(6).ID = "F[base1:1:-:]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(7).translation = [-266.70697969954267 -67.337106595119337 -35.377653636630171];  % mm
smiData.RigidTransform(7).angle = 4.3027792524629431e-15;  % rad
smiData.RigidTransform(7).axis = [-0.79984724908307903 -0.60020361389634358 1.0328202198947792e-15];
smiData.RigidTransform(7).ID = "B[base2:1:-:base1:1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(8).translation = [35.122596631927152 -13.621997268571246 91.49999959360018];  % mm
smiData.RigidTransform(8).angle = 1.23757608348643e-16;  % rad
smiData.RigidTransform(8).axis = [-3.2369196025832665e-15 1 -2.0029671421627253e-31];
smiData.RigidTransform(8).ID = "F[base2:1:-:base1:1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(9).translation = [39.999999999999943 1.7763568394002505e-14 -32.600000000000051];  % mm
smiData.RigidTransform(9).angle = 8.8817841970012582e-16;  % rad
smiData.RigidTransform(9).axis = [0 1 0];
smiData.RigidTransform(9).ID = "B[Servo holder link 3 link 3 (end effector) :1:-:Servo holder link 2 link 3:1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(10).translation = [-35.300000000000203 32.50000000000005 2.7533531010703882e-13];  % mm
smiData.RigidTransform(10).angle = 2.0943951023931966;  % rad
smiData.RigidTransform(10).axis = [0.57735026918962606 -0.57735026918962518 0.57735026918962595];
smiData.RigidTransform(10).ID = "F[Servo holder link 3 link 3 (end effector) :1:-:Servo holder link 2 link 3:1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(11).translation = [37.689160925799925 -156.00223534625638 35.670473087916676];  % mm
smiData.RigidTransform(11).angle = 4.9174116273094282e-15;  % rad
smiData.RigidTransform(11).axis = [-0.98351043947417705 -0.18085136285168255 4.3732804436586238e-16];
smiData.RigidTransform(11).ID = "B[Joint-3:1:-:Servo holder link 2 link 3:1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(12).translation = [40.000000000000306 -6.0396132539608516e-14 21.000000000000128];  % mm
smiData.RigidTransform(12).angle = 3.1415926535897927;  % rad
smiData.RigidTransform(12).axis = [1 -3.1874996751857749e-32 -1.8197540503943335e-16];
smiData.RigidTransform(12).ID = "F[Joint-3:1:-:Servo holder link 2 link 3:1]";

%Translation Method - Cartesian
%Rotation Method - Arbitrary Axis
smiData.RigidTransform(13).translation = [123.59176256998194 214.27288669243794 9.8646501564888904];  % mm
smiData.RigidTransform(13).angle = 1.5707963267948972;  % rad
smiData.RigidTransform(13).axis = [8.8003362179489178e-17 -8.8003362179489129e-17 -1];
smiData.RigidTransform(13).ID = "SixDofRigidTransform[Chair:1]";


%============= Solid =============%
%Center of Mass (CoM) %Moments of Inertia (MoI) %Product of Inertia (PoI)

%Initialize the Solid structure array by filling in null values.
smiData.Solid(7).mass = 0.0;
smiData.Solid(7).CoM = [0.0 0.0 0.0];
smiData.Solid(7).MoI = [0.0 0.0 0.0];
smiData.Solid(7).PoI = [0.0 0.0 0.0];
smiData.Solid(7).color = [0.0 0.0 0.0];
smiData.Solid(7).opacity = 0.0;
smiData.Solid(7).ID = "";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(1).mass = 1.162035111874135;  % lbm
smiData.Solid(1).CoM = [214.27288669243796 -99.194991549070949 168.03829835254916];  % mm
smiData.Solid(1).MoI = [17455.511743884097 16242.001837089669 13888.263016268174];  % lbm*mm^2
smiData.Solid(1).PoI = [-3268.8080973457049 1.7324000011988958e-10 -1.2832592601473302e-11];  % lbm*mm^2
smiData.Solid(1).color = [0.62745098039215685 0.15686274509803921 0];
smiData.Solid(1).opacity = 1;
smiData.Solid(1).ID = "Chair.ipt_{54A09AA5-4ECA-C890-C318-03B2E4A9DAEF}";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(2).mass = 0.079938406805676571;  % kg
smiData.Solid(2).CoM = [-207.02937670730216 -144.22337495406327 258.57081636128731];  % mm
smiData.Solid(2).MoI = [584.17472540425365 316.78565619925502 273.07366643693967];  % kg*mm^2
smiData.Solid(2).PoI = [280.71964583836672 0.24099837131434471 0.17955982701641915];  % kg*mm^2
smiData.Solid(2).color = [0.74901960784313726 0.74901960784313726 0.74901960784313726];
smiData.Solid(2).opacity = 1;
smiData.Solid(2).ID = "Joint-2.ipt_{58967D33-46F2-F874-62C5-6DBDB5B690B4}";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(3).mass = 0.13408493415764486;  % kg
smiData.Solid(3).CoM = [37.616135194518364 -61.188290647993966 53.6066515020417];  % mm
smiData.Solid(3).MoI = [514.08031177755254 32.882490070776932 510.0657960875692];  % kg*mm^2
smiData.Solid(3).PoI = [17.316697841792028 -0.14272627640411883 1.0901488078064177];  % kg*mm^2
smiData.Solid(3).color = [0.74901960784313726 0.74901960784313726 0.74901960784313726];
smiData.Solid(3).opacity = 1;
smiData.Solid(3).ID = "Joint-3.ipt_{275A074D-4A78-4B01-144B-4BAE02812456}";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(4).mass = 0.085903740407709067;  % lbm
smiData.Solid(4).CoM = [-0.74470362289376046 -4.0832554532472498 0.2270088995103135];  % mm
smiData.Solid(4).MoI = [39.54788781920314 88.673650973886311 63.877273834145051];  % lbm*mm^2
smiData.Solid(4).PoI = [-0.079627211693414718 -0.7945589439471209 -8.9159223967899841];  % lbm*mm^2
smiData.Solid(4).color = [1 1 0];
smiData.Solid(4).opacity = 1;
smiData.Solid(4).ID = "Servo holder link 2 link 3.ipt_{06FCD179-4A79-9825-8B5C-729B06CC8850}";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(5).mass = 0.055830113643299567;  % lbm
smiData.Solid(5).CoM = [13.946886697094241 0 0.34929023606088361];  % mm
smiData.Solid(5).MoI = [32.992481606184207 41.868127662784751 12.644313443568212];  % lbm*mm^2
smiData.Solid(5).PoI = [0 -0.50805951085563916 0];  % lbm*mm^2
smiData.Solid(5).color = [1 1 0];
smiData.Solid(5).opacity = 1;
smiData.Solid(5).ID = "Servo holder link 3 link 3 (end effector) .ipt_{4FE69D01-4832-BA09-D58D-9EA6F54E9158}";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(6).mass = 3.2816911153982393;  % kg
smiData.Solid(6).CoM = [-7.0046496545334129 -13.272960232262204 69.138408570620641];  % mm
smiData.Solid(6).MoI = [90193.718448608211 129271.41890421536 218090.77365164648];  % kg*mm^2
smiData.Solid(6).PoI = [-19.886517431748143 -1863.601140019545 -48.253885823838893];  % kg*mm^2
smiData.Solid(6).color = [0.74901960784313726 0.74901960784313726 0.74901960784313726];
smiData.Solid(6).opacity = 1;
smiData.Solid(6).ID = "base1.ipt_{6561A7ED-43E2-C5A8-67F9-A7AF27C11FF3}";

%Inertia Type - Custom
%Visual Properties - Simple
smiData.Solid(7).mass = 0.10132831515153373;  % kg
smiData.Solid(7).CoM = [-19.036272883064179 -19.374618360258417 -21.656566063137355];  % mm
smiData.Solid(7).MoI = [113.68736616243673 74.413661485553632 130.45554045245558];  % kg*mm^2
smiData.Solid(7).PoI = [7.4550936857542522 1.5737546935571005 7.73141370030699];  % kg*mm^2
smiData.Solid(7).color = [0.74901960784313726 0.74901960784313726 0.74901960784313726];
smiData.Solid(7).opacity = 1;
smiData.Solid(7).ID = "base2.ipt_{916E7763-4E0C-602A-32C9-45B28E3351C7}";


%============= Joint =============%
%X Revolute Primitive (Rx) %Y Revolute Primitive (Ry) %Z Revolute Primitive (Rz)
%X Prismatic Primitive (Px) %Y Prismatic Primitive (Py) %Z Prismatic Primitive (Pz) %Spherical Primitive (S)
%Constant Velocity Primitive (CV) %Lead Screw Primitive (LS)
%Position Target (Pos)

%Initialize the RevoluteJoint structure array by filling in null values.
smiData.RevoluteJoint(5).Rz.Pos = 0.0;
smiData.RevoluteJoint(5).ID = "";

smiData.RevoluteJoint(1).Rz.Pos = 69.315172957593418;  % deg
smiData.RevoluteJoint(1).ID = "[Joint-3:1:-:Joint-2:1]";

smiData.RevoluteJoint(2).Rz.Pos = 158.67828297714709;  % deg
smiData.RevoluteJoint(2).ID = "[Joint-2:1:-:base2:1]";

smiData.RevoluteJoint(3).Rz.Pos = -21.461336114005281;  % deg
smiData.RevoluteJoint(3).ID = "[base2:1:-:base1:1]";

smiData.RevoluteJoint(4).Rz.Pos = 98.246103190162316;  % deg
smiData.RevoluteJoint(4).ID = "[Servo holder link 3 link 3 (end effector) :1:-:Servo holder link 2 link 3:1]";

smiData.RevoluteJoint(5).Rz.Pos = 119.70457743963932;  % deg
smiData.RevoluteJoint(5).ID = "[Joint-3:1:-:Servo holder link 2 link 3:1]";

