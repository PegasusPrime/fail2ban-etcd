#!/usr/bin/perl
use warnings;
use strict;
#On centos 7, install perl-JSON, perl-libwww-perl
use JSON;
use LWP::Simple; 
my $url = 'http://127.0.0.1:2379/v2/keys/fail2ban/SSH?recursive=true';
my $json = get( $url );
my $decode = decode_json($json);

for my $subnode ( keys $decode->{node}->{nodes} ) {
  my $ip = (split '/', $decode->{node}->{nodes}->[$subnode]->{key})[-1];
  #print "fail2ban-client set sshd banip $ip\n";
  system("fail2ban-client set sshd banip $ip");
}
