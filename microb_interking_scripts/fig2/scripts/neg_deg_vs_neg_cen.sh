perl -e '
open(in1,"../data/selected_cor_epi.txt");
while(<in1>){
	chomp;
	@_=split(/\s+/);
	if(/oo/ ){next}
	if($_[2]>=0.1){$cor="pos";next; }else{$cor="neg"}
	if($_[0]=~m/fun/){$pat1="fun";   }else{$pat1="bac"; }
	if($_[1]=~m/fun/){$pat2="fun"; }else{$pat2="bac";}
	if($pat1 ne $pat2 ){ 
		$cou{$_[0]}++;
		$cou{$_[1]}++;
		if($pat1 eq "fun"){$num_fun{$_[0]}=1;}else{$num_bac{$_[0]}=1;}
		if($pat2 eq "fun"){$num_fun{$_[1]}=1;}else{$num_bac{$_[1]}=1;}
	}
}

$max_fun=keys(%num_fun);
$max_bac=keys(%num_bac);  
open(in2,"../data/neg_centrality_epi.txt");
while(<in2>){
	chomp;
	@_=split(/\s+/);
	$cent{$_[0]}=$_[1];
}

for$key(sort  keys %cou){
	if($key=~/fun/){
		$val=$max_bac;
	}else{
		$val=$max_fun;
	}
	$res=$cou{$key}/$val;
	if(!exists $cent{$key}){ $cent{$key}=0;  }
	print "$key\t$res\t$cent{$key}\n";
} '>dump.txt

Rscript neg_deg_plot.r
