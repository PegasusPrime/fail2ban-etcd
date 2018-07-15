#!/usr/bin/perl
use warnings;
use strict;
use JSON;
use LWP::Simple;
my $ua = LWP::UserAgent->new;
my $url = 'url.domain.here';
my ($login_url, $realm, $user, $pass) = ("$url:443", "Blacklist", "etcduser", "bl0cked4u");
$ua->credentials($login_url, $realm, $user, $pass);
my $resp = $ua->get( 'https://' . $url );
if (! $resp->is_success) {
 die "Invalid response\n$resp->decoded_content";
}
my $decode = decode_json($resp->content);

for my $ip (@{$decode}) {
 system("fail2ban-client set sshd banip $ip");
}
