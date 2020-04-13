#!/usr/bin/env perl
# (C) 2020 Piotr Biesiada
use strict;
use warnings;

my $list   = "passwords.txt";
my $suf    = "suf.txt";
my $out    = "listsuf.txt";
my $count1 = 0;
my $count2 = 0;

open my $listh, "< $list" or die "can't open $list: $!";
$count1++ while <$listh>;
seek $listh, 0, 0;

open my $sufh, "< $suf" or die "can't open $suf: $!";
$count2++ while <$sufh>;
seek $sufh, 0, 0;

my $count = $count1 * $count2;

open my $outh, "> $out" or die "can't open $out: $!";

my $i = 0;

while ( my $line1 = <$listh> ) {
    chomp $line1;
    seek $sufh, 0, 0;
    while ( my $line2 = <$sufh> ) {
        chomp $line2;
        print $outh "$line1" . "$line2" . "\n";

        $i++;
        print "\r$i/$count";
    }
}

close $listh;
close $sufh;
close $outh;
