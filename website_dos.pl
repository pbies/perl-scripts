#!/usr/bin/perl
# (C) 2019 Piotr Biesiada

# small script to test mod_dosevasive's effectiveness

use IO::Socket;
use strict;

for(1..128) {
  my($response);
  my($SOCKET) = new IO::Socket::INET( Proto   => "tcp",
                                      PeerAddr=> "website.com:80");
  if (! defined $SOCKET) { die $!; }
  print $SOCKET "GET /?$_ HTTP/1.1\r\nHost: website.com\r\n\r\n";
  $response = <$SOCKET>;
  print "$_ $response";
  close($SOCKET);
}