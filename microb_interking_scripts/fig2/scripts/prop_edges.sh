perl -e ' 
open(in1,"../data/selected_cor_root.txt");
while(<in1>){
	chomp;
	@_=split(/\s+/);
	if($_[0]=~m/fun|oo/){$pat1=$&}else{$pat1="bac"}
	if($_[1]=~m/fun|oo/){$pat2=$&}else{$pat2="bac"}
	if($_[2]>=0.1){$cor="pos"}else{$cor="neg"}
	@dump=($pat1,$pat2);
	$x1=(sort @dump)[0];
	$x2=(sort @dump)[1];
	$count{$x1.$x2}{$cor}++;
	$all++;
	$cors{$cor}=1;
}
for$key(sort keys %count){
	print "$key";
	for$key2(sort keys %cors){
		if(exists $count{$key}{$key2}){
			$res=$count{$key}{$key2}/$all;
			print "\t$res";
		}else{
			print "\t0";
		}
	}
	print "\n";
}  
'>dump.txt


Rscript edge_bar.r
