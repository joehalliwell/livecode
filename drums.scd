Quarks.gui;

~k = Pbind(\instrument,\bplay,\buf,d["k"][3],\dur, 0.5,\amp,Pseq([2,0.0,1,0.0], inf));
~k.play;
~k.stop;

~sn = Pbind(\instrument,\bplaym,\buf,d["s"][2],\dur, 1, \amp, Pseq([0,1], inf), \rate, Pwhite(0.45, 0.5, inf));
~sn.play;
~sn.stop;

~h = Pbind(\instrument,\bplaym,\buf,d["ch"][0],\dur,1/4,\amp,Pwhite(0.15,0.2));
~h.play;
~h.stop(2);

~h2 = Pbind(\instrument, \bplay, \buf, d["ch"][3], \dur, Pbjorklund2(12, 16, inf, 3)/8, \amp, Pseq([0.05,0.1], inf));
~h2.play;
~h2.stop(1);

~c = Pbind(\instrument,\bplay,\buf,d["c"][0],\dur,0.5,\amp,1);
~c.play;
~c.stop(5);

~oh = Pbind(\instrument,\bplay,\buf, Pseq([d["shout"][1], d["shout"][0], d["shout"][2]], inf), \dur, Pseq([0.5,Pseq([1],inf)],inf),\amp,1);
~oh.play;
~oh.stop(2);

(
~sinfb = Pbind(\instrument,\sinfb,\scale,Scale.chromatic,\octave,4,\degree,Pseq([\Em7,\G,\Dsus4,\A7sus4].chordProg,inf).stutter(6),\dur,1,\atk,0.8,\amp,0.3,\fb,0.1,\rel,1);
~sinfb.play
)

(
~chords = Pbind(\instrument,\bpfsaw,
    \dur,Pwhite(4.5,7.0,inf),
    \scale,Scale.minor,
    \degree,Pwrand([[0,2,4],[3,5,7],[4,6,8]],[0.5,0.25,0.25],inf),
    \cfmin,100,
    \cfmax,1500,
    \rqmin,Pexprand(0.02,0.15,inf),
    \atk,Pwhite(2.0,4.5,inf),
    \rel,Pwhite(6.5,10.0,inf),
    \ldb,6,
    \lsf,1000,
    \octave,Pwrand([4,3,5],[0.6,0.3,0.1],inf),
    \amp,Pwhite(0.8,2.0),
    \out,0);
~chords.play;
~sinfb = Pbind(\instrument,\sinfb,\scale,Scale.minor,\root,0,\octave,3,\degree,Place([0,0,2,[4,5,6],[7,1,2],[6,7,8,9],[10,12,14,15],7,6,5],inf),\dur,Pbjorklund2(Pwhite(6,8),8)/4,\amp,0.4,\fb,0.9,\rel,0.2);
~sinfb.play
~sinfb.stop;
~chords.stop;
);

~bass = Pbind(\instrument, \sinfb, \octave, 4, \degree, Pseq([0,6,3,5], inf), \dur, Pseq([0.5,0.25, 0.25, 0.5],inf), \amp, 0.5);
~bass.play;
~bass.stop;

//synth stabs - try this with both stab 0 and 1.
(
//stab 1
p.clock.tempo = 1.2;
~stab1 = Pbind(\instrument,\bplay,\buf,d["donk"][0],\euclidNum,Pwhite(3,3),\dur,Pbjorklund2(Pkey(\euclidNum),8)/4,\amp,2,\rate,Pseq([1,1,1,1,1,1,0.9,1.1] * 2,inf).stutter(3));
~stab1.play;
~stab1.stop;
)
(
//stab 2 - double speed and greater possible number of onsets
~stab2 = Pbind(\instrument,\bplay,\buf,d["donk"][0],\euclidNum,Pwhite(3,11),\dur,Pbjorklund2(Pkey(\euclidNum),16)/4,\amp,1,\rate,Pseq([1,1,1,1,1,1,0.9,1.1],inf).stutter(3)*2);
~stab2.play;
~stab2.stop;
)
(
//stab 3 - double speed again and greater possible number of onsets again
~stab3 = Pbind(\instrument,\bplay,\buf,d["donk"][0],\euclidNum,Pwhite(6,16),\dur,Pbjorklund2(Pkey(\euclidNum),16)/4,\amp,1,\rate,Pseq([1,1,1,1,1,1,0.9,1.1],inf).stutter(3)*4);
~stab3.play;
~stab3.stop(5);
)
//drums
(
~k = Pbind(\instrument,\bplay,\buf,d["k"][0],\dur,Pbjorklund2(3,8)/4,\amp,1,\rate,Pseq([1.1,1.9],inf));
~k2 = Pbind(\instrument,\bplay,\buf,d["k"][2],\dur,Pbjorklund2(3,8)/4,\amp,1,\rate,Pseq([1.1,1.9],inf)*2);
~sn = Pbind(\instrument,\bplaym,\buf,d["s"][2],\dur,Pbjorklund2(Pwhite(1,6),16)/4,\amp,1);
~fx = Pbind(\instrument,\bplay,\buf,d["oh"][0],\dur,16,\amp,1);
~k.play;~sn.play;~fx.play;~k2.play;
)
~sn.stop; ~k2.stop
~k.play
~k.stop
p.stop;

