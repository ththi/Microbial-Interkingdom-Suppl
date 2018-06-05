perl -e '

$mets{"dep"}=1;
$mets{"inde"}=1;
open(in1,"../data/taxonomy_ref_oo.txt");

while(<in1>){
	chomp;
	@_=split(/\s+/);
	if(/o__\w/){
		$_[2]=~s/o__//;
		$use{$_[0]}=$_[2]
	}
}

open(in2,"../data/oomyc_top_otus_by_site.txt");

while(<in2>){
	chomp;
	@_=split(/\s+/);
	if(/(OTU_\d+)/){
		$nam=$1;
	}else{
		if($_[6]>=0.1){ $abun{$nam}=1; }
	}
}

for$key(sort keys %abun){
	if(exists $use{$key}){
		
		$cou{$use{$key}}{"inde"}++;
		
	}
}

open(in1,"../data/oomyc_taxonomy_all_isolates.txt");

print "culture_dependent\tculture_independent\n";

while(<in1>){
	chomp;
	@_=split(/\s+/);
	$_[1]=~s/_.*//g;
	$cou{$_[1]}{"dep"}++;
}

for$key(sort  keys %cou){
	print "$key";
	for$key2(sort keys %mets){
		if(exists $cou{$key}{$key2}){
			print "\t$cou{$key}{$key2}";
		}else{
			print "\t0";
		}
	}
	print "\n";
}
'>dump.txt


Rscript barplot.r
