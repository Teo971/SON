#include <Audio.h>
#include "dspVocoder.h"

dspVocoder dsp;
AudioInputI2S in;
AudioOutputI2S out;
AudioControlSGTL5000 audioShield;
AudioConnection patchCord0(in,0,dsp,0);
AudioConnection patchCord1(dsp,0,out,0);
AudioConnection patchCord2(dsp,1,out,1);
float vol;
float preset;
float vol_prec;
int changement;

void setup() {
  Serial.begin(9600);
  AudioMemory(6);
  audioShield.enable();
  audioShield.inputSelect(AUDIO_INPUT_MIC);
  audioShield.micGain(10); // in dB
  audioShield.volume(0.8);
  Serial.println("Starting...");
  vol = analogRead(A1)/1000.0;
}

void loop() {
  // Réglage du volume à l'aide d'un potentiomètre
  vol_prec = vol;
  vol = analogRead(A1)/1000.0;
  if (abs(vol-vol_prec)>= 0.02){
    Serial.println("Volume :");
    Serial.println(vol);
    audioShield.volume(vol);
  } 

  // Choix du préset avec un potentiomètre
  preset = analogRead(A0)/204.8 ;
  //Serial.println(preset);
  
  // Voix type radio
  if (preset<1){
    if (changement != 1){
      Serial.println("Voix choisie : radio");
      radio();     
    }
    changement = 1;
  }

  // Voix type podcast
  if (preset<2 and preset >= 1){
    if (changement != 2){
      Serial.println("Voix choisie : podcast");
      podcast();
    }
    changement = 2;
  }

  // Voix type robot
  if (preset<3 and preset >= 2){
    if (changement !=3){
      Serial.println("Voix choisie : robot");
      robot();
    }
    changement = 3;
  }

  // Voix type chipmunks
  if (preset<4 and preset >= 3){
    if (changement != 4){
      Serial.println("Voix choisie : chipmunks");
      chipmunks();
      
    }
    changement = 4;
  }

  // Voix type méchant
  if (preset >= 4){
    if (changement != 5){
      Serial.println("Voix choisie : méchant");
      mechant();
      
    }
    changement = 5;
  } 
  delay(500);
}


void radio(){  
      dsp.setParamValue("window",500);
      dsp.setParamValue("xfade",10);
      dsp.setParamValue("shift",0);
      
      dsp.setParamValue("drive",0.2);
      dsp.setParamValue("offset",0);
      
      dsp.setParamValue("f1",50);
      dsp.setParamValue("bw1",100);
      dsp.setParamValue("x1",-5);
      
      dsp.setParamValue("f2",500);
      dsp.setParamValue("bw2",800);
      dsp.setParamValue("x2",-12);
      
      dsp.setParamValue("f3",1700);
      dsp.setParamValue("bw3",1600);
      dsp.setParamValue("x3",-40);
      
      dsp.setParamValue("f4",2750);
      dsp.setParamValue("bw4",500);
      dsp.setParamValue("x4",0);
      
      dsp.setParamValue("f5",3250);
      dsp.setParamValue("bw5",500);
      dsp.setParamValue("x5",0);
      
      dsp.setParamValue("f6",3630);
      dsp.setParamValue("bw6",260);
      dsp.setParamValue("x6",0);
      
      dsp.setParamValue("f7",3880);
      dsp.setParamValue("bw7",240);
      dsp.setParamValue("x7",0);
      
      dsp.setParamValue("f8",7000);
      dsp.setParamValue("bw8",6000);
      dsp.setParamValue("x8",0);
      
      dsp.setParamValue("f9",15000);
      dsp.setParamValue("bw9",10000);
      dsp.setParamValue("x9",0);
}

void podcast(){
      dsp.setParamValue("window",500);
      dsp.setParamValue("xfade",10);
      dsp.setParamValue("shift",0);
      
      dsp.setParamValue("drive",0);
      dsp.setParamValue("offset",0);
  
      dsp.setParamValue("f1",150);
      dsp.setParamValue("bw1",100);
      dsp.setParamValue("x1",-12);
      
      dsp.setParamValue("f2",250);
      dsp.setParamValue("bw2",100);
      dsp.setParamValue("x2",0);
      
      dsp.setParamValue("f3",350);
      dsp.setParamValue("bw3",100);
      dsp.setParamValue("x3",-3);
      
      dsp.setParamValue("f4",550);
      dsp.setParamValue("bw4",300);
      dsp.setParamValue("x4",0);
      
      dsp.setParamValue("f5",850);
      dsp.setParamValue("bw5",300);
      dsp.setParamValue("x5",3);
      
      dsp.setParamValue("f6",1500);
      dsp.setParamValue("bw6",1000);
      dsp.setParamValue("x6",0);
      
      dsp.setParamValue("f7",3000);
      dsp.setParamValue("bw7",2000);
      dsp.setParamValue("x7",12);
      
      dsp.setParamValue("f8",7000);
      dsp.setParamValue("bw8",6000);
      dsp.setParamValue("x8",2);
      
      dsp.setParamValue("f9",15000);
      dsp.setParamValue("bw9",10000);
      dsp.setParamValue("x9",0);
}

