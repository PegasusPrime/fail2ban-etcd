#!/usr/bin/perl
use warnings;
use strict;
use JSON;
use LWP::Simple;
my $ua = LWP::UserAgent->new;
my $url = 'url.domain.here';
my $req = HTTP::Request->new( GET => "https://$url:443/url");
$req->authorization_basic( "etcd", "bl0cked4u" );
my $resp = $ua->request($req);
if (! $resp->is_success) {
 die "Invalid response\n", $resp->decoded_content();
}
my $decode = decode_json($resp->content);

for my $ip (@{$decode}) {
 system("fail2ban-client set sshd banip $ip");
}
