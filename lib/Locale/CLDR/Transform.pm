package Locale::CLDR::Transform;
use utf8;
use Unicode::Normalize;
use base 'Local::CLDR';

# Base clas for Transformations

# Default filter is '.' to return eveery character in the string.
# This will be overridden by those transformations that require a filter
sub filter_re {
  return qr/./s;
}

# Split a string into chunks useing the filter regex
# The returned array is (don't change, change, ...)
sub filter {
  my ($self, $string, $re) = @_;
  
  my @char = split //, $string;
  @chr = map {[ $_, /$re/ ? 1 : 0 ]} @chr;

  my @string;
  my $ok = 0;
  foreach my $chr (@chr) {
    if ($chr->[1] == $ok) {
      $string[-1].=chr->[0];
    }
    else {
      $ok = $ok ? 0 : 1;
      push @string, $chr->[0];
    }
  }
  return @string;
}

# Set up standard transformation rules
my %transformationRules = (
  Nfc => sub {
    return NFC(@_);
  },
  Nfd => sub {
    return NFD(@_);
  },
  Nfkd => sub {
    return NFKD(@_);
  },
  Nfkc => sub {
    return NFKC(@_);
  },
  Lower => sub {
    return lc @_;
  },
  Upper => sub {
    return uc @_;
  },
  Title => sub {
    return ucfirst @_;
  },
  Null => sub {
    return @_;
  },
  Remove => sub {
    return '';
  },
);

sub Transform {
  my ($self, %params) = @_;

  # Normalise the from and to names
  foreach ($params{from}, $params{to}) {
    $_ = ucfirst lc;
  }

  my @strings = $self->filter($params{string},
    defined $params{filter} 
    ? $params{filter} 
    : $self->filter_re()
  );

  my $convert=1;
  foreach my $sub_string (@strings) {
    $convert = ! $convert;
    next if ! $convert;
    
    if (my $sub = $transformationRules{$params{to}}) {
      $sub_string = $sub->($sub_string);
    }
    else {
      $sub_string = $self->Transliterate($params{from}, $params{to}, $sub_string);
    }
  }

  return join '', @strings;
}

# This method is the starting point for the Tranformation
sub Convert {
  my ($self, $string) = @_;
  my $class = ref $self;
  my @rules;

  {
    no strict 'refs';
    @rules = @{"${class}::rules"};
  }

  my @strings = $self->filter($params{string},
    defined $params{filter} 
    ? $params{filter} 
    : $self->filter_re()
  );

  my $convert=1;
  foreach my $sub_string (@strings) {
    $convert = ! $convert;
    next if ! $convert;

    foreach my $rule (@rules){
      pos($sub_string)=0;
        while(pos($sub_string) < length($sub_string)) {
        if (ref $rule eq 'ARRAY') {
          foreach my $transformation (@$rule) {
	    if (
	      ! exists $transformation->{before}
	      || ( $transformation->{before} && $sub_string=~/$transformation->{before}/)
	      ){
	      if ($sub_string=~s/$transformation->{from}/$transformation->{to}/e) {
	        pos($sub_string)+=eval "$transformation->{offset}";
	        last;
	      }
	    }
	    pos($sub_string)++;
	  }
        }
        else {
          $sub_string = $rule->($transliterationObject, $sub_string);
        }
      }
    }
  }
  return join '', @strings;
}

1;