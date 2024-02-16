import("stdfaust.lib");

WINDOW = 512;

transpose(w, x, s, sig) = de.fdelay(maxDelay,d,sig)*ma.fmin(d/x,1) +
    de.fdelay(maxDelay,d+w,sig)*(1-ma.fmin(d/x,1))
with {
    maxDelay = WINDOW;
    i = 1 - pow(2, s/12);
    d = i : (+ : +(w) : fmod(_,w)) ~ _;
};

filtre = fi.bandpass(1,nentry("low", 200, 0, 20000, 10),nentry("up", 8000, 0, 20000, 10));

pitchshifter = vgroup("Pitch", transpose(
                        nentry("window", 1000, 50, 10000, 1),
                        nentry("xfade", 10, 1, 10000, 1),
                        nentry("shift", 0, -12, +12, 0.1)
 ) );

reverb = vgroup("Reverb", re.mono_freeverb(
                        nentry("fb1", 0, 0, 1, 0.01),
                        nentry("fb2", 0, 0, 1, 0.01),
                        nentry("damp", 0.5, 0, 1, 0.01),
                        nentry("spread", 0.5, 0, 1, 0.01)
                        ));

filtrehigh = fi.highpass(1,800); //fi.highpass(1,nentry("high", 800, 0, 20000, 1));


distortion = dm.cubicnl_demo; //cubicnl(nentry("drive", 0, 0, 1, 0.01),nentry("offset", 0, 0, 1, 0.01));

filtre1 = fi.bandpass(1,0,99); //fi.bandpass(1,nentry("low1", 0, 0, 20000, 1),nentry("up1", 99, 0, 20000, 1));
filtre2 = fi.bandpass(1,101,899); //fi.bandpass(1,nentry("low2", 101, 0, 20000, 1),nentry("up2", 899, 0, 20000, 1));
filtre3 = fi.bandpass(1,901,2499); //fi.bandpass(1,nentry("low3", 901, 0, 20000, 1),nentry("up3", 2499, 0, 20000, 1));
equalizer = filtre1*(-5), filtre2*(-12), filtre3*(-40); //filtre1*nentry("x1", -5, -100, 100, 1), filtre2*nentry("x2", -12, -100, 100, 1), filtre3*nentry("x3", -40, -100, 100, 1); 

process = _<: distortion <: equalizer :> _ <: pitchshifter <: _,_;

//equalizer voix de podcast 
f1 = fi.bandpass(1,100,200)*(-12);
f2 = fi.bandpass(1,200,300);
f3 = fi.bandpass(1,300,400)*(-3);
f4 = fi.bandpass(1,400,700);
f5 = fi.bandpass(1,700,1000)*3;
f6 = fi.bandpass(1,1000,2000);
f7 = fi.bandpass(1,2000,4000)*12;
f8 = fi.bandpass(1,4000,10000)*2;
f9 = fi.bandpass(1,10000,20000);

f = f1,f2,f3,f4,f5,f6,f7,f8,f9;
process = _<: f :> _ <: _,_;
//process = _,_;
// mixage voix podcast
