(
~bass = Pbind(
	\instrument, \bass,
	\scale, Scale.minor,
	\amp, Pseq([0.3, 0.5], inf),
	\dur, 0.25,
	\sustain, 0.3,
	\octave, Pseq([[3,4], [4,5]], inf),
	\cutoff, Place([[1,4,3,1] * 0.3, [2,3,5,1,0.1] * 0.3], inf),
	//\degree, Pstutter(1, Place(([0, 2, -1, 0].stutter(3)!2) ++ [Place([[5,0],[5,0]], 1)],inf)))
	\degree, Pstutter(2, Place([[0, -3, -1, 0],[0, 0, -3, -2]-8, [0, 0, -3, -5], [1,2,3,4]+5], inf)),
	\pan, [-0.5, 0.5],
	\legato, 1
);
)
~bass.play;
~bass.stop;

(
SynthDef(\bass, {
	|out=0, freq=440, gate=1, amp=0.5, pan=0, cutoff=10, res=0.5|
	var sig, env;
	sig = Pulse.ar(freq);
	env = EnvGen.kr(Env.adsr(0.1, 0.2, 1.0, 0.05), gate: gate, doneAction: 2);
	sig = RLPF.ar(sig, freq: 440 * cutoff, rq: res);
	Out.ar(out, Pan2.ar(sig, pos: pan) * env * amp);
}).add;
)

(
SynthDef(\lead, {
	|out=0, freq=440, gate=1, amp=0.5, pan=0, cutoff=200, res=0.6, detune=0.1|
	var sig, env;
	env = EnvGen.kr(Env.adsr(0.1, 0.3, 0.5, 0.1), gate: gate, doneAction: 2);
	sig = SinOsc.ar(freq + (detune * {Rand(-1, 1)}!4));
	sig = RLPF.ar(sig, freq: 440 * cutoff, rq: res);
	sig = Splay.ar(sig, spread: 1, center: pan);
	Out.ar(out, sig * env * amp);
}).add;
)

(
~acid = Pbind(
	\instrument, \bass,
	\dur, 1/4,
	\scale, Scale.minor,
	\octave, Pseq([3,3], inf),
	//\degree, Pseq(stutter([0, 0, -3, -1],2), inf),
	\degree, Pseq(stutter([0, -3, -1, 0, 0, -0.5, 2, 0], 2), inf),
	\amp, 4,
	\cutoff, 1.6,
	\res, 0.4,
	\detune, 1,
	\legato, 0.1,
)
)



~acid.play;
~acid.stop(5);