#!/usr/bin/env perl
# (C) 2020 Piotr Biesiada
use strict;
use warnings;

my $infn  = "hashes.txt";
my $outfn = "hashes2.txt";
my $count = 0;

open my $infile, "< $infn" or die "can't open $infn: $!";
$count++ while <$infile>;
seek $infile, 0, 0;

open my $outfile, "> $outfn" or die "can't open $outfn: $!";

my $i = 0;

while ( my $line = <$infile> ) {

    chomp $line;

    print $outfile $line . "\n";
    print $outfile $line . "\r\n";
    print $outfile $line . "  -\n";
    print $outfile $line . " *-\n";
    print $outfile $line . "  -\r\n";
    print $outfile $line . " *-\r\n";

    $i++;
    print "\r$i/$count";
}

close $infile;
close $outfile;
