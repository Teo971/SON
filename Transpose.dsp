import("stdfaust.lib");

WINDOW = 512;

transpose(w, x, s, sig) = de.fdelay(maxDelay,d,sig)*ma.fmin(d/x,1) +
    de.fdelay(maxDelay,d+w,sig)*(1-ma.fmin(d/x,1))
with {
    maxDelay = WINDOW;
    i = 1 - pow(2, s/12);
    d = i : (+ : +(w) : fmod(_,w)) ~ _;
};

pitchsifter = transpose(
                        nentry("window", 1000, 50, 10000, 1),
                        nentry("xfade", 10, 1, 10000, 1),
                        nentry("shift", 0, -12, +12, 0.1)
                        );

process = pitchsifter <: _,_ ;
