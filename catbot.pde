#include <Wire.h>
#include <string.h>
#include <stdio.h>
#include <wiinunchuck.h>

int servoPinX = 6;
int servoPinY = 7;

int pulseWidthX = 1200;
int pulseWidthY = 1200;

int minPulseX = 900;
int minPulseY = 900;

long lastPulse = 0;
int refreshTime = 10;

void setup()
{
   Serial.begin(19200);
   nunchuk_setpowerpins ();
   nunchuk_init ();
   nunchuk_calibrate_joy ();
   updateServo ();
   Serial.print ("Finished setup\n");
   delay(3000);
}

void loop()
{
  nunchuk_get_data ();
  int x = nunchuk_joy_x ();
  int y = nunchuk_joy_y ();
  int xc = nunchuk_cjoy_x ();
  int yc = nunchuk_cjoy_y ();
  
  Serial.print ("X: ");
  Serial.print (x, DEC);
  Serial.print ("\t");
  
  Serial.print ("Y: ");
  Serial.print (y, DEC);
  Serial.print ("\t");
  
  Serial.print ("X-Calibrated: ");
  Serial.print (xc, DEC);
  Serial.print ("\t");
  
  Serial.print ("Y-Calibrated: ");
  Serial.print (yc, DEC);
  Serial.print ("\t");
  
  Serial.print ("\r\n");
  setDegrees ();
  updateServo ();
//:  delay(100);
}

void updateServo() {

    if (millis() - lastPulse >= refreshTime) {

        digitalWrite(servoPinX, HIGH);
//        delayMicroseconds(2100);
        delayMicroseconds(pulseWidthX);
        digitalWrite(servoPinX, LOW);

        digitalWrite(servoPinY, HIGH);
        delayMicroseconds(pulseWidthY);
//        delayMicroseconds(2100);
        digitalWrite(servoPinY, LOW);

        lastPulse = millis();
    }
}

void setDegrees () {
  
  int xpos = nunchuk_cjoy_x ();
  int ypos = nunchuk_cjoy_y ();
  if (xpos > 170) {
    pulseWidthX = pulseWidthX + 28;
  }
  if (xpos < 115) {
    pulseWidthX = pulseWidthX - 28;
  }
   if (ypos > 170) {
    pulseWidthY = pulseWidthY + 28;
   }
  if (ypos < 115) {
    pulseWidthY = pulseWidthY - 28;
  }
  
  
  
}

  
