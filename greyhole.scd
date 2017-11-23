(
Ndef(\bitshift, { | lpf = 120 |
    var t = PulseCount.ar(Impulse.ar(8e3));
    var sig = HPF.ar(
        (
            ((t * 15) & (t >> 5)) |
            ((t * 5) & (t >> [3, 4])) |
            ((t * 2) & (t >> 9)) |
            ((t * 8) & (t >> 11))
            - 3 % 256
        ) / 127-1 * 3
        , 20
    ).distort * 0.2;
	sig = RLPF.ar(sig, lpf, 0.1, 0.6).tanh + sig.tanh; //boost some bass son.tanh;
    sig = Greyhole.ar(sig, sig, 0.5, sig).flop.mean/4;
}).play;
)

s.boot;