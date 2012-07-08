package Dist::Zilla::PluginBundle::Author::Celogeek;

# ABSTRACT: Dist::Zilla like Celogeek

=head1 OVERVIEW

This is the bundle of Celogeek, and is equivalent to create this dist.ini :

  [@Filter]
  -bundle = @Basic
  -remove = MakeMaker
  [@Git]
  [ModuleBuild]
  [ReportVersions]
  [OurPkgVersion]
  [NextRelease]
  [Prepender]
  copyright = 1
  [AutoPrereqs]
  [Prereqs]
  [MinimumPerl]
  [Test::Compile]
  [CheckChangeLog]
  [Test::UnusedVars]
  [PruneFiles]
  [ReadmeMarkdownFromPod]
  [MetaResourcesFromGit]
  bugtracker.web = https://github.com/%a/%r/issues
  [MetaConfig]
  [PodWeaver]
  config_plugin = @Celogeek

=cut

use strict;
use warnings;
use Carp;
use Data::Dumper;

# VERSION

use Moose;
use Class::MOP;
with 'Dist::Zilla::Role::PluginBundle::Easy', 'Dist::Zilla::Role::PluginBundle::PluginRemover';

sub configure {
    my $self = shift;

    $self->add_bundle('Filter', {bundle => '@Basic', remove => ['MakeMaker']});
    $self->add_bundle('Git');
    $self->add_plugins(
        'ModuleBuild',
        'ReportVersions',
        'OurPkgVersion',
        'NextRelease',
        [ 'Prepender' => { copyright => 1 } ],
        'AutoPrereqs',
        'Prereqs',
        'MinimumPerl',
        'Test::Compile',
        'CheckChangeLog',
        'Test::UnusedVars',
        'PruneFiles',
        'ReadmeMarkdownFromPod',
        [ 'MetaResourcesFromGit' => { 'bugtracker.web' => 'https://github.com/%a/%r/issues'} ],
        'MetaConfig',
        ['PodWeaver' => { 'config_plugin' => '@Celogeek' } ],
    );

}

1;
