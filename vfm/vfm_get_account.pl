#!/usr/bin/perl -w
open (STDERR, ">> /export/home/mico/vfm/vfm_account.err");

use strict;
use diagnostics;
use Net::FTP;
use DBI;
require "/export/home/mico/vfm/Utility.pm";

my ($hostname,$datasource,$dbname,$username,$pass,$port);
my ($sql,$dbh,$mail_count,$todate,$tmpfile,$realfile,$logfilepath,$logfile);
my ($arr_ref,@arr);

($hostname,$datasource,$dbname,$username,$pass,$port)=&Utility'Parameter();
$todate=`date +%Y%m%d`;
chomp($todate);
$logfilepath='/export/home/mico/vfm';
$logfile=$logfilepath.'/'.$todate.'.log';
open (LOGFILE, "> $logfile");

$dbh = DBI->connect("DBI:$datasource:$dbname:$hostname:$port","$username","$pass");

#APOL Email
$tmpfile=$logfilepath.'yyyymmdd_APOL.txt';
$realfile=$logfilepath.'/'.$todate.'_APOL.txt';

open (APOL, "> $tmpfile");
print APOL "mail.apol.com.tw\n";
$sql="select cust_id from service.vfm where type='APOL' and vfm != 'N' and ((close_date is NULL) or (close_date > SYSDATE()))";
$arr_ref=$dbh->selectall_arrayref($sql);
undef @arr;
@arr=@{$arr_ref};
foreach (@arr) {
	$_=@{$_}[0];
	print LOGFILE 'APOL:'.$_.'	';
	
	#找email帳號
	$sql="select username from dialup.email where cust_id=".$_;
	$mail_count=$dbh->selectrow_array($sql);
	if ($dbh->errstr) {
		print LOGFILE $dbh->errstr."\n";
		next;
	}
	
	if ((defined $mail_count) && ($mail_count ne '')) {
		print APOL $mail_count."\n" ;
		print LOGFILE $mail_count."\n";
	} else {
		print LOGFILE '無email帳號'."\n";
	}
}
close (APOL);
`/bin/mv $tmpfile $realfile`;

#EBT Email
$tmpfile=$logfilepath.'/yyyymmdd_EBTNET.txt';
$realfile=$logfilepath.'/'.$todate.'_EBTNET.txt';

open (EBTNET, "> $tmpfile");
print EBTNET "mail.ebtnet.net\n";
$sql="select cust_id from service.vfm where type='EBTNET' and vfm != 'N' and ((close_date is NULL) or (close_date > SYSDATE()))";
$arr_ref=$dbh->selectall_arrayref($sql);
undef @arr;
@arr=@{$arr_ref};
foreach (@arr) {
	$_=@{$_}[0];
	print LOGFILE 'EBTNET:'.$_.'	';
	
	#找email帳號
	$sql="select username from dialup.emailebt where cust_id=".$_;
	$mail_count=$dbh->selectrow_array($sql);
	if ($dbh->errstr) {
		print LOGFILE $dbh->errstr."\n";
		next;
	}
	
	if ($mail_count ne '') {
		print EBTNET $mail_count."\n" ;
		print LOGFILE $mail_count."\n";
	} else {
		print LOGFILE '無email帳號'."\n";
	}
}
close (EBTNET);
`/bin/mv $tmpfile $realfile`;

close (LOGFILE);
$dbh->disconnect if defined $dbh;

#`/usr/local/bin/ncftpput -uvfm -pvirusfreemail -P21 -a 203.79.224.112 /home/vfm/ /home/SVscript/TRED/log/ftp/$todate*.txt`;
#`/usr/local/bin/ncftpput -uvfm -pvirusfreemail -P21 -a 203.79.224.114 /home/vfm/ /home/SVscript/TRED/log/ftp/$todate*.txt`;
# Add by Mico 20040719
#`/usr/local/bin/ncftpput -uvfm -pvirusfreemail -P21 -a 203.79.224.115 /export/home/vfm/ /home/SVscript/TRED/log/ftp/$todate*.txt`;
