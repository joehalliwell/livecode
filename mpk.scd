(
s.boot;
m = Buffer.read(s, "/home/joe/work/livecode/marble-drop.wav");
f = Buffer.read(s, "/home/joe/work/livecode/floppy-disk-write.wav");
b = Buffer.read(s, "/home/joe/work/livecode/stopping-by-woods-on-a-snowy-evening.wav");

MKtl.find;
~mpk = MKtl('mpk', "akai-mpkmini2");

StageLimiter.activate

)

~mpk.trace
~mpk.gui

~mpk.elAt(\key, 49, \on).action = { m.play };

(
SynthDef(\WarpChorus, {
	arg out = 0, buf = 0, pointer = 0.5, maxSpeed = 0.01, freqScale = 1, rand = 0.1, amp = 0.5, pan = 0;
	var sig;
	sig = Mix.arFill(6, { |i|
		Pan2.ar(
			Warp1.ar(buf.numChannels, buf,
				pointer: Slew.kr(pointer, maxSpeed, maxSpeed),
				windowRandRatio: rand,
				freqScale: freqScale + SinOsc.kr(freq: Rand(0.05, 0.1), phase: Rand(0, 2pi), mul: 0.03)),
			pos: SinOsc.kr(freq: 0.1 + SinOsc.kr(freq: Rand(0, 0.02)), phase: Rand(0, 2pi))
		)
	});
	Out.ar(out, sig * amp);
}).add;
)

~warp = Synth.new(\WarpChorus)
~warp.set(\maxSpeed, 0.5)
~warp.set(\buf, 0)
~mpk.elAt(\bend).action = { arg el; ~warp.set(\freqScale, el.value) }
~mpk.elAt(\kn, 1).action = { arg el; ~warp.set(\freqScale, el.value) }
~mpk.elAt(\kn, 2).action = { arg el; ~warp.set(\rand, el.value) }
~mpk.elAt(\key, 10, \on).action = { arg el; Synth.new(\bplay, \buf, 0).play; }
~mpk.elAt(\kn, 0).action = { arg el; ~warp.set(\freqScale, el.value) }
~mpk.elAt(\kn, 10).action = { arg el; ~warp.set(\amp, el.value) }
~mpk.elAt(\kn, 16).action = { arg el; ~warp.set(\amp, el.value) }

~mpk.elAt(\bt, \2, \5).action = { arg el; ~warp.set(\amp, el.value) }

~warp.stop
~mpk.set(\amp, 2.0)

Synth.new(\bplay, \buf, m);


(
SynthDef(\lead, {
	|out=0, in=0, freq=440, gate=1, amp=0.5, pan=0, cutoff=200, res=0.6, detune=0.1|
	var sig, env;
	env = EnvGen.kr(Env.adsr(0.1, 0.3, 0.5, 2), gate: gate, doneAction: 2);
	//sig = VarSaw.ar(freq: freq + ([0, -1, 2, -3, 4, -5, 6]* detune), iphase: [0.5, 0.45, 0.4, 0.35, 0.3, 0.25, 0.2]);
	sig = Saw.ar(freq: freq + ([0, -1, 2, -3, 4, -5, 6]* detune));

	sig = RLPF.ar(sig, freq: 2000 * cutoff, rq: res);
	sig = Splay.ar(sig, spread: 1, center: pan);
	Out.ar(out, sig * env * amp);
}).add;
)

(
SynthDef(\risset, {|out= 0, pan= 0, freq= 400, amp= 0.1, dur= 2, t_trig= 1|
		var amps= #[1, 0.67, 1, 1.8, 2.67, 1.67, 1.46, 1.33, 1.33, 1, 1.33];
		var durs= #[1, 0.9, 0.65, 0.55, 0.325, 0.35, 0.25, 0.2, 0.15, 0.1, 0.075];
		var frqs= #[0.56, 0.56, 0.92, 0.92, 1.19, 1.7, 2, 2.74, 3, 3.76, 4.07];
		var dets= #[0, 1, 0, 1.7, 0, 0, 0, 0, 0, 0, 0];
		var src= Mix.fill(11, {|i|
			var env= EnvGen.ar(Env.perc(0.005, dur*durs[i], amps[i], -4.5), t_trig);
			SinOsc.ar(freq*frqs[i]+dets[i], 0, amp*env);
		});
		Out.ar(out, Pan2.ar(src, pan));
	}).add;
)

