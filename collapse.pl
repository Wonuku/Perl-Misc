#!/usr/bin/env perl

use strict;
use warnings;
use Switch;
use Getopt::Long;

use constant HELPTEXT => "CollapseC - an utility to collapse a C/C++ source file into a single line\n\t-e --encoding\tSpecify an encoding different then UTF-8 options include UTF-16, ASCII, EBCDIC\n\t-w --write\tDon't print to stdout write the collapsed programs to the disc alongside files this is needed when collapsing more than one file and will be automaticly set\n\t--help\t\tDisplays this help text\n";

my $argc = $#ARGV + 1;
$argc >= 1 or die "Missing arguments try \'$0 --help\' for more information\n";

my ($encoding, $encodearg, $wd);
$encodearg = 0;

GetOptions ('e' => \$encodearg, 'encoding=s' => \$encodearg, 'w' => \$wd, 'help' => sub {die HELPTEXT});
# turn on -w when passed more than one file
$encoding = encodef($encodearg);
$encoding != 0 or $encoding = "UTF-8";

foreach my $fn ( @ARGV ) {
    my ($fh, $wfh);
    open($fh, "<:encoding($encoding)", $fn) or die "Can't open $fn\n"; # maybe just skip it?
    open ($wfh, ">", "$fn" . "") if defined $wd;
    select $wfh if defined $wd;

      foreach my $line ( <$fh> ) {
          if (length($line) == 0) {
            next;
          }

          if ( substr($line, 0, 1) eq '#' ) {
            print $line;
            next;
          }

          if ($line =~ /\/\/.*[^\S\n]*$/) {
            $line =~ s/\/\/.*[^\S\n]*$//;
          }
          if ($line =~ / */) {
            $line =~ s/ *//;
          }

          chomp $line;
          print $line;
      }

      close $fh;
      close $wfh;
      print "\n" if not defined $wd;
      select STDOUT;
}

sub encodef {
    my $val = shift;
      switch (lc $val){
        case "utf8" { return "UTF-8" }
        case "utf16" { return "UTF-16" }
        case "ascii" { return "ASCII" }
        case "ebdic" { return "EBCDIC" }
        else { return 0 }
      }
}
