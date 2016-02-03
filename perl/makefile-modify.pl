#!/usr/bin/perl
if ($#ARGV != 0) {
    print "\nmakefile_modify.pl /root/mico/v1.2\n\n";
    exit;
}

$makefile_dir = $ARGV[0];
@files = `find $makefile_dir -name Makefile`;
foreach (@files) {
    $filename = $_;
    #system 'sed -e \'s/SYSLIBS.*$/SYSLIBS = -L\/usr\/local\/lib\/mysql -lmysqlclient -lz -lm -L\/usr\/local\/lib -lpcre -ldb -nsl -lresolv -lsocket/\''."$_"
    open MAKEFILE ,"$_" or die "can not open $_:$!\n";
    open MAKEFILE2 ,">/tmp/makefile.tmp" or die "can not open $_:$!\n";

    while(<MAKEFILE>) {
        s/^SYSLIBS.*$/SYSLIBS = -L\/usr\/local\/lib\/mysql -lmysqlclient -lz -lm -L\/usr\/local\/lib -lpcre -ldb -lnsl -lresolv/;
        print MAKEFILE2 $_;
    }
    system "mv /tmp/makefile.tmp $filename";
}
