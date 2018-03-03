#!/usr/bin/env perl

use strict;
use warnings;
use Getopt::Long;
use Switch;

use constant HELPTEXT =>
"UwU - Obfuscate your files
\t-d --decode\tAttempts to decode an obfuscated file
\t-s --shift\tApply caesar cipher after obfuscation - shifts are to the right BROKEN DON'T USE
\t-? --help\tDisplays this help text
";

my $argc = $#ARGV + 1;
$argc > 0 or die "$0: missing arguments\nTry \'$0 --help\' for more information\n";

my ($decode, $rot);

GetOptions(
    'decode|d' => \$decode,
    'shift|s=i' => \$rot,
    'help|?' => sub {print HELPTEXT; exit;});

my @dir = (-1,1,-2,1,-2,3);

{
  my $sum;
  map { $sum += $_ } @dir;
  if ($sum != 0) {
    die "Direction array doesn't add up to 0!";
  }
}

################################################################################

my $fn = pop @ARGV;
open (my $fh, "<:unix", $fn) or die "Can't open $fn quitting..\n";

my $pos = 0;
my $prog = 0;

foreach my $line ( <$fh> ) {
  my $newline = "";

  if ($decode) {
    foreach my $c (split //, $line) {
      $newline .= deswitchChar($c);
    }
  } else {
    foreach my $c (split //, $line) {
      $newline .= switchChar($c);
    }
  }

    if (abs $dir[$pos] == $dir[$pos] ) { # positive - backwards
      $newline = reverse $newline;
    } # else negative - forwards

  $newline = ceaserCipher($newline, $rot) if $rot;
  print "$newline\n";

  if ($dir[$pos] == $prog) {
    $pos++;
    $prog = 0;
  }
}

sub switchChar {
  my $c = shift;
  my $nc = '`';

    if ($c eq 'A') {$nc = 'x'};
    if ($c eq 'B') {$nc = '*'};
    if ($c eq 'C') {$nc = 'l'};
    if ($c eq 'D') {$nc = 'v'};
    if ($c eq 'E') {$nc = 'p'};
    if ($c eq 'F') {$nc = 'q'};
    if ($c eq 'G') {$nc = '\\'};
    if ($c eq 'H') {$nc = '\''};
    if ($c eq 'I') {$nc = '>'};
    if ($c eq 'J') {$nc = 'P'};
    if ($c eq 'K') {$nc = 'Q'};
    if ($c eq 'L') {$nc = '|'};
    if ($c eq 'M') {$nc = '^'};
    if ($c eq 'N') {$nc = '3'};
    if ($c eq 'O') {$nc = 'b'};
    if ($c eq 'P') {$nc = 'U'};
    if ($c eq 'Q') {$nc = 'K'};
    if ($c eq 'R') {$nc = 'k'};
    if ($c eq 'S') {$nc = 'n'};
    if ($c eq 'T') {$nc = 'E'};
    if ($c eq 'U') {$nc = 'z'};
    if ($c eq 'V') {$nc = 'i'};
    if ($c eq 'W') {$nc = 'Z'};
    if ($c eq 'X') {$nc = 'm'};
    if ($c eq 'Y') {$nc = 'o'};
    if ($c eq 'Z') {$nc = 'A'};

    if ($c eq 'a') {$nc = '4'};
    if ($c eq 'b') {$nc = '3'};
    if ($c eq 'c') {$nc = '!'};
    if ($c eq 'd') {$nc = '#'};
    if ($c eq 'e') {$nc = '$'};
    if ($c eq 'f') {$nc = 'V'};
    if ($c eq 'g') {$nc = '='};
    if ($c eq 'h') {$nc = '1'};
    if ($c eq 'i') {$nc = 'a'};
    if ($c eq 'j') {$nc = '/'};
    if ($c eq 'k') {$nc = '['};
    if ($c eq 'l') {$nc = '('};
    if ($c eq 'm') {$nc = '.'};
    if ($c eq 'n') {$nc = ';'};
    if ($c eq 'o') {$nc = '2'};
    if ($c eq 'p') {$nc = '-'};
    if ($c eq 'q') {$nc = '@'};
    if ($c eq 'r') {$nc = '%'};
    if ($c eq 's') {$nc = ','};
    if ($c eq 't') {$nc = '<'};
    if ($c eq 'u') {$nc = '5'};
    if ($c eq 'v') {$nc = '7'};
    if ($c eq 'w') {$nc = '8'};
    if ($c eq 'x') {$nc = '9'};
    if ($c eq 'y') {$nc = '~'};
    if ($c eq 'z') {$nc = ')'};

    if ($c eq '0') {$nc = '}'};
    if ($c eq '1') {$nc = '&'};
    if ($c eq '2') {$nc = '_'};
    if ($c eq '3') {$nc = 'e'};
    if ($c eq '4') {$nc = 'c'};
    if ($c eq '5') {$nc = ']'};
    if ($c eq '6') {$nc = 'g'};
    if ($c eq '7') {$nc = ':'};
    if ($c eq '8') {$nc = 'd'};
    if ($c eq '9') {$nc = 'u'};
    if ($c eq ' ') {$nc = '+'};

    return $nc;
}

