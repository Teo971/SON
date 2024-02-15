#include <Audio.h>
#include "Transpose.h"

Transpose tp;
AudioInputI2S in;
AudioOutputI2S out;
AudioControlSGTL5000 audioShield;
AudioConnection patchCord0(in,0,tp,0);
AudioConnection patchCord1(tp,0,out,0);
AudioConnection patchCord2(tp,1,out,1);

void setup() {
  Serial.begin(9600);
  pinMode(0, INPUT);
  AudioMemory(6);
  audioShield.enable();
  audioShield.inputSelect(AUDIO_INPUT_MIC);
  audioShield.micGain(10); // in dB
  audioShield.volume(0.8);
  tp.setParamValue("fl", 200);
  tp.setParamValue("fu", 10000);
  tp.setParamValue("window", 1000);
  tp.setParamValue("xfade", 10);
  Serial.println("Starting...");
}

void loop() {
  float shift = analogRead(A0)/42.625 - 12.0;
  Serial.println(shift);
  //float shift = random(-120,120)/10.0;
  //float shift = 3.0;
  tp.setParamValue("shift",shift);
  delay(500);
}
