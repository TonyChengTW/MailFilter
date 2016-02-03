#!/usr/bin/perl 
# ====================================================== 
# Writer   : Mico Cheng 
# Version  : 2004071201 
# Use for  : transfer Allow IP to AllowIP Table
# Host     : x
# ====================================================== 
if ($#ARGV != 0)
{
     print "\nusage:    allowip2db.pl /root/mico/listing/allowip.list \n";
     exit;
}


use DBI; 

$accessfile = $ARGV[0]; 
print $accessfile;

$dbh = DBI ->connect("DBI:mysql:mail_apol;host=203.79.224.115", "rmail", "LykCR3t1") or die "$!\n"; 

open ACCESS, "$accessfile" or die "Can not open $accessfile:$!\n"; 

foreach (<ACCESS>) { 
      if (/^(\d+\.\d+\.\d+\.\d+)$/) { 
            &insertip($1); 
      } elsif (/^(\d+\.\d+\.\d+)$/) { 
            @range = 1..254; 
            $trustcip = $1; 
            foreach $one (@range) { 
                   $trustip = "$trustcip."."$one"; 
                   insertip($trustip); 
            } 
      } elsif (/^(\d+\.\d+)$/) { 
            @range_a = 0..31; 
            @range_b = 1..254; 
            $trustbip = $1; 
            foreach $one (@range_a) { 
                 foreach $two (@range_b) { 
                        $trustip = "$trustbip."."$one."."$two"; 
                        insertip($trustip); 
                 } 
            } 
      } else { 
            print "this line is not match IP format: $_\n"; 
      } 
} 
$dbh->disconnect(); 
close(ACCESS); 

sub insertip { 
#  $sqlstmt = sprintf("select s_ip from TrustIP where s_ip=\'%s\'", $_[0]); 
#  $sth = $dbh->prepare($sqlstmt); 
#  $sth->execute() or die "can not insert : $!\n"; 
#  if ($sth->rows != 1) { 
     $sqlstmt = sprintf("insert into TrustIP values ('%s', NOW(), 'add by mico')", $_[0]); 
        $dbh->do($sqlstmt); 
#  } else { 
#        next; 
#  } 
} 
