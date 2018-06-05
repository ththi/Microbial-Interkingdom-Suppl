perl -e '

$mets{"dep"}=1;
$mets{"inde"}=1;
open(in1,"../data/taxonomy_ref_fun.txt");

while(<in1>){
	chomp;
	@_=split(/\s+/);
	if(/c__\w/){
		$_[3]=~s/c__//;
		$use{$_[0]}=$_[3]
	}
}

open(in2,"../data/fun_top_otus_by_site.txt");

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
		if($use{$key} eq "Ascomycota"){
			$cou{"Sordariomycetes"}{"inde"}++;
		}elsif($use{$key} eq "Glomeromycetes"){
			$cou{"x_other"}{"inde"}++;
		}elsif($use{$key} eq "Agaricostilbomycetes"){
			$cou{"x_other"}{"inde"}++;
		}elsif($use{$key} eq "Pezizomycotina"){
			$cou{"Pezizomycetes"}{"inde"}++;
		}else{
			$cou{$use{$key}}{"inde"}++;
		}
	}
}

open(in1,"../data/fun_taxonomy_all_isolates.txt");

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
