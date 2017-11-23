(

// Load samples from setup directory
	d = Dictionary.new;
	foldernames = PathName(thisProcess.nowExecutingPath.dirname +/+ "samples").entries;
	for (0, foldernames.size-1, { |i|
		d.add(foldernames[i].folderName -> foldernames[i].entries.collect({ |sf|
			Buffer.read(s, sf.fullPath);
		}));
	});
)