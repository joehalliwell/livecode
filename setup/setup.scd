
/*

Setup file as of 24th Feb 2016

Increases memory allocation
Adds more buffers
Boots server and proxyspace
Automatically loads all samples in repo inside a dictionary, following the format d["foldername"][x]
Loads SynthDefs
Activates StageLimiter

NB: StageLimiter requires BatLib quark
NanoKontrol


*/

(
s.options.numBuffers = 1024 * 16;
s.options.memSize = 8192 * 64;
s.boot;

p = ProxySpace.push(s);
p.makeTempoClock;
p.clock.tempo = 1.8;
p.quant = 4;

s.waitForBoot({
	var foldernames;

	postln("Running setup...");


	wait(2);
	loadRelative("synthdefs.scd");
	loadRelative("snippets.scd");
	loadRelative("samples.scd")



	wait(2);
	StageLimiter.activate;
	postln("Setup done!");
})
)

// Metronome
(
SynthDef(\mhTestClick, {|out=0, freq=440, pan=0, amp=0.4|
	var sig = SinOsc.ar(freq, phase:0.5pi);
	sig = sig * EnvGen.ar(Env.perc(0.000001,0.1), doneAction:2);

	OffsetOut.ar(out, Pan2.ar(sig, pan) * amp);
}).add;

~metro = Pbind(\instrument, \mhTestClick, \dur, 1, \octave, 6, \pan, 0, \degree, Pseq([7,Pn(0,4-1)],inf))

)
~metro.play

(
// Play cached samples
Task({d.keysValuesDo { |k,v|
	v.do { |buf, i|
		postf("%:%\t%\n",k,i,v);
		Synth(\bplay, [\buf, buf]);
		wait(0.25);
	};
}}).start;
)


