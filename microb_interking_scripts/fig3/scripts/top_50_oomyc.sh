perl -e '

open(in0,"../data/oomyc_top_list_names_08rdp.txt");

while(<in0>){
	chomp;
	@_=split(/\s+/);
	$nam{$_[0]}=$_[1];
}

open(in1,"../data/oomyc_map_rep_seqs_to_cul_col.uc");

while(<in1>){
	chomp;
	@_=split(/\s+/);
	if(/OTU/ and /^H/){
		$hit{$_[-2]}=1;
	}
}

open(in2,"../data/oomyc_top_otus_by_site.txt");

$cum=0;
while(<in2>){
	chomp;
	@_=split(/\s+/);
	if(/OTU/){
		$_=~s/\s+\*//;
		$line++;
		if($line==51){exit}
		if(exists $hit{$_[1]}){
			$pat="yes";
			$cum=$cum+$_[3];
		}else{$pat="no"}
		print "$nam{$line}\t$_[3]\t$_[5]\t$cum\t$pat\n";
	}
}  
' >dump.txt


Rscript top_50.r
