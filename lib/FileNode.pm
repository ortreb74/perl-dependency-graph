package FileNode;    # Nom du package, de notre classe

use warnings;        # Avertissement des messages d'erreurs
use strict;          # Vérification des déclarations

sub new {
	my ( $class, $originalNode, $originalText ) = @_; # passage des paramètres
	my $this = {}; # création d'une référence vers un hachage  
	
	$this->{"absoluteFileName"} = computeRelativeName($originalNode->{"absoluteFileName"}, $originalText);
	
	if (open(my $inputFile, '<', $this->{"absoluteFileName"} )) {
		$this->{"underlyingFile"} = $inputFile;
		$this->{"green"} = 1;
	} else {
		print "impossible de trouver le fichier : " . $this->{"absoluteFileName"} . "\n"; 
	}
	
	bless $this, $class; # pour rendre le hachage différent
}

sub initiate {
	# intialisation avec un chemin absolu

	my ( $class, $absoluteFileName, $underlyingFile ) = @_; # passage des paramètres
	my $this = {}; # création d'une référence vers un hachage  	
	
	$this->{"absoluteFileName"} = $absoluteFileName;	
	$this->{"underlyingFile"} = $underlyingFile;
	$this->{"green"} = 1;
	
	bless $this, $class; # pour rendre le hachage différent
}

sub grep {
	my $this = shift; # pour se retrouver soi même	
		
	my @result;
	
	my $inputFile = $this->{"underlyingFile"};			
	
	while (my $line = <$inputFile>) {	
		if ($line =~ /#include\s+.(.+).\s*$/) {
			push @result, $1;
		}			
	}
	
	return @result;
}

sub isGreen {
	my $this = shift; # pour se retrouver soi même	
	return exists($this->{"green"});
}

sub get {
	my ($this, $key) = @_;
	
	return $this->{$key};
}


sub computeRelativeName{
	(my $baseName, my $nextName) = @_;
	print "adresse à déterminer à partir de $baseName et $nextName \n";
	
	# soit $nextName commence par un / et result = $nextName
	if (substr($nextName,0,1) eq "/") {
		return $nextName;
	} else {
		# sinon on enlève le dernier mot de basename on rajoute un / et on concatène les deux
		$baseName =~ m!(.*/).*$!;
		return $1 . $nextName;
	}
}

1;                # Important, à ne pas oublier