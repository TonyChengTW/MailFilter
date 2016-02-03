#!/usr/bin/perl

use DBI;

require "config.pl";

die "scan_virus_domain_rewrite.pl virus_scan_list_filename\n" if (scalar(@ARGV)!=1)
;
die "File ".$ARGV[0]." seem like doesn't exist!" if (!-e $ARGV[0]);

$g_start=time();
$file = $ARGV[0];
$dsn=sprintf("DBI:mysql:%s;host=%s", $DB{'mta'}{'name'}, $DB{'mta'}{'host'});
$dbh=DBI->connect($dsn, $DB{'mta'}{'user'}, $DB{'mta'}{'pass'})
        || die_db($!);
open(FH, "$file");
while (<FH>) {
        chomp();
        $sqlstmt=sprintf("update MailCheck set s_mhost='is' where s_mailid='%s'", $_);
        printf("$sqlstmt\n");
        $dbh->do($sqlstmt);
}
$dbh->disconnect();
