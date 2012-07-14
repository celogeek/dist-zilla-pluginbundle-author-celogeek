package Pod::Weaver::PluginBundle::Celogeek;

=head1 OVERVIEW

This bundle is equivalent to : (default + Bugs section)

  [@CorePrep]

  [Name]
  [Version]

  [Region  / prelude]

  [Generic / SYNOPSIS]
  [Generic / DESCRIPTION]
  [Generic / OVERVIEW]

  [Collect / ATTRIBUTES]
  command = attr

  [Collect / METHODS]
  command = method

  [Leftovers]

  [Region  / postlude]

  [Bugs]
  [Authors]
  [Legal]

=cut

use strict;
use warnings;
# ABSTRACT: a bundle that add Bugs section to the Default bundle
# VERSION

use namespace::autoclean;

use Pod::Weaver::Config::Assembler;
sub _exp { return Pod::Weaver::Config::Assembler->expand_package($_[0]) }

sub mvp_bundle_config {
  return (
    [ '@Default/CorePrep',  _exp('@CorePrep'), {} ],
    [ '@Default/Name',      _exp('Name'),      {} ],
    [ '@Default/Version',   _exp('Version'),   {} ],

    [ '@Default/prelude',   _exp('Region'),    { region_name => 'prelude'  } ],
    [ 'SYNOPSIS',           _exp('Generic'),   {} ],
    [ 'DESCRIPTION',        _exp('Generic'),   {} ],
    [ 'OVERVIEW',           _exp('Generic'),   {} ],

    [ 'ATTRIBUTES',         _exp('Collect'),   { command => 'attr'   } ],
    [ 'METHODS',            _exp('Collect'),   { command => 'method' } ],
    [ 'FUNCTIONS',          _exp('Collect'),   { command => 'func'   } ],

    [ '@Default/Leftovers', _exp('Leftovers'), {} ],

    [ '@Default/postlude',  _exp('Region'),    { region_name => 'postlude' } ],

    [ '@Default/Bugs'    ,   _exp('Bugs'),   {} ],
    [ '@Default/Authors',   _exp('Authors'),   {} ],
    [ '@Default/Legal',     _exp('Legal'),     {} ],
  )
}

1;

