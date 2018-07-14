#!/usr/bin/perl
use warnings;
use strict;
use JSON;
use LWP::Simple;
my $ua = LWP::UserAgent->new;
my $url = 'https://url';
my ($login_url, $realm, $user, $pass) = ("url.domain.here:443", "Blacklist", "etcd", "bl0cked");
$ua->credentials($login_url, $realm, $user, $pass);
my $json = $ua->get( $url );
my $decode = decode_json($json->content);

for my $ip (@{$decode}) {
 system("fail2ban-client set sshd banip $ip");
}
