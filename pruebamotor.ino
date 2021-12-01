#include <TimerThree.h>
#include <OneWire.h>
#include <DallasTemperature.h>
#include <PID_v1.h>
#include <OneWire.h>
#include "HX711.h"
#include <Wire.h>
#include <LiquidCrystal_I2C.h>
LiquidCrystal_I2C lcd(0x27, 16, 2);

uint8_t N = 9; //Cantidad de datos que vas tomando
uint16_t buffer1[2] = {0};
uint16_t sendBuffer[9] = {0};

bool sendFlag = false;
bool matlabFlag = false;
bool tempFlag = false;
bool motorFlag = false;
bool defaultFlag = false;
bool datosFlag = false;
bool bufferFlag = false;
bool manualFlag = false;
bool creepFlag = false;
bool distraccionFlag = false;
bool traccionFlag = false;
bool relajacionFlag = false;
//bool avisoTempFlag = true;

// Pin donde se conecta el bus 1-Wire
//Sensor de temperatura
const int pinDatosDQ = 0;
// Para el PID
#define PIN_INPUT 0 //la temperatura
#define PIN_OUTPUT 3 //el mosfet que controla las resistencias
//Define Variables we'll be connecting to
double Setpoint, Input, Output;
// Para la celda de carga
const int DOUT=A1;
const int CLK=A0;
double peso;
String routineCode;
int frequencySpeedLow;
int frequencySpeedHigh;
double frequencySpeed;
double periodSpeed;
int frequencyLow;
int frequencyHigh;
double frequency;
int loadLow;
int loadHigh;
double load;
int defLow;
int defHigh;
double deformacion;
double period;
int routineCodeInt;
double contadorDeVueltas = 0; //double o float
double contadorDeVueltasDistraccion = 0;
double contadorDeVueltasTraccion = 0;
int checksum;
int pasos;
double displMaxLow;
double displMaxHigh;
double displMax;
double paso = 0.072; //[mm] revisar el paso -> paso cuando tengo 25.000 microsteps 
long precarga;
int setButtonState = 0;
int upButtonState = 0;
int downButtonState = 0;
int variableOpcional;
double pasosInicial;

OneWire oneWireObjeto(pinDatosDQ);
DallasTemperature sensorDS18B20(&oneWireObjeto);

//Specify the links and initial tuning parameters
double Kp=211, Ki=0.1, Kd=0.0252;
PID myPID(&Input, &Output, &Setpoint, Kp, Ki, Kd, DIRECT);

HX711 balanza;

void rts();
void sendData();
void distraccion();
void rupturaDeMuestra();
void defaultState();
void creep();
void relajacion();
void traccion();

// Define pins
//int reverseSwitch = 2;  // Push button for reverse 
int driverPUL = 7;    // PUL- pin
int driverDIR = 6;    // DIR- pin

const int upButtonPin =4 ;     // the number of the pushbutton pin
//const int setButtonPin =2 ;
const int downButtonPin =5 ;
int flag;


// Variables
double pd = 50;       // Pulse Delay period //inversa de la frecuencia //esta en microsegundos
boolean setdir = LOW; // Set Direction

void setup() {

  pinMode (driverPUL, OUTPUT);
  pinMode (driverDIR, OUTPUT);
  pinMode(upButtonPin, INPUT);
  pinMode(downButtonPin, INPUT);
  
  Serial.begin(1000000);
                          // initialize the lcd
 
}

void loop() {
  upButtonState = digitalRead(upButtonPin);
  downButtonState = digitalRead(downButtonPin);
  
  if(upButtonState == LOW){
    flag = 0;
    while(flag < 12500){
      digitalWrite(driverDIR,HIGH);
      digitalWrite(driverPUL,HIGH);
      delayMicroseconds(pd);
      digitalWrite(driverPUL,LOW);
      delayMicroseconds(pd);
      flag++;
      }
  }
  if(downButtonState == LOW){
    flag = 0;
    while(flag < 12500){
      digitalWrite(driverDIR,LOW);
      digitalWrite(driverPUL,HIGH);
      delayMicroseconds(pd);
      digitalWrite(driverPUL,LOW);
      delayMicroseconds(pd);
      flag++;
      }
  }
  
    
  }
