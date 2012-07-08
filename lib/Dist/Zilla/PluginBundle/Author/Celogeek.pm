package Dist::Zilla::PluginBundle::Author::Celogeek;

# ABSTRACT: Dist::Zilla like Celogeek

=head1 OVERVIEW

This is the bundle of Celogeek, and is equivalent to create this dist.ini :

  [Git::NextVersion]
  first_version = 0.01
  [NextRelease]
  [@Git]
  allow_dirty = Changes
  allow_dirty = dist.ini
  allow_dirty = README.mkdn
  add_files_in = Changes
  add_files_in = dist.ini
  add_files_in = README.mkdn
  [@Filter]
  -bundle = @Basic
  -remove = MakeMaker
  [ModuleBuild]
  [ReportVersions]
  [OurPkgVersion]
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
  [Run::BeforeRelease]
  run = cp %d%pREADME.mkdn .

Here a simple dist.ini :

  name = MyTest
  license = Perl_5
  copyright_holder = celogeek <me@celogeek.com>
  copyright_year = 2011
  
  [@Author::Celogeek]

And it support remove, so you can use it for your apps deploy :

  name = MyTest
  license = Perl_5
  copyright_holder = celogeek <me@celogeek.com>
  copyright_year = 2011
  
  [@Author::Celogeek]
  -remove = UploadToCPAN
  [Run::Release]
  run = scripts/deploy.sh %s

Here my Changes file :

  {{$NEXT}}
    My changes log

When you will release, by invoking 'dzil release', it will automatically:

=over 2

=item * increment the version number (you dont add it in your program)

=item * collect change found in your Changes after the NEXT

=item * collect the markdown for github

=item * commit Changes, dist.ini and README.mkdn with a simple message (version and changes)

=item * add a tag

=item * push origin

=back


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

    $self->add_plugins(['Git::NextVersion' => { first_version => '0.01' }]);
    $self->add_plugins('NextRelease');
    $self->add_bundle('Git' => {'allow_dirty' => [qw/Changes dist.ini README.mkdn/], 'add_files_in' => [qw/Changes dist.ini README.mkdn/]});
    $self->add_bundle('Filter', {bundle => '@Basic', remove => ['MakeMaker']});
    $self->add_plugins(
        'ModuleBuild',
        'ReportVersions',
        'OurPkgVersion',
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
        ['Run::BeforeRelease' => { run => 'cp %d%pREADME.mkdn .'}]
    );

}

1;
