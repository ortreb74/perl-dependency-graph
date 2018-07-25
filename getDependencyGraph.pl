#!/usr/bin/env perl

use strict;
use warnings;

# https://stackoverflow.com/questions/787899/how-do-i-use-a-perl-module-from-a-relative-location
use FindBin; # pour utiliser une bibliothèque
use lib "$FindBin::Bin/lib"; # pour utiliser une bibliothèque

use FileNode;

# command line
(@ARGV > 0)  or die "Il est obligatoire de donner le fichier principal a analyser en paramètre";

my $inputFileName = $ARGV[0];

open (my $inputFile, '<', $inputFileName) or die "Could not open file $inputFileName";

my $node = FileNode->initiate($inputFileName, $inputFile);

for my $word ($node->grep()) {
	print $word;
}