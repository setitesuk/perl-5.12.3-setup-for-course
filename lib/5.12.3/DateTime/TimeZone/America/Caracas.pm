# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.07) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from ../DateTime/data/Olson/2010o/southamerica.  Olson data version 2010o
#
# Do not edit this file directly.
#
package DateTime::TimeZone::America::Caracas;
BEGIN {
  $DateTime::TimeZone::America::Caracas::VERSION = '1.26';
}

use strict;

use Class::Singleton;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::America::Caracas::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY,
59611177664,
DateTime::TimeZone::NEG_INFINITY,
59611161600,
-16064,
0,
'LMT'
    ],
    [
59611177664,
60308944060,
59611161604,
60308928000,
-16060,
0,
'CMT'
    ],
    [
60308944060,
61977933000,
60308927860,
61977916800,
-16200,
0,
'VET'
    ],
    [
61977933000,
63332866800,
61977918600,
63332852400,
-14400,
0,
'VET'
    ],
    [
63332866800,
DateTime::TimeZone::INFINITY,
63332850600,
DateTime::TimeZone::INFINITY,
-16200,
0,
'VET'
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

