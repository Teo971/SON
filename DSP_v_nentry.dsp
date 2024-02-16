import("stdfaust.lib");

WINDOW = 512;

transpose(w, x, s, sig) = de.fdelay(maxDelay,d,sig)*ma.fmin(d/x,1) +
    de.fdelay(maxDelay,d+w,sig)*(1-ma.fmin(d/x,1))
with {
    maxDelay = WINDOW;
    i = 1 - pow(2, s/12);
    d = i : (+ : +(w) : fmod(_,w)) ~ _;
};

filtre = fi.lowpass(1,nentry("low", 200, 0, 20000, 10))*nentry("xf_low", -100, -100, 100, 1) : fi.highpass(1,nentry("up", 8000, 0, 20000, 10))*nentry("xf_up", -100, -100, 100, 1);

pitchshifter = vgroup("Pitch", transpose(
                        nentry("window", 1000, 50, 10000, 1),
                        nentry("xfade", 10, 1, 10000, 1),
                        nentry("shift", 0, -12, +12, 0.1)
 )*nentry("xpitch", 0, -100, 100, 1));

reverb = vgroup("Reverb", re.mono_freeverb(
                        nentry("fb1", 0, 0, 1, 0.01),
                        nentry("fb2", 0, 0, 1, 0.01),
                        nentry("damp", 0.5, 0, 1, 0.01),
                        nentry("spread", 0.5, 0, 1, 0.01)
                        )*nentry("xreverb", 0, -100, 100, 1));

filtrehigh = fi.highpass(1,nentry("high", 800, 0, 20000, 1))*nentry("xhigh", 0, -100, 100, 1);

//distortion = dm.cubicnl_demo;
distortion = ef.cubicnl(nentry("drive", 0, 0, 1, 0.01),nentry("offset", 0, 0, 1, 0.01))*nentry("xdist", 0, -100, 100, 1);

/*filtre1 = fi.bandpass(1,nentry("low1", 0, 0, 20000, 1),nentry("up1", 99, 0, 20000, 1))*nentry("x1", -5, -100, 100, 1);
filtre2 = fi.bandpass(1,nentry("low2", 101, 0, 20000, 1),nentry("up2", 899, 0, 20000, 1))*nentry("x2", -12, -100, 100, 1);
filtre3 = fi.bandpass(1,nentry("low3", 901, 0, 20000, 1),nentry("up3", 2499, 0, 20000, 1))*nentry("x3", -40, -100, 100, 1);
equalizer = filtre1, filtre2, filtre3; */

f1 = fi.bandpass(1,nentry("low1", 100, 0, 20000, 1),nentry("up1", 200, 0, 20000, 1))*nentry("x1", -12, -100, 100, 1);
f2 = fi.bandpass(1,nentry("low2", 200, 0, 20000, 1),nentry("up2", 300, 0, 20000, 1))*nentry("x2", 1, -100, 100, 1);
f3 = fi.bandpass(1,nentry("low3", 300, 0, 20000, 1),nentry("up3", 400, 0, 20000, 1))*nentry("x3", -3, -100, 100, 1);
f4 = fi.bandpass(1,nentry("low4", 400, 0, 20000, 1),nentry("up4", 700, 0, 20000, 1))*nentry("x4", 1, -100, 100, 1);
f5 = fi.bandpass(1,nentry("low5", 700, 0, 20000, 1),nentry("up5", 1000, 0, 20000, 1))*nentry("x5", 3, -100, 100, 1);
f6 = fi.bandpass(1,nentry("low6", 1000, 0, 20000, 1),nentry("up6", 2000, 0, 20000, 1))*nentry("x6", 1, -100, 100, 1);
f7 = fi.bandpass(1,nentry("low7", 2000, 0, 20000, 1),nentry("up7", 4000, 0, 20000, 1))*nentry("x7", 12, -100, 100, 1);
f8 = fi.bandpass(1,nentry("low8", 4000, 0, 20000, 1),nentry("up8", 10000, 0, 20000, 1))*nentry("x8", 2, -100, 100, 1);
f9 = fi.bandpass(1,nentry("low9", 10000, 0, 20000, 1),nentry("up9", 20000, 0, 20000, 1))*nentry("x9", 1, -100, 100, 1);

eq = f1,f2,f3,f4,f5,f6,f7,f8,f9;

process = filtre <: distortion <: eq :> _ <: pitchshifter : reverb <: _,_;
