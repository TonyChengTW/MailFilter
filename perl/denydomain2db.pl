#!/usr/bin/perl 
# ====================================================== 
# Writer   : Mico Cheng 
# Version  : 2004070701 
# Use for  : transfer Deny Domain to DenyDomain Table
# Host     : x
# ====================================================== 
if ($#ARGV != 0)
{
     print "\nusage:    denymail2db.pl /root/mico/listing/denydomain.list \n";
     exit;
}


use DBI; 

$accessfile = $ARGV[0]; 
print $accessfile;

$dbh = DBI ->connect("DBI:mysql:mail_apol;host=203.79.224.115", "rmail", "xxxxxxx") or die "$!\n"; 

open ACCESS, "$accessfile" or die "Can not open $accessfile:$!\n"; 

foreach (<ACCESS>) { 
      if (/^(.*\..*)$/) { 
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
     $sqlstmt = sprintf("insert into DenyDomain values ('%s', NOW(), 'add by mico')", $_[0]); 
        $dbh->do($sqlstmt); 
#  } else { 
#        next; 
#  } 
} 
