#include <TimerThree.h>
int driverPUL = 7;    // PUL+ pin
int driverDIR = 6;    // DIR+ pin
int pasos = 0;
void rts();
bool motorFlag = true;
bool driverPULsign = LOW;
void setup() {
  // put your setup code here, to run once:
  pinMode (driverPUL, OUTPUT);
  pinMode (driverDIR, OUTPUT);
  Timer3.initialize(6);  // every 6us
  Timer3.start();
  Timer3.attachInterrupt(rts);
}

void loop() {
  // put your main code here, to run repeatedly:
  
}

void rts(){
  if(motorFlag){
    if (pasos <= 25600){
      if(driverPULsign){
        digitalWrite(driverDIR,HIGH);
        digitalWrite(driverPUL,LOW);
        driverPULsign = LOW;
        pasos++;
      }else{
        digitalWrite(driverDIR,HIGH);
        digitalWrite(driverPUL,HIGH);
        driverPULsign = HIGH;          
      }
  }else{
    motorFlag = false;
  }
}
}
