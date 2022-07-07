#!/usr/bin/perl

# small script to test mod_dosevasive's effectiveness

use IO::Socket;
use strict;

my $addr = "yourwebsite.com";
my $port = "80";

for ( 1 .. 128 ) {
	my ($response);
	my ($SOCKET) =
		new IO::Socket::INET( Proto => "tcp", PeerAddr => "$addr:$port" );
	if ( !defined $SOCKET ) { die $!; }
	print $SOCKET "GET /?$_ HTTP/1.1\r\nHost: $addr\r\n\r\n";
	$response = <$SOCKET>;
	print "$_ $response";
	close($SOCKET);
}
