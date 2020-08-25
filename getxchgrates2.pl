#!/usr/bin/perl

# (C) 2020 Piotr Biesiada

# Perl script to download and parse exchange rates for Polish zloty PLN to Dygraph format

use IO::Socket;
use strict;
use warnings;

use LWP::Simple;
use XML::LibXML;

my $url  = 'http://www.nbp.pl/kursy/xml/dir.txt';
my $file = 'dir.txt';

getstore( $url, $file );

open my $handle, '<', $file;
chomp( my @lines = <$handle> );
close $handle;

my @files;

foreach (@lines) {
    if ( ord($_) == 97 ) {
        chomp($_);
        push @files, $_;
    }
}

open( my $outh, '>', 'output.txt' );

print $outh "D,GBP,EUR,CHF,USD,NOK\n";

for my $i ( 0 .. $#files ) {
    my $fn = $files[$i];
    $fn=substr($fn,0,11);
    $fn = $fn . '.xml';
    my $url = 'http://www.nbp.pl/kursy/xml/' . $fn;

    getstore( $url, $fn );

    my $dom = XML::LibXML->load_xml(location => $fn);

    print $outh $dom->findvalue('//data_publikacji') . ',';
    print $outh $dom->findvalue('//pozycja/kod_waluty[text()=\'GBP\']/../kurs_sredni') =~ s/,/./r . ',';
    print $outh $dom->findvalue('//pozycja/kod_waluty[text()=\'EUR\']/../kurs_sredni') =~ s/,/./r . ',';
    print $outh $dom->findvalue('//pozycja/kod_waluty[text()=\'CHF\']/../kurs_sredni') =~ s/,/./r . ',';
    print $outh $dom->findvalue('//pozycja/kod_waluty[text()=\'USD\']/../kurs_sredni') =~ s/,/./r . ',';
    print $outh $dom->findvalue('//pozycja/kod_waluty[text()=\'NOK\']/../kurs_sredni') =~ s/,/./r . "\n";

}
