package FileNode;    # Nom du package, de notre classe

use warnings;        # Avertissement des messages d'erreurs
use strict;          # Vérification des déclarations

sub new {
	my ( $class, $directory, $line ) = @_; # passage des paramètres
	my $this = {}; # création d'une référence vers un hachage  
	
	bless $this, $class; # pour rendre le hachage différent
}

sub initiate {

	# intialisation avec un chemin absolu

	my ( $class, $absoluteFileName, $underlyingFile ) = @_; # passage des paramètres
	my $this = {}; # création d'une référence vers un hachage  

	print $absoluteFileName;
	
	$this->{"absoluteFileName"} = $absoluteFileName;	
	$this->{"underlyingFile"} = $underlyingFile;
	
	bless $this, $class; # pour rendre le hachage différent
}

sub grep {
	my $this = shift; # pour se retrouver soi même	
		
	my @result;
	
	my $inputFile = $this->{"underlyingFile"};			
	
	while (my $line = <$inputFile>) {	
		push @result, $line;
	}
	
	return @result;
}

1;                # Important, à ne pas oublier