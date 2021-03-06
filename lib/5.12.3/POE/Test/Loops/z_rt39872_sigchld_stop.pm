#!/usr/bin/perl
# vim: ts=2 sw=2 expandtab

use strict;
use warnings;

sub DEBUG () { 0 }
my $REFCNT;

sub POE::Kernel::USE_SIGCHLD () { 1 }
sub POE::Kernel::ASSERT_DEFAULT () { 1 }

BEGIN {
  package POE::Kernel;
  use constant TRACE_DEFAULT => exists($INC{'Devel/Cover.pm'});
}

use Test::More;
use POSIX qw( SIGINT SIGUSR1 );
use POE;
use POE::Wheel::Run;

if ($^O eq "MSWin32" and not $ENV{POE_DANTIC}) {
  plan skip_all => "SIGUSR1 not supported on $^O";
  exit 0;
}

if ($INC{'Tk.pm'} and not $ENV{POE_DANTIC}) {
  plan skip_all => "Test causes XIO and other errors under Tk.";
  exit 0;
}

$SIG{__WARN__} = sub {
  print STDERR "$$: $_[0]";
};

plan tests => 3;

our $PARENT = 1;

POE::Session->create(
  inline_states => {
    _start => \&_start,
    _stop  => \&_stop,

    work   => \&work,
    child  => \&child,
    parent => \&parent,
    T1     => \&T1,
    T2     => \&T2,

    sig_CHLD => \&sig_CHLD,
    sig_USR1 => \&sig_USR1,
    done   => \&done
  }
);

DEBUG and warn "Parent";
$poe_kernel->run;
pass( "Sane exit" ) if $PARENT;
DEBUG and warn "Exit";

### End of main code.  Beginning of subroutines.

sub _start {
  my( $kernel, $heap ) = @_[KERNEL, HEAP];

  DEBUG and warn "_start";
  $kernel->alias_set( 'worker' );
  $kernel->sig( CHLD => 'sig_CHLD' );

  $kernel->yield( 'work' );
}

sub work {
  my( $kernel, $heap, $session ) = @_[KERNEL, HEAP, SESSION];

  foreach my $name ( qw( T1 T2 ) ) {
    my $pid = fork();
    die "Unable to fork: $!" unless defined $pid;

    if( $pid ) {        # parent
      $heap->{$name}{PID} = $pid;
      $heap->{pid2N}{ $pid } = $name;
    }
    else {
      $kernel->can('has_forked') and $kernel->has_forked();
      $kernel->yield( 'child' );
      return;
    }
  }

  foreach my $name ( qw( T1 T2 ) ) {
    $kernel->refcount_increment( $session->ID, $name );
  }

  $kernel->delay_add( 'parent', 3 );
  diag( "Wait 3" );

  return;
}

sub parent
{
  my( $kernel, $heap, $session ) = @_[KERNEL, HEAP, SESSION];
  DEBUG and warn "parent";
  diag( "sending sigusr1" );
  kill SIGUSR1, $heap->{T1}{PID};
  diag( "sent sigusr1" );
  $heap->{T1}{closing} = 1;
}


sub child
{
  my( $kernel, $heap, $session ) = @_[KERNEL, HEAP, SESSION];
  $PARENT = 0;
  DEBUG and warn "child";
  $kernel->sig( 'CHLD' );
  $kernel->sig( USR1 => 'sig_USR1' );
  $kernel->refcount_increment( $session->ID, 'USR1' );
}

sub sig_USR1
{
  my( $kernel, $heap, $session ) = @_[KERNEL, HEAP, SESSION];
  DEBUG and warn "USR1";
  $REFCNT = 1;
  $kernel->sig( 'USR1' );
  $kernel->refcount_decrement( $session->ID, 'USR1' );
  $kernel->alias_remove( 'worker' );
}


sub _stop {
  my( $kernel, $heap ) = @_[KERNEL, HEAP];
  DEBUG and warn "_stop";
}

sub done {
  my( $kernel, $heap, $session ) = @_[KERNEL, HEAP, SESSION];
  DEBUG and warn "done";

  $kernel->alias_remove( 'worker' );
  $kernel->sig( 'CHLD' );

  my @list = keys %{ $heap->{pid2N} };
  is( 0+@list, 1, "One child left ($list[0])" );
  kill SIGUSR1, @list;

  $REFCNT = 1;
  $kernel->refcount_decrement( $session->ID, 'T2' );
  alarm(30); $SIG{ALRM} = sub { die "test case didn't end sanely" };
}

sub sig_CHLD {
  my( $kernel, $heap, $signal, $pid, $status ) = @_[
    KERNEL, HEAP, ARG0..$#_
  ];

  unless( $heap->{pid2N}{$pid} ) {
      return;
  }

  my $name = $heap->{pid2N}{$pid};
  my $D = $heap->{$name};

  is( $D->{closing}, 1, "Expected child exited" );
  $kernel->refcount_decrement( $_[SESSION]->ID, $name );
  delete $heap->{$name};
  delete $heap->{pid2N}{$pid};

  $kernel->yield( 'done' );
}

1;