sub deswitchChar {
  my $c = shift;
  my $nc = '`';

  if ($c eq 'x') {$nc = 'A'};
  if ($c eq '*') {$nc = 'B'};
  if ($c eq 'l') {$nc = 'C'};
  if ($c eq 'v') {$nc = 'D'};
  if ($c eq 'p') {$nc = 'E'};
  if ($c eq 'q') {$nc = 'F'};
  if ($c eq '\\') {$nc = 'G'};
  if ($c eq '\'') {$nc = 'H'};
  if ($c eq '>') {$nc = 'I'};
  if ($c eq 'P') {$nc = 'J'};
  if ($c eq 'Q') {$nc = 'K'};
  if ($c eq '|') {$nc = 'L'};
  if ($c eq '^') {$nc = 'M'};
  if ($c eq '3') {$nc = 'N'};
  if ($c eq 'b') {$nc = 'O'};
  if ($c eq 'U') {$nc = 'P'};
  if ($c eq 'K') {$nc = 'Q'};
  if ($c eq 'k') {$nc = 'R'};
  if ($c eq 'n') {$nc = 'S'};
  if ($c eq 'E') {$nc = 'T'};
  if ($c eq 'z') {$nc = 'U'};
  if ($c eq 'i') {$nc = 'V'};
  if ($c eq 'Z') {$nc = 'W'};
  if ($c eq 'm') {$nc = 'X'};
  if ($c eq 'o') {$nc = 'Y'};
  if ($c eq 'A') {$nc = 'Z'};

  if ($c eq '4') {$nc = 'a'};
  if ($c eq '3') {$nc = 'b'};
  if ($c eq '!') {$nc = 'c'};
  if ($c eq '#') {$nc = 'd'};
  if ($c eq '$') {$nc = 'e'};
  if ($c eq 'V') {$nc = 'f'};
  if ($c eq '=') {$nc = 'g'};
  if ($c eq '1') {$nc = 'h'};
  if ($c eq 'a') {$nc = 'i'};
  if ($c eq '/') {$nc = 'j'};
  if ($c eq '[') {$nc = 'k'};
  if ($c eq '(') {$nc = 'l'};
  if ($c eq '.') {$nc = 'm'};
  if ($c eq ';') {$nc = 'n'};
  if ($c eq '2') {$nc = 'o'};
  if ($c eq '-') {$nc = 'p'};
  if ($c eq '@') {$nc = 'q'};
  if ($c eq '%') {$nc = 'r'};
  if ($c eq ',') {$nc = 's'};
  if ($c eq '<') {$nc = 't'};
  if ($c eq '5') {$nc = 'u'};
  if ($c eq '7') {$nc = 'v'};
  if ($c eq '8') {$nc = 'w'};
  if ($c eq '9') {$nc = 'x'};
  if ($c eq '~') {$nc = 'y'};
  if ($c eq ')') {$nc = 'z'};

  if ($c eq '}') {$nc = '0'};
  if ($c eq '&') {$nc = '1'};
  if ($c eq '_') {$nc = '2'};
  if ($c eq 'e') {$nc = '3'};
  if ($c eq 'c') {$nc = '4'};
  if ($c eq ']') {$nc = '5'};
  if ($c eq 'g') {$nc = '6'};
  if ($c eq ':') {$nc = '7'};
  if ($c eq 'd') {$nc = '8'};
  if ($c eq 'u') {$nc = '9'};
  if ($c eq '+') {$nc = ' '};

  return $nc;
}

sub ceaserCipher {
  my $line = shift;
  my $rot = shift;
  my @chars = map { "\Q@{[chr]}\E" } 32 .. 126;

  $rot %= @chars;

  my $plain_chars = join '' => @chars;
  my $cipher_chars = join('' => @chars[$rot .. $#chars, 0 .. $rot - 1]);

  my $ciphertext;
  eval "(\$ciphertext = \$line) =~ y/$plain_chars/$cipher_chars/";
  return $ciphertext;
}
