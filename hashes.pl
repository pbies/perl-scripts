#!/usr/bin/env perl
# (C) 2019 Piotr Biesiada
use strict;
use warnings;
use Digest::MD5 qw(md5_hex);
use Digest::SHA qw(sha1_hex sha256_hex sha512_hex);
use MIME::Base64;

my $infn="passwords.txt";
my $outfn="hashes.txt";
my $count=0;

open my $infile, "< $infn" or die "can't open $infn: $!";
$count++ while <$infile>;
seek $infile,0,0;

open my $outfile, "> $outfn" or die "can't open $outfn: $!";

my $i=0;

while (my $line = <$infile>) {

	chomp $line;

	print $outfile md5_hex($line)."\n";
	print $outfile sha1_hex($line)."\n";
	print $outfile sha256_hex($line)."\n";
	print $outfile sha512_hex($line)."\n";
	print $outfile encode_base64($line);

	print $outfile md5_hex($line."\r")."\n";
	print $outfile sha1_hex($line."\r")."\n";
	print $outfile sha256_hex($line."\r")."\n";
	print $outfile sha512_hex($line."\r")."\n";
	print $outfile encode_base64($line."\r");

	print $outfile md5_hex($line."\n")."\n";
	print $outfile sha1_hex($line."\n")."\n";
	print $outfile sha256_hex($line."\n")."\n";
	print $outfile sha512_hex($line."\n")."\n";
	print $outfile encode_base64($line."\n");

	print $outfile md5_hex($line."\r\n")."\n";
	print $outfile sha1_hex($line."\r\n")."\n";
	print $outfile sha256_hex($line."\r\n")."\n";
	print $outfile sha512_hex($line."\r\n")."\n";
	print $outfile encode_base64($line."\r\n");

	$i++;
	print "\r$i/$count";
}

close $infile;
close $outfile;
