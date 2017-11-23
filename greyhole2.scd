(
Ndef(\bitshift, {
	arg freq=8000, mod=200, amp=0.7, lpf=120, fb=0.5, x=15, y=5;
	var son, count, sig;
	count = PulseCount.ar(Impulse.ar(freq, (fb*Ndef(\bitshift).ar.abs.reverse)));
	a = (count * x); b = (count >> y); c = a & b; // bitwise AND op
	mod=mod.round(1);
	son=Limiter.ar((c % [mod, mod*3])) * amp;
	5.do{
		son=AllpassN.ar(son, 0.3, rrand(0.001,0.03).postln, rrand(0.1,0.2))
	};
	son = HPF.ar(son, 40);
	sig = RLPF.ar(son, lpf, 0.1, 0.6).tanh + son.tanh; //boost some bass son.tanh;
	sig = Greyhole.ar(sig, sig, 0.5, sig).flop.mean/4;
}).play; )

// bring back to steady pulsing
Ndef(\bitshift).set(\freq, 800, \x, 15, \y, 4, \mod, 256);