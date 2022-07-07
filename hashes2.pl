#!/usr/bin/env perl
# (C) 2021 Piotr Biesiada
use strict;
use warnings;

sub measure_time(&) {
	my($btime, $etime);
	$btime = time();
	&{$_[0]}();
	$etime = time();
	warn "elapsed time was: ", $etime - $btime, " s\n";
};

my $infn="hashes.txt";
my $outfn="hashes2.txt";
my $count=0;

open my $infile, "< $infn" or die "can't open $infn: $!";
$count++ while <$infile>;
seek $infile,0,0;

open my $outfile, "> $outfn" or die "can't open $outfn: $!";

my $i=0;

measure_time {
	while (my $line = <$infile>) {

		chomp $line;

		print $outfile $line."\n";
		print $outfile $line."\r\n";
		print $outfile $line."  -\n";
		print $outfile $line." *-\n";
		print $outfile $line."  -\r\n";
		print $outfile $line." *-\r\n";

		$i++;
		if ( ($i % 10000) == 0 ) { print "\r$i/$count"; }
	}
};

close $infile;
close $outfile;
