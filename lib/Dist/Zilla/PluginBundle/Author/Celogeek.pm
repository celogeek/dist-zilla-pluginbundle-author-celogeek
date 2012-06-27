package Dist::Zilla::PluginBundle::Author::Celogeek;

# ABSTRACT: Dist::Zilla like Celogeek

use strict;
use warnings;

# VERSION

use Moose;
use Class::MOP;
with 'Dist::Zilla::Role::PluginBundle::Easy', 'Dist::Zilla::Role::PluginBundle::PluginRemover';

has 'git_user' => (
    is => 'ro',
    isa => 'Str',
    default => 'UnknownUser',
    required => 1,
);

has 'git_project' => (
    is => 'ro',
    isa => 'Str',
    default => 'UnknownProject',
    required => 1,
);

sub configure {
    my $self = shift;
    my $gituser = $self->git_user;
    my $gitproject = $self->git_project;

    $self->add_bundle('Filter', {bundle => '@Basic', remove => ['MakeMaker']});
    $self->add_bundle('Git');
    $self->add_plugins(
        'ModuleBuild',
        'ReportVersions',
        'PodWeaver',
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
        [ 'MetaResources' => { 
                'repository.type' => 'git',
                'repository.web' => 'https://github.com/'.$gituser.'/'.$gitproject,
                'repository.url' => 'https://github.com/'.$gituser.'/'.$gitproject.'.git',
            } ],
    );

}

1;
