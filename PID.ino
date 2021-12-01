/********************************************************
 * PID Basic Example
 * Reading analog input 0 to control analog PWM output 3
 ********************************************************/

#include <PID_v1.h>

#include <OneWire.h>
#include <DallasTemperature.h>

#define PIN_INPUT 9
#define PIN_OUTPUT 11
#define PIN_RELE 1

// Instancia a las clases OneWire y DallasTemperature
OneWire oneWireObjeto(PIN_INPUT);
DallasTemperature sensorDS18B20(&oneWireObjeto);

//Define Variables we'll be connecting to
double Setpoint, Input, Output;

//Specify the links and initial tuning parameters
double Kp=20, Ki=0, Kd=0;
PID myPID(&Input, &Output, &Setpoint, Kp, Ki, Kd, DIRECT);

void setup()
{
  // Iniciamos la comunicación serie
  Serial.begin(9600);
  // Iniciamos el bus 1-Wire
  sensorDS18B20.begin();
  pinMode(PIN_RELE,OUTPUT);
  digitalWrite(PIN_RELE,HIGH);
  //initialize the variables we're linked to
  Input = sensorDS18B20.getTempCByIndex(1);
  Setpoint = 37;

  //turn the PID on
  myPID.SetMode(AUTOMATIC);
  
}

void loop()
{
  // Mandamos comandos para toma de temperatura a los sensores
  sensorDS18B20.requestTemperatures();

  // Leemos y mostramos los datos de los sensores DS18B2

  Input = sensorDS18B20.getTempCByIndex(1);
  
  if(Input != -127.00){
    Serial.print("Temperatura sensor 1: ");
    Serial.print(Input);
    Serial.println(" C");
    myPID.Compute();
    analogWrite(PIN_OUTPUT, Output);
    Serial.println(Output);
  }
  
  
}
