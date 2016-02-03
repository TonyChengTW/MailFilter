#!/usr/bin/perl 
# ====================================================== 
# Writer   : Mico Cheng 
# Version  : 2004070701 
# Use for  : transfer Deny E-Mail to DenyMailfrom Table
# Host     : x
# ====================================================== 
if ($#ARGV != 0)
{
     print "\nusage:    denymail2db.pl /root/mico/listing/denymail.list \n";
     exit;
}


use DBI; 

$accessfile = $ARGV[0]; 
print $accessfile;

$dbh = DBI ->connect("DBI:mysql:mail_apol;host=203.79.224.115", "rmail", "LykCR3t1") or die "$!\n"; 

open ACCESS, "$accessfile" or die "Can not open $accessfile:$!\n"; 

foreach (<ACCESS>) { 
      if (/^(.*@.*)$/) { 
            &insertip($1); 
      } else { 
            print "this line is not match E-Mail format: $_\n"; 
      } 
} 
$dbh->disconnect(); 
close(ACCESS); 

sub insertip { 
#  $sqlstmt = sprintf("select s_ip from TrustIP where s_ip=\'%s\'", $_[0]); 
#  $sth = $dbh->prepare($sqlstmt); 
#  $sth->execute() or die "can not insert : $!\n"; 
#  if ($sth->rows != 1) { 
     $sqlstmt = sprintf("insert into DenyMailfrom values ('%s', NOW(), 'add by mico')", $_[0]); 
        $dbh->do($sqlstmt); 
#  } else { 
#        next; 
#  } 
} 
