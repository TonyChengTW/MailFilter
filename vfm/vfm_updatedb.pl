#!/bin/perl
#------------------------------
#Writer : Mico Cheng
#Version: 20040719
#Use for: update IS list
#Host   : mx3.mail.apol.com.tw
#------------------------------
use DBI;

chomp($today = `date +%Y%m%d`);
$is_list_dir = "/export/home/mico/vfm/";
$is_list_apol_file = $today."_APOL.txt";
$is_list_ebtnet_file = $today."_EBTNET.txt";
$is_list_apol = $is_list_dir.$is_list_apol_file;
$is_list_ebtnet = $is_list_dir.$is_list_ebtnet_file;

open IS_APOL, "$is_list_apol" or die "can\'t open $is_list_apol:$!\n";
open IS_EBTNET, "$is_list_ebtnet" or die "can\'t open $is_list_ebtnet:$!\n";
$dbh = DBI->connect('DBI:mysql:mail_apol;host=localhost',
                    'rmail',
                    'LykCR3t1') or die "$!\n";

while (<IS_APOL>) {
     chomp;
     next if ($_ eq "mail.apol.com.tw");
     $sqlstmt = sprintf("update MailCheck set s_mhost='is' 
                        where s_mailid='%s'", $_);
     $dbh->do($sqlstmt);
     printf("update MailCheck set s_mhost='is' where s_mailid='%s'\n", $_);
}


while (<IS_EBTNET>) {
     chomp;
     next if ($_ eq "mail.ebtnet.net");
     $sqlstmt = sprintf("update MailCheck set s_mhost='is' 
                        where s_mailid='%s'", $_);
     $dbh->do($sqlstmt);
     printf("update MailCheck set s_mhost='is' where s_mailid='%s'\n", $_);
}

# delete b4 30 days List files
system "/usr/local/bin/find /export/home/mico/vfm/200* -type f -mtime +30 -exec rm -f {} \\;";

$dbh->disconnect(); 
close(IS_APOL); 
close(IS_EBTNET); 
