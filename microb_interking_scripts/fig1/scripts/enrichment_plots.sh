perl -e ' 

open(in0,"../data/top_list_001_fun.txt"); 
while(<in0>){
	chomp; 
	@_=split(/\s+/);
	$ra{$_[1]}=$_[3];  
} 
open(in1,"../data/taxonomy_ref_fun.txt");
while(<in1>){
	chomp; 
	@_=split(/\s+/); 
	if($_[3]=~m/c__\w+/){ 
		$tax{$_[0]}=$_[2].$_[3];
	}else{ 
		$tax{$_[0]}="x_no_rank"  
	}
}
open(in1,"../data/fun_all_enr.txt");
while(<in1>){ 
	chomp;
	@_=split(/\s+/);
	push @{$fin{$_[2]}{$tax{$_[1]}}},$ra{$_[1]};
}

for$key(sort keys %fin){
	$sum_o=0;
	$anz2=0;
	for$key2(sort keys %{$fin{$key}}){
		$sum=eval join "+",@{$fin{$key}{$key2}};
		$anz=scalar(@{$fin{$key}{$key2}});
		if($sum <0.5){
			$sum_o=$sum_o+$sum;
			$anz2=$anz2+$anz;
		}else{
			print "$key\t$key2\t$sum\t$anz\n";
		}
	}
	print "$key\tother\t$sum_o\t$anz2\n";
} '>dump.txt

perl -e '

open(in1,"dump.txt");
while(<in1>){
	chomp;
	@_=split(/\s+/);
	$site{$_[0]}=1;
	$tax{$_[1]}=1;
	$enrich{$_[0]}{$_[1]}=$_[2];
}
for$key(sort keys %tax){
	print "$key";
	if($key eq (sort keys %tax)[-1] ){print "\n"}else{print "\t"}
}

for$key(sort keys %site){
	print "$key";
	for$key2(sort keys %tax){
		if(exists $enrich{$key}{$key2}){ 
			print "\t$enrich{$key}{$key2}";
		}else{
		print "\t0";
		}
	}
	print "\n";
}    ' >dump2.txt 



Rscript small_r.r











