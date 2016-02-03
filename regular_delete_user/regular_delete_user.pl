#!/usr/local/bin/perl
#-----------------------------------
#Writer : Mico Cheng
#Version: 20041231
#Host   : 210.200.211.3
#use for: regular_delete_user
#----------------------------------
use DBI;

$mail_file = shift || die "regular_delete_user.pl <list file>\n";
$ip_file = shift;

$dbh=DBI->connect('DBI:mysql:mail_apol:127.0.0.1', 'rmail', 'LykCR3t1') or die "can't connect DB\n";

open MAIL ,"$mail_file" or die "can't open $mail_file:$!\n";
while (<MAIL>) {
    chomp;
    $sqlstmt=sprintf("delete from MailCheck where s_mailid='%s'",$_);
    $sth=$dbh->prepare($sqlstmt);
    $sth->execute();
}

close MAIL;