Synth(\bplay, [\buf, d["n"][0]]).play;

(
~sinfb = Pbind(\instrument,\sinfb,
    \scale,Scale.major,
    \root,0,
    \octave,Pwrand([4,[3,4],[2,3,4]],[0.9,0.08,0.02],inf),
    \degree,Prand([[0,2,4],[2,4,6],[7,2,4],[1,2,3],[0,-2,-4]],inf),
    \dur,Pwhite(5,10),
    \atk,2,\sus,1,\rel,3,\amp,0.3,\fb,0.1);
~modulation = {SinOsc.kr(0.1).range(0.01,1.41)};
~sinfb.play;
~sinfb.set(\fb,~modulation);
)

~sinfb.stop;

(
~sinfb = Pbind(\instrument,\harpsichord1,\scale,Scale.chromatic,\octave,4,\degree,Pseq([\Em7,\G,\Dsus4,\A7sus4].chordProg,inf).stutter(6),\dur,1.0,\atk,0.2,\amp,0.3,\fb,0.1,\rel,0.5);
~sinfb.play;
)
~sinfb.stop;

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
			pos: SinOsc.kr(freq: 0.1, phase: Rand(0, 2pi))
		)
	});
	Out.ar(out, sig * amp);
}).add;
)

b = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "stopping-by-woods-on-a-snowy-evening.wav")

b = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "floppy-disk-write.wav")
b = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "marble-drop.wav")
b = Buffer.read(s, thisProcess.nowExecutingPath.dirname +/+ "sweet-bitch.wav")

b.play;
b.bufnum;
b.numChannels;

~sigil = \WarpChorus;
~sigil.set(\buf, b.bufnum);
~sigil.play;
~sigil.set(\pointer, 0.2);
~sigil.set(\rand, 0.1);
~sigil.set(\maxSpeed, 0.01);
~sigil.set(\freqScale, 0.8);
~sigil.stop(5);

p.clear()

(
~frost = Pmono(\WarpChorus,
	\dur, Pseq([2,1, 0.5, 0.25], inf),
	\buf, b.bufnum,
	\pointer, Pseq([0.0, 0.02, 0.01, 0.05, 0.01, 0.04, 0.02, 0.03, 0.06, 0.01], inf),
	\maxSpeed, Pseq([100, 0.1], inf),
	\rand, Pwhite(0.01, 0.99, inf),
	\freqScale, Pstutter(10, Pseq([0.9, 1], inf)));
)
~frost.play;
~frost.stop;

(
~sigil2 = Pmono(\WarpChorus,
	\dur, 4,
	\buf, b.bufnum,
	\pointer, Pseq([0, Pseq([1], inf)], 1),
	\maxSpeed, Pseq([0.01, 0.001, 0.0001, 0.00001], inf),
	\amp, Pseq([0.1, 0.5, 0.8, 1.0], inf),

	\rand, Pwhite(0.0, 1, inf),
	\freqScale, 0.8
);
)

~sigil2.play;
~sigil2.stop;

(
~sigil3 = Pmono(\WarpChorus,
	\dur, Pseq([7,1], inf),
	\buf, b.bufnum,
	\pointer, Pwhite(0, 1, inf),
	\maxSpeed, Pseq([0.01, 10], inf),
	\rand, Pwhite(0, 0.1, inf),
	\freqScale, 0.8,
	\amp, 0.4
);
)

~sigil3.play;
~sigil3.stop(3);

(
~bitch = Pbind(\instrument, \bplay, \buf, b.bufnum, \rate, 0.2, \pointer, Pseq([0], inf), \dur, Pseq([1.0, 15.0], inf), \amp, Pseq([0, 0.5], inf));
)
~bitch.play
~bitch.stop