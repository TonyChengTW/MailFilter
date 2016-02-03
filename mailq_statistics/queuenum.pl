#!/usr/local/bin/perl
#==============================================================
#-----------------------
# Version : 2004082701
# Writer  : Mico Cheng
# Use for : Accounting Mail Queue for
# Host    : Rmail MS Server
# Filename: queuenum.pl
#-----------------------

$active_mailq=0;$deferred_mailq=0;$incoming_mailq=0;
$queue_base_dir = "/export/home/queue";
@queue_main_array = qw/ active deferred incoming /;
@queue_hash_array = qw/ 0 1 2 3 4 5 6 7 8 9 A B C D E F /;

foreach $queue_main_dir (@queue_main_array) {
    foreach $queue_hash1_dir (@queue_hash_array) {
         foreach $queue_hash2_dir (@queue_hash_array) {
              foreach $queue_hash3_dir (@queue_hash_array) {
                  $queue_whole_dir = $queue_base_dir."/".$queue_main_dir."/".$queue_hash1_dir."/".$queue_hash2_dir."/".$queue_hash3_dir;
                  opendir DH, $queue_whole_dir;
                  foreach (readdir DH) {
                        #next if $_ =~ /^\..*/;
                        next if $_ eq "..";
                        next if $_ eq ".";
                        if ($queue_main_dir eq 'active') {
                               $active_mailq++;
                        } elsif ($queue_main_dir eq 'deferred') {
                               $deferred_mailq++;
                        } else {
                               $incoming_mailq++;
                        }
                  }
                  closedir DH;
              }
         }
    }
}
print "Active:$active_mailq\n";
print "Deferred:$deferred_mailq\n";
print "Imcoming:$incoming_mailq\n";
