#!/usr/bin/env perl

use strict;
use warnings;
use Getopt::Long;

use constant HELPTEXT => "Obfuscate - an utility to obfuscate C source file(s)\n\t-w --write\tWrites the obfuscated source files to the current dir with a modified name\n\t--help\t\tDisplays this help text\n";

my $argc = $#ARGV + 1;
$argc > 0 or die "$0: missing arguments\nTry \'$0 --help\' for more information\n";

my ($wd, $rv, $tab);

GetOptions(
'write|w' => \$wd,
'rename-vars|v' => \$rv,
'tabs|t' => \$tab,
'help|?' => sub {print HELPTEXT; exit;});
$argc = $#ARGV + 1;

$wd = 1 if $argc > 1;
die "$0: missing file operand\nTry \'$0 --help\' for more information" if $argc < 1;

foreach my $fn ( @ARGV ) {
    my ($fh, $wfh, %vars);
    (my $we = $fn) =~ s/\.[^.]+$//;

    open ($fh, "<", $fn) or die "Can't open $fn quitting..\n"; # maybe just skip it?
    open ($wfh, ">", "$we" . "-obfuscated.c") if defined $wd;

      foreach my $line ( <$fh> ) {
          next if length($line) == 0;

          print $line && next if substr($line, 0, 1) eq '#';

          $line =~ s/^\s+|\s+$//; # strip whitespace

          $line =~ s/\/\/.*[^\S\n]*$//; # delete single line comment

          chomp $line;
          print STDOUT $line;
          print $wfh $line if defined $wd;
      }

      close $fh;
      close $wfh if defined $wd;
      print "\n";
}

sub getName {

}
