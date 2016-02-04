#!/usr/bin/perl 
# ====================================================== 
# Writer   : Mico Cheng 
# Version  : 20050104
# Use for  : adduser to MailCheck
# Host     : x
# ====================================================== 
if ($#ARGV != 0)
{
     print "\nusage:    adduser.pl <account> \n";
     exit;
}


use DBI; 

$s_mailid = $ARGV[0]; 
$s_mbox=sprintf("%s/%s/%s", substr($s_mailid, 0, 1), substr($s_mailid, 1, 1),$s_mailid);
$dbh = DBI ->connect("DBI:mysql:mail_apol;host=203.79.224.114", "rmail", "xxxxxxx") or die "$!\n"; 

$sqlstmt = sprintf("insert into MailCheck values ('%s', '1', 'rmail' , '%s', '0')", $s_mailid, $s_mbox); 

print "$sqlstmt\n";
$dbh->do($sqlstmt); 

$dbh->disconnect(); 
close(ACCESS); 
