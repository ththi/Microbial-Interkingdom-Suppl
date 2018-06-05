perl -e '
open(in1,"../data/taxonomy_bac.txt");
while(<in1>){
	chomp;
	@_=split(/\s+/);
	$tax{$_[0]}=$_[3];
}

open(in1,"../data/selected_cor_root.txt");

while(<in1>){
	chomp;
	@_=split(/\s+/);
	if(/oo/){next}
	if($_[0]=~m/fun|oo/){$pat1="fun"}else{$pat1="bac"}
	if($_[1]=~m/fun|oo/){$pat2="fun"}else{$pat2="bac"}
	if($_[2]>=0.1){$cor="pos"}else{$cor="neg"}
	if($pat1 ne $pat2 ){
		if($pat1 eq "bac"){
			$count{$_[0]}++;
			$tax_cou{$tax{$_[0]}}{$_[0]}=1;
			push @{$sum_cou{$_[0]}},$_[2];
		}
		if($pat2 eq "bac"){
			$count{$_[0]}++;
			$tax_cou{$tax{$_[1]}}{$_[1]}=1;
			push @{$sum_cou{$_[1]}},$_[2];
		}
	}
}

for$key(sort { $count{$b} <=> $count{$a}  } keys %count){
	if(exists $tax{$key} and keys($tax_cou{$tax{$key}}) >=5){
		$val=keys($tax_cou{$tax{$key}});
		$sum=eval join "+",@{$sum_cou{$key}};
		print "$key\t$tax{$key}\t$count{$key}\t$sum\n";
	}
} 
'>dump_bac.txt

perl -e '
open(in1,"../data/taxonomy_ref_fun.txt");

while(<in1>){
	chomp;
	@_=split(/\s+/);
	$tax{$_[0]."_fun"}=$_[3];
}
open(in1,"../data/selected_cor_root.txt");
while(<in1>){
	chomp;
	@_=split(/\s+/); 
	if(/oo/){next}
	if($_[0]=~m/fun|oo/){$pat1="fun"}else{$pat1="bac"}
	if($_[1]=~m/fun|oo/){$pat2="fun"}else{$pat2="bac"}
	if($_[2]>=0.1){$cor="pos"}else{$cor="neg"}
	if($pat1 ne $pat2 ){
		if($pat1 eq "fun"){
			$count{$_[0]}++;
			$tax_cou{$tax{$_[0]}}{$_[0]}=1;
			push @{$sum_cou{$_[0]}},$_[2];
		}
		if($pat2 eq "fun"){
			$count{$_[1]}++;
			$tax_cou{$tax{$_[1]}}{$_[1]}=1;
			push @{$sum_cou{$_[1]}},$_[2];
		}
	}
}

for$key(sort { $count{$b} <=> $count{$a}  } keys %count){
	if(exists $tax{$key} and keys($tax_cou{$tax{$key}}) >=5){
		$val=keys($tax_cou{$tax{$key}});
		$sum=eval join "+",@{$sum_cou{$key}};
		print "$key\t$tax{$key}\t$count{$key}\t$sum\n";
	}
} 
'>dump_fun.txt

Rscript boxplots.r
