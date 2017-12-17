#!/usr/bin/env perl
# Convert list of hex numbers into decimal or vice versa

use strict;

my $bool = 0;

foreach my $val (@ARGV) {
    if ($val =~ /^0x[0-9A-F]+$/i) {
      $bool = 1;
    }
}

if ($bool) {
    for (my $i = 0; $i < @ARGV; $i++) {
      my $val = hex($ARGV[$i]);
      printf("0x%x = %d\n", $val, $val);
    }
} else {
    for (my $i = 0; $i < @ARGV; $i++) {
      printf("%d\t= 0x%x\n", $ARGV[$i], $ARGV[$i]);
    }
}
