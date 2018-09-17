#!/usr/bin/env perl

use strict;
use warnings;

# https://perldoc.perl.org/Term/ANSIColor.html
use Term::ANSIColor;

# https://stackoverflow.com/questions/787899/how-do-i-use-a-perl-module-from-a-relative-location
use FindBin; # pour utiliser une bibliothèque
use lib "$FindBin::Bin/lib"; # pour utiliser une bibliothèque

use FileNode;


my %hashStatus;
my @domaine;

sub oneLevelDown {
	my $node = shift;	
	my $fileNumber = shift;
	
	$fileNumber++;
	
	my $positionInFile = 0;
	for my $word ($node->grep()) {
		$positionInFile++;
		if (exists ($hashStatus{$word})) { next };
		
 		my $newNode = FileNode->new($node, $word, $fileNumber, $positionInFile);
		push @domaine, $newNode;
		print $word . "\n";
		
		if ($newNode->isGreen()) {
			$hashStatus{$word} = "green";
			oneLevelDown($newNode, $fileNumber);
		} else {
			$hashStatus{$word} = "red";
		}
	}
}

# command line
(@ARGV > 0)  or die "Il est obligatoire de donner le fichier principal a analyser en paramètre";

my $inputFileName = $ARGV[0];

open (my $inputFile, '<', $inputFileName) or die "Could not open file $inputFileName";

$hashStatus{$inputFileName} = "green";

my $node = FileNode->initiate($inputFileName, $inputFile);

push @domaine, $node;
oneLevelDown($node, 0);

print "Bilan : \n";
for my $node (@domaine) {
	if ($node->isGreen) {
		print color('bold green');
	} else {
		print color('bold red');
	}
	
	print $node->get("absoluteFileName") . " " . $node->get("fileNumber") . " " . $node->get("positionInFile") ."\n";
	print color('reset');
}
 
