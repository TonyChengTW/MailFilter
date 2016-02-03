#!/bin/perl 
# ====================================================== 
# Writer   : Mico Cheng 
# Version  : 20060119
# Use for  : Insert account into Mail Check
# ====================================================== 

use DBI; 

$accountfile = shift;

$dbh = DBI ->connect("DBI:mysql:mail_apol;host=203.79.224.115", "rmail", 
"LykCR3t1") or die "$!\n"; 


open ACCESS, "$accountfile" or die "Can not open $accountfile:$!\n"; 
foreach (<ACCESS>) { 
    chomp;
    print "line: $_\n"; 
    $sqlstmt = sprintf("insert into MailCheck values ('%s', '1', 'rmail' , '%s', '0')", $_, 'any'); 
    $dbh->do($sqlstmt); 
} 
$dbh->disconnect(); 
close(ACCESS); 
