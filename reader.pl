#!/usr/bin/perl
use warnings;
use strict;
use JSON;
use LWP::Simple;
use Sys::Syslog qw(:DEFAULT setlogsock);
my $ua = LWP::UserAgent->new;
my $url = 'url.domain.here';
my $req = HTTP::Request->new( GET => "https://$url:443/url");
$req->authorization_basic( "etcd", "bl0cked4u" );
my $resp = $ua->request($req);
if (! $resp->is_success) {
  die "Invalid response\n", $resp->decoded_content();
}
my $decode = decode_json($resp->content);

openlog('reader.pl', 'cons,pid', 'user');
for my $ip (@{$decode}) {
  system("fail2ban-client set sshd banip $ip");
  syslog('info',"Added $ip to fail2ban");
}
closelog();