void robot(){
      dsp.setParamValue("window",500);
      dsp.setParamValue("xfade",10);
      dsp.setParamValue("shift",5);
      
      dsp.setParamValue("drive",0);
      dsp.setParamValue("offset",0);
  
      dsp.setParamValue("x1",0);
      dsp.setParamValue("x2",0);
      dsp.setParamValue("x3",0);
      dsp.setParamValue("x4",0);
      dsp.setParamValue("x5",0);
      dsp.setParamValue("x6",0);
      dsp.setParamValue("x7",0);
      dsp.setParamValue("x8",0);
      dsp.setParamValue("x9",0);
}

void chipmunks(){
      dsp.setParamValue("window",300);
      dsp.setParamValue("xfade",100);
      dsp.setParamValue("shift",12);
      
      dsp.setParamValue("drive",0);
      dsp.setParamValue("offset",0);
            
      dsp.setParamValue("f1",150);
      dsp.setParamValue("bw1",100);
      dsp.setParamValue("x1",10);
      
      dsp.setParamValue("f2",250);
      dsp.setParamValue("bw2",100);
      dsp.setParamValue("x2",10);
      
      dsp.setParamValue("f3",350);
      dsp.setParamValue("bw3",100);
      dsp.setParamValue("x3",10);
      
      dsp.setParamValue("f4",550);
      dsp.setParamValue("bw4",300);
      dsp.setParamValue("x4",0);
      
      dsp.setParamValue("f5",850);
      dsp.setParamValue("bw5",300);
      dsp.setParamValue("x5",0);
      
      dsp.setParamValue("f6",1500);
      dsp.setParamValue("bw6",1000);
      dsp.setParamValue("x6",0);
      
      dsp.setParamValue("f7",3000);
      dsp.setParamValue("bw7",2000);
      dsp.setParamValue("x7",0);
      
      dsp.setParamValue("f8",7000);
      dsp.setParamValue("bw8",6000);
      dsp.setParamValue("x8",0);
      
      dsp.setParamValue("f9",15000);
      dsp.setParamValue("bw9",10000);
      dsp.setParamValue("x9",0);  
}

void mechant(){
      dsp.setParamValue("window",400);
      dsp.setParamValue("xfade",200);
      dsp.setParamValue("shift",-4);
      
      dsp.setParamValue("drive",0.1);
      dsp.setParamValue("offset",0);
      
      dsp.setParamValue("f1",150);
      dsp.setParamValue("bw1",100);
      dsp.setParamValue("x1",10);
      
      dsp.setParamValue("f2",250);
      dsp.setParamValue("bw2",100);
      dsp.setParamValue("x2",10);
      
      dsp.setParamValue("f3",350);
      dsp.setParamValue("bw3",100);
      dsp.setParamValue("x3",10);
      
      dsp.setParamValue("f4",550);
      dsp.setParamValue("bw4",300);
      dsp.setParamValue("x4",10);
      
      dsp.setParamValue("f5",850);
      dsp.setParamValue("bw5",300);
      dsp.setParamValue("x5",0);
      
      dsp.setParamValue("f6",1500);
      dsp.setParamValue("bw6",1000);
      dsp.setParamValue("x6",0);
      
      dsp.setParamValue("f7",3000);
      dsp.setParamValue("bw7",2000);
      dsp.setParamValue("x7",0);
      
      dsp.setParamValue("f8",7000);
      dsp.setParamValue("bw8",6000);
      dsp.setParamValue("x8",0);
      
      dsp.setParamValue("f9",15000);
      dsp.setParamValue("bw9",10000);
      dsp.setParamValue("x9",0); 
}





// ALL PARAMETERS
//      dsp.setParamValue("window",);
//      dsp.setParamValue("xfade",);
//      dsp.setParamValue("shift",);
//      
//      dsp.setParamValue("drive",);
//      dsp.setParamValue("offset",);
//      
//      dsp.setParamValue("f1",);
//      dsp.setParamValue("bw1",);
//      dsp.setParamValue("x1",);
//      
//      dsp.setParamValue("f2",);
//      dsp.setParamValue("bw2",);
//      dsp.setParamValue("x2",);
//      
//      dsp.setParamValue("f3",);
//      dsp.setParamValue("bw3",);
//      dsp.setParamValue("x3",);
//      
//      dsp.setParamValue("f4",);
//      dsp.setParamValue("bw4",);
//      dsp.setParamValue("x4",);
//      
//      dsp.setParamValue("f5",);
//      dsp.setParamValue("bw5",);
//      dsp.setParamValue("x5",);
//      
//      dsp.setParamValue("f6",);
//      dsp.setParamValue("bw6",);
//      dsp.setParamValue("x6",);
//      
//      dsp.setParamValue("f7",);
//      dsp.setParamValue("bw7",);
//      dsp.setParamValue("x7",);
//      
//      dsp.setParamValue("f8",);
//      dsp.setParamValue("bw8",);
//      dsp.setParamValue("x8",);
//      
//      dsp.setParamValue("f9",);
//      dsp.setParamValue("bw9",);
//      dsp.setParamValue("x9",);
