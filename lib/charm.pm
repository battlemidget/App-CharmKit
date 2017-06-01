package charm;

use strict;
use warnings;
no bareword::filehandles;
no indirect ':fatal';

use autobox                ();
use autobox::Core          ();
use true                   ();
use feature                ();
use Path::Tiny             ();
use Test::More             ();
use Rex                    ();
use Rex::Commands          ();
use Rex::Commands::File    ();
use Rex::Commands::Fs      ();
use Rex::Commands::MD5     ();
use Rex::Commands::Network ();
use Rex::Commands::Notify  ();
use Rex::Commands::Pkg     ();
use Rex::Commands::Run     ();
use Rex::Commands::SCM     ();
use Rex::Commands::Service ();
use Rex::Commands::User    ();
use POSIX                  ();
use Data::Printer          ();

use Import::Into;

sub import {
    my $target = caller;
    my $class  = shift;

    my @flags = grep /^-\w+/, @_;
    my %flags = map +($_, 1), map substr($_, 1), @flags;

    'strict'->import::into($target);
    'warnings'->import::into($target);
    'English'->import::into($target, '-no_match_vars');
    'autobox'->import::into($target);
    'autobox::Core'->import::into($target);

    warnings->unimport('once');
    warnings->unimport('experimental');
    warnings->unimport('experimental::signatures');
    warnings->unimport('reserved');

    bareword::filehandles->unimport;
    indirect->unimport(':fatal');

    feature->import(':5.20');
    feature->import('signatures');

    true->import;

    POSIX->import::into($target, qw(strftime));
    Rex->import::into($target, '-feature' => [qw(no_path_cleanup disable_taskname_warning)]);
    Rex::Commands->import::into($target);
    Rex::Commands::File->import::into($target);
    Rex::Commands::Fs->import::into($target);
    Rex::Commands::MD5->import::into($target);
    Rex::Commands::Network->import::into($target);
    Rex::Commands::Notify->import::into($target);
    Rex::Commands::Pkg->import::into($target);
    Rex::Commands::Run->import::into($target);
    Rex::Commands::SCM->import::into($target);
    Rex::Commands::Service->import::into($target);
    Rex::Commands::User->import::into($target);
    Path::Tiny->import::into($target, qw(path cwd));
    Data::Printer->import::into($target);

    if ($flags{tester}) {
        Test::More->import::into($target);
    }
}

1;
