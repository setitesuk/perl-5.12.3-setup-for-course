# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.07) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from ../DateTime/data/Olson/2010o/africa.  Olson data version 2010o
#
# Do not edit this file directly.
#
package DateTime::TimeZone::Atlantic::St_Helena;
BEGIN {
  $DateTime::TimeZone::Atlantic::St_Helena::VERSION = '1.26';
}

use strict;

use Class::Singleton;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::Atlantic::St_Helena::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY,
59611162968,
DateTime::TimeZone::NEG_INFINITY,
59611161600,
-1368,
0,
'LMT'
    ],
    [
59611162968,
61536068568,
59611161600,
61536067200,
-1368,
0,
'JMT'
    ],
    [
61536068568,
DateTime::TimeZone::INFINITY,
61536068568,
DateTime::TimeZone::INFINITY,
0,
0,
'GMT'
    ],
];

sub olson_version { '2010o' }

sub has_dst_changes { 0 }

sub _max_year { 2020 }

sub _new_instance
{
    return shift->_init( @_, spans => $spans );
}



1;
