#!/usr/bin/env perl
use strict;
use warnings;
use Digest::MD5 qw(md5_hex);
use Digest::SHA qw(sha1_hex sha256_hex sha512_hex);
use MIME::Base64;

sub measure_time(&) {
	my($btime, $etime);
	$btime = time();
	&{$_[0]}();
	$etime = time();
	warn "elapsed time was: ", $etime - $btime, " s\n";
};

my $infn="list.txt";
my $outfn="hashes.txt";
my $count=0;

open my $infile, "< $infn" or die "can't open $infn: $!";
$count++ while <$infile>;
seek $infile,0,0;

open my $outfile, "> $outfn" or die "can't open $outfn: $!";

my $i=0;

measure_time {
	while (my $line = <$infile>) {

		chomp $line;

		print $outfile $line."  -\n";
		print $outfile $line."  -\r\n";
		print $outfile $line." *-\n";
		print $outfile $line." *-\r\n";

		print $outfile md5_hex($line)."  -\n";
		print $outfile md5_hex($line)."  -\r\n";
		print $outfile md5_hex($line)." *-\n";
		print $outfile md5_hex($line)." *-\r\n";
		print $outfile md5_hex($line."\n")."  -\n";
		print $outfile md5_hex($line."\n")."  -\r\n";
		print $outfile md5_hex($line."\n")." *-\n";
		print $outfile md5_hex($line."\n")." *-\r\n";
		print $outfile md5_hex($line."\r")."  -\n";
		print $outfile md5_hex($line."\r")."  -\r\n";
		print $outfile md5_hex($line."\r")." *-\n";
		print $outfile md5_hex($line."\r")." *-\r\n";
		print $outfile md5_hex($line."\r\n")."  -\n";
		print $outfile md5_hex($line."\r\n")."  -\r\n";
		print $outfile md5_hex($line."\r\n")." *-\n";
		print $outfile md5_hex($line."\r\n")." *-\r\n";
		print $outfile sha256_hex($line)."  -\n";
		print $outfile sha256_hex($line)."  -\r\n";
		print $outfile sha256_hex($line)." *-\n";
		print $outfile sha256_hex($line)." *-\r\n";
		print $outfile sha256_hex($line."\n")."  -\n";
		print $outfile sha256_hex($line."\n")."  -\r\n";
		print $outfile sha256_hex($line."\n")." *-\n";
		print $outfile sha256_hex($line."\n")." *-\r\n";
		print $outfile sha256_hex($line."\r")."  -\n";
		print $outfile sha256_hex($line."\r")."  -\r\n";
		print $outfile sha256_hex($line."\r")." *-\n";
		print $outfile sha256_hex($line."\r")." *-\r\n";
		print $outfile sha256_hex($line."\r\n")."  -\n";
		print $outfile sha256_hex($line."\r\n")."  -\r\n";
		print $outfile sha256_hex($line."\r\n")." *-\n";
		print $outfile sha256_hex($line."\r\n")." *-\r\n";

		$i++;
		if ( ( $i % 1000 ) == 0 ) { print "\r$i/$count"; }
	}
};

close $infile;
close $outfile;
