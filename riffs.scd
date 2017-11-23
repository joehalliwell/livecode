Quarks.gui;
//up-down riff
//harmonic series version
//re-evaluate individual directions to create a different riff
(
//up
p.clock.tempo = 1.5;
~r = {75};
~sinfb1 = Pbind(\instrument,\sinfb,\freq,Pseq((1..10),inf)*Pkr(~r),\dur,0.25,\amp,0.3,\fb,Pwhite(0.1,0.4),\rel,0.3);
~sinfb1.play;
)
(
//down
~sinfb2 = Pbind(\instrument,\sinfb,\freq,Pseq((1..10).reverse,inf)*Pkr(~r),\dur,0.25,\amp,0.3,\fb,Pwhite(0.1,0.4),\rel,0.3);
~sinfb2.play;
)
(
//random
~sinfb3 = Pbind(\instrument,\sinfb,\freq,Pseq((1..10).scramble,inf)*Pkr(~r),\dur,0.25,\amp,0.3,\fb,Pwhite(0.1,1.0),\rel,0.3);
~sinfb3.play;
)

//up-down riff
//minor scale version
//re-evaluate individual directions to create a different riff
(
p.clock.tempo = 1.5;
//up
~sinfb1 = Pbind(\instrument,\portbass,\scale,Scale.minor,\octave,3,\degree,Pseq([1,3,2,3,1,1,-1,2],inf),\dur,0.5,\amp,0.9,\fb,Pwhite(0.1,0.4),\rel,0.1);
~sinfb1.play;
~sinfb1.stop;
)
(
//down
~sinfb2 = Pbind(\instrument,\sinfb,\scale,Scale.minor,\octave,5,\degree,Pseq((0..7).reverse,inf),\dur,0.25,\amp,0.3,\fb,Pwhite(0.1,0.4),\rel,0.2);
~sinfb2.play;
~sinfb2.stop(1);
)
(
//random, an octave higher
~sinfb3 = Pbind(\instrument,\sinfb,\scale,Scale.minor,\octave,3,\degree,Pseq((0..7).scramble,inf),\dur,0.25,\amp,0.3,\fb,Pwhite(0.1,1.0),\rel,0.2);
~sinfb3.play;
)

{DFM1.ar(SinOsc.ar([100,101],0,0.1),200,SinOsc.kr(0.05).range(0.9,1.1),1,0,0.0003,0.5)}.play
p.clean(~k, ~sn)
s['temp__0']

p.clear(2)