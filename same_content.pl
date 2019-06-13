#!/usr/bin/env perl
# (C) 2019 Piotr Biesiada
use strict;
use warnings;
use IO::Handle;

STDOUT->autoflush(1);

my @files = <*.txt>;
my $count = @files;
my @del;
my $diff;
my $i = 0;
my $file1;
my $file2;
my $fh1;
my $fh2;
my $line1;
my $line2;

foreach $file1 (@files) {
	SAME:
	foreach $file2 (@files) {
		if ($file1 eq $file2) {
			next;
		}
		open $fh1, $file1 or die "can't open $file1: $!";
		open $fh2, $file2 or die "can't open $file2: $!";
#		print "Comparing $file1 and $file2...\n";
		$diff=0;
		while($line1 = <$fh1>) {
			if (!$line1) { $line1 = ""; }
			$line2 = <$fh2>;
			if (!$line2) { $line2 = ""; }
			if ("$line1" ne "$line2") {
#				print "different!\n";
				$diff=1;
				next SAME;
			}
		}
		if ($diff == 0) {
#			print "the same till end of one files!\n";
			if (-s $file1 >= -s $file2)
			{
				push @del, $file2;
				print "\n$file2\n";
			}
			if (-s $file1 < -s $file2)
			{
				push @del, $file1;
				print "\n$file1\n";
			}
		}
	}
	$i++;
	print "\r$i/$count";
}

close($fh1);
close($fh2);

print "\n";

foreach my $file (@del) {
	print "Removing $file\n";
	unlink $file;
}
