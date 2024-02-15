import("stdfaust.lib");

WINDOW = 512;

transpose(w, x, s, sig) = de.fdelay(maxDelay,d,sig)*ma.fmin(d/x,1) +
    de.fdelay(maxDelay,d+w,sig)*(1-ma.fmin(d/x,1))
with {
    maxDelay = WINDOW;
    i = 1 - pow(2, s/12);
    d = i : (+ : +(w) : fmod(_,w)) ~ _;
};

filtre = vgroup("Filtre", fi.bandpass(1,hslider("fl", 200, 0, 20000, 10),hslider("fu", 8000, 0, 20000, 10)));

pitchsifter = vgroup("Pitch", transpose(
                        hslider("window", 1000, 50, 10000, 1),
                        hslider("xfade", 10, 1, 10000, 1),
                        hslider("shift", 0, -12, +12, 0.1)
 ) );

reverb = vgroup("Reverb", re.mono_freeverb(
                        hslider("fb1", 0.5, 0, 1, 0.01),
                        hslider("fb2", 0.5, 0, 1, 0.01),
                        hslider("damp", 0.5, 0, 1, 0.01),
                        hslider("spread", 0.5, 0, 1, 0.01)
                        ));

process = filtre : pitchsifter : reverb <: _,_ ;

VOIX RADIO:
filtrehigh = fi.highpass(1,800);
distortion = dm.cubicnl_demo;

filtre1 = fi.bandpass(1,0,99);
filtre2 = fi.bandpass(1,101,899);
filtre3 = fi.bandpass(1,901,2499);
equalizer = filtre1*(-5), filtre2*(-12), filtre3*(-40);

process = _<: distortion <: equalizer :> _ <: pitchshifter <: _,_;
// effet radio : process = _<: distortion <: equalizer :> _ <: pitchshifter <: _,_; peux modifier drive pour amplifier le son
// mais faire gaffe à ses oreilles pitchshifter sert pour donner voix aïgue ou grave 