(
SynthDef(\fmbell, { arg out=0, amp=0.1, gate=1, pan=0, freq=200;
	var sig;
	var sig1, sig2, sig3, sig4, sig5, sig6, sig7, sig8;
	freq = freq * EnvGen.kr(Env([1,1.002,0.998,1],[0.1,0.8]), 1);
	sig1 = SinOsc.ar(freq * 2.6706 + 0.13) * 2 + 1;
	sig2 = SinOsc.ar(freq * 0.9998 * sig1);
	sig3 = SinOsc.ar(freq * 2.6629 * sig1 + 2.04);
	sig4 = LFCub.ar(freq * 0.9991 * sig1 + 2.14);
	sig5 = SinOsc.ar(freq * 2.6656 * sig1 - 2);
	sig6 = SinOsc.ar(freq * 1 * sig1 + 1.84);
	//sig = sig2 + sig3 + sig4 + sig5 + sig6;
	sig = [sig1, sig2, sig3, sig4, sig5, sig6] * DC.ar([0,0.5,0.5, 0.5,0.5,0.5]);
	//sig.debug("sig");
	//sig = sig /34;
	sig = sig * EnvGen.ar(\adsr.kr( Env.adsr(0.01,0,1,2.1,1,-1) ),gate,doneAction:2);
	sig = Pan2.ar(sig, pan + [ 0, -0.5, -0.5, 0.5, 0.5, 0], amp).sum;
	Out.ar(out, sig);
}).add;
)

(
SynthDef(\fmbass, { arg out=0, amp=0.1, gate=1, pan=0, freq=200;
	var sig;
	var sig1, sig2, sig3, sig4, sig5, sig6, sig7, sig8;
	var env1, env2, env3, env4, env5, env6, env7, env8;
	freq = freq / 4;
	freq = freq * ((0..1)/1 - 0.5 * 0.0007 + 1);
	env1 = EnvGen.kr(Env([0,1,0.051,0],[0.001,0.01,0.8], [4,-8]), 1);
	env2 = EnvGen.kr(Env([0,1,0.051,0],[0.005,0.5,1.5], [0,-8], releaseNode:2), 1);
	env3 = EnvGen.kr(Env([0,1,1,0],[0.01,0.01,0.2], [0,0,-4], releaseNode:2), gate);
	env4 = EnvGen.kr(Env([0,1,0],[0.002,2.8], [0,-4]), 1);
	env5 = EnvGen.kr(Env([0,1,1,0],[0.001,0.1,0.8], [4,0,-4], releaseNode:2), gate);
	env6 = EnvGen.kr(Env([0,1,0],[0.001,3.0], [0,-4]), 1);
	//freq = freq * EnvGen.kr(Env([1,1.002,0.998,1],[0.1,0.8]), 1);
	sig1 = SinOsc.ar(freq * 11 + 0) * env1;
	sig2 = SinOsc.ar(freq * 6 * ( sig1 * 2.5 + 1 )) * env2;
	sig3 = SinOsc.ar(freq * 2 * 1 + 0) * env3;
	sig4 = SinOsc.ar(freq * 1 * ( sig3 * 2.5 + 1 ) + 0) * env4;
	sig5 = SinOsc.ar(freq * 1 * ( sig2 * 2.5 + 1 ) * (sig4 * 2.5 + 1)) * env5;
	sig6 = SinOsc.ar(freq * 2) * env6;
	//sig = sig2 + sig3 + sig4 + sig5 + sig6;
	sig = [sig1, sig2, sig3, sig4, sig5, sig6] * DC.ar([0.0, 0.0, 0.0,  0.0, 0.5, 0.5]);
	sig.debug("sig");
	sig = sig /2;
	sig = sig.flop.sum;
	sig = sig * EnvGen.ar(\adsr.kr( Env.adsr(0.001,0,1,0.01, 1,-1) ),gate,doneAction:2);
	sig = sig * AmpComp.kr(freq);
	sig.debug("sigx");
	sig = Pan2.ar(sig, pan + [ 0, 0, 0, 0, 0, 0], amp).sum;
	Out.ar(out, sig);
}).add;
)

({rand(-10, 10)}!4 * 0.1).postln

~mpk.elementGroup.doRecursive {|el| el.resetAction;}
Bus.asSynthDef
(
~k1 = Bus.control(s, 1);
~k2 = Bus.control(s, 2);
~k3 = Bus.control(s, 3);

~mpk.elAt(\kn, \20).action = { |el| ~k1.set(el.value); };
~mpk.elAt(\kn, \21).action = { |el| ~k2.set(el.value); };
~mpk.elAt(\kn, \22).action = { |el| ~k3.set(el.value); };
)
(
var notes = Array.newClear(128);    // array has one slot per possible MIDI note

~mpk.elAt(\key).do { |g|
	var key = g.key.asInt;
	g.elAt(\on).action = { |el|
		notes[key] = Synth(\fmbass, [\freq, key.midicps, \amp, el.value]);
		notes[key].map(\cutoff, ~k1.index);
		notes[key].map(\res, ~k2.index);
		notes[key].map(\detune, ~k3.index);
	};
	g.elAt(\off).action = { |el| notes[key].release; };
};
)