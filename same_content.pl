#!/usr/bin/env perl
# (C) 2019 Piotr Biesiada
use strict;
use warnings;

my @files = <*.txt>;
my @del;
my $diff;
foreach my $file1 (@files) {
	foreach my $file2 (@files) {
		if ($file1 eq $file2) {
			last;
		}
		open my $fh1, $file1 or die "can't open $file1: $!";
		open my $fh2, $file2 or die "can't open $file2: $!";
		print "Comparing $file1 and $file2...";
		my $line1;
		my $line2;
		$diff=0;
		while($line1 = <$fh1>) {
			$line2 = <$fh2>;
			if ($line1 ne $line2) {
				print "different!\n";
				$diff=1;
				last;
			}
		}
		if ($diff == 0) {
			print "the same till end of one files!\n";
			if (-s $file1 >= -s $file2)
			{
				push @del, $file2;
			}
			if (-s $file1 < -s $file2)
			{
				push @del, $file1;
			}
		}
		close($fh1);
		close($fh2);
	}
}
foreach my $file (@del) {
	print "Removing $file\n";
	unlink $file;
}
