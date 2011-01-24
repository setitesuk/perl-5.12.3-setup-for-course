# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.07) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from ../DateTime/data/Olson/2010o/africa.  Olson data version 2010o
#
# Do not edit this file directly.
#
package DateTime::TimeZone::Africa::Banjul;
BEGIN {
  $DateTime::TimeZone::Africa::Banjul::VERSION = '1.26';
}

use strict;

use Class::Singleton;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::Africa::Banjul::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY,
60305303196,
DateTime::TimeZone::NEG_INFINITY,
60305299200,
-3996,
0,
'LMT'
    ],
    [
60305303196,
61031149596,
60305299200,
61031145600,
-3996,
0,
'BMT'
    ],
    [
61031149596,
61946298000,
61031145996,
61946294400,
-3600,
0,
'WAT'
    ],
    [
61946298000,
DateTime::TimeZone::INFINITY,
61946298000,
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

