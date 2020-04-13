#!/usr/bin/env perl
# (C) 2020 Piotr Biesiada
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

while ( $file1 = shift(@files) ) {
  SAME:
    foreach $file2 (@files) {
        if ( $file1 eq $file2 ) {
            next;
        }
        open $fh1, $file1 or die "can't open $file1: $!\n";
        open $fh2, $file2 or die "can't open $file2: $!\n";

        #		print "Comparing $file1 and $file2...\n";
        $diff = 0;
        while ( $line1 = <$fh1> ) {
            if ( !$line1 ) { $line1 = ""; }
            $line2 = <$fh2>;
            if ( !$line2 ) { $line2 = ""; }
            if ( "$line1" ne "$line2" ) {

                #				print "different!\n";
                $diff = 1;
                next SAME;
            }
        }
        if ( $diff == 0 ) {

            #			print "the same till end of one files!\n";
            if ( -s $file1 >= -s $file2 ) {
                push @del, $file2;
                print "\n$file1 >= $file2\n";
            }
            if ( -s $file1 < -s $file2 ) {
                push @del, $file1;
                print "\n$file2 >= $file1\n";
            }
        }
    }
    close($fh1);
    close($fh2);
    $i++;
    print "\r$i/$count";
}

print "\n";

foreach my $file (@del) {
    unlink $file;
    print "Removed $file\n";
}
