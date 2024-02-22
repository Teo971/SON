import("stdfaust.lib");

WINDOW = 512;

transpose(w, x, s, sig) = de.fdelay(maxDelay,d,sig)*ma.fmin(d/x,1) +
    de.fdelay(maxDelay,d+w,sig)*(1-ma.fmin(d/x,1))
with {
    maxDelay = WINDOW;
    i = 1 - pow(2, s/12);
    d = i : (+ : +(w) : fmod(_,w)) ~ _;
};


pitchshifter = vgroup("Pitch", transpose(
                        nentry("window", 1000, 50, 10000, 1),
                        nentry("xfade", 10, 1, 10000, 1),
                        nentry("shift", 0, -12, +12, 0.1)
                    ));

distortion = ef.cubicnl(nentry("drive", 0, 0, 1, 0.01),nentry("offset", 0, 0, 1, 0.01));

f1 = fi.peak_eq(nentry("x1", -12, -100, 100, 1),nentry("f1", 150, 0, 20000, 1),nentry("bw1", 100, 0, 20000, 1));
f2 = fi.peak_eq(nentry("x2", 1, -100, 100, 1),nentry("f2", 250, 0, 20000, 1),nentry("bw2", 100, 0, 20000, 1));
f3 = fi.peak_eq(nentry("x3", -3, -100, 100, 1),nentry("f3", 350, 0, 20000, 1),nentry("bw3", 100, 0, 20000, 1));
f4 = fi.peak_eq(nentry("x4", 1, -100, 100, 1),nentry("f4", 550, 0, 20000, 1),nentry("bw4", 300, 0, 20000, 1));
f5 = fi.peak_eq(nentry("x5", 3, -100, 100, 1),nentry("f5", 850, 0, 20000, 1),nentry("bw5", 300, 0, 20000, 1));
f6 = fi.peak_eq(nentry("x6", 1, -100, 100, 1),nentry("f6", 1500, 0, 20000, 1),nentry("bw6", 1000, 0, 20000, 1));
f7 = fi.peak_eq(nentry("x7", 12, -100, 100, 1),nentry("f7", 3000, 0, 20000, 1),nentry("bw7", 2000, 0, 20000, 1));
f8 = fi.peak_eq(nentry("x8", 2, -100, 100, 1),nentry("f8", 7000, 0, 20000, 1),nentry("bw8", 6000, 0, 20000, 1));
f9 = fi.peak_eq(nentry("x9", 1, -100, 100, 1),nentry("f9", 15000, 0, 20000, 1),nentry("bw9", 10000, 0, 20000, 1));

eq = f1,f2,f3,f4,f5,f6,f7,f8,f9;

process = _ <: distortion <: eq :> _ <: pitchshifter<: _,_;
