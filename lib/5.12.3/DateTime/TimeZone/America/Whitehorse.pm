# This file is auto-generated by the Perl DateTime Suite time zone
# code generator (0.07) This code generator comes with the
# DateTime::TimeZone module distribution in the tools/ directory

#
# Generated from ../DateTime/data/Olson/2010o/northamerica.  Olson data version 2010o
#
# Do not edit this file directly.
#
package DateTime::TimeZone::America::Whitehorse;
BEGIN {
  $DateTime::TimeZone::America::Whitehorse::VERSION = '1.26';
}

use strict;

use Class::Singleton;
use DateTime::TimeZone;
use DateTime::TimeZone::OlsonDB;

@DateTime::TimeZone::America::Whitehorse::ISA = ( 'Class::Singleton', 'DateTime::TimeZone' );

my $spans =
[
    [
DateTime::TimeZone::NEG_INFINITY,
59946685212,
DateTime::TimeZone::NEG_INFINITY,
59946652800,
-32412,
0,
'LMT'
    ],
    [
59946685212,
60503626800,
59946652812,
60503594400,
-32400,
0,
'YST'
    ],
    [
60503626800,
60520557600,
60503598000,
60520528800,
-28800,
1,
'YDT'
    ],
    [
60520557600,
60538705200,
60520525200,
60538672800,
-32400,
0,
'YST'
    ],
    [
60538705200,
60552518400,
60538676400,
60552489600,
-28800,
1,
'YDT'
    ],
    [
60552518400,
61255479600,
60552486000,
61255447200,
-32400,
0,
'YST'
    ],
    [
61255479600,
61366287600,
61255450800,
61366258800,
-28800,
1,
'YWT'
    ],
    [
61366287600,
61370301600,
61366258800,
61370272800,
-28800,
1,
'YPT'
    ],
    [
61370301600,
61987798800,
61370269200,
61987766400,
-32400,
0,
'YST'
    ],
    [
61987798800,
62004128400,
61987773600,
62004103200,
-25200,
1,
'YDDT'
    ],
    [
62004128400,
62025130800,
62004096000,
62025098400,
-32400,
0,
'YST'
    ],
    [
62025130800,
62451244800,
62025102000,
62451216000,
-28800,
0,
'PST'
    ],
    [
62451244800,
62461360800,
62451216000,
62461332000,
-28800,
0,
'PST'
    ],
    [
62461360800,
62477082000,
62461335600,
62477056800,
-25200,
1,
'PDT'
    ],
    [
62477082000,
62492810400,
62477053200,
62492781600,
-28800,
0,
'PST'
    ],
    [
62492810400,
62508531600,
62492785200,
62508506400,
-25200,
1,
'PDT'
    ],
    [
62508531600,
62524260000,
62508502800,
62524231200,
-28800,
0,
'PST'
    ],
    [
62524260000,
62540586000,
62524234800,
62540560800,
-25200,
1,
'PDT'
    ],
    [
62540586000,
62555709600,
62540557200,
62555680800,
-28800,
0,
'PST'
    ],
    [
62555709600,
62572035600,
62555684400,
62572010400,
-25200,
1,
'PDT'
    ],
    [
62572035600,
62587764000,
62572006800,
62587735200,
-28800,
0,
'PST'
    ],
    [
62587764000,
62603485200,
62587738800,
62603460000,
-25200,
1,
'PDT'
    ],
    [
62603485200,
62619213600,
62603456400,
62619184800,
-28800,
0,
'PST'
    ],
    [
62619213600,
62634934800,
62619188400,
62634909600,
-25200,
1,
'PDT'
    ],
    [
62634934800,
62650663200,
62634906000,
62650634400,
-28800,
0,
'PST'
    ],
    [
62650663200,
62666384400,
62650638000,
62666359200,
-25200,
1,
'PDT'
    ],
    [
62666384400,
62680298400,
62666355600,
62680269600,
-28800,
0,
'PST'
    ],
    [
62680298400,
62697834000,
62680273200,
62697808800,
-25200,
1,
'PDT'
    ],
    [
62697834000,
62711748000,
62697805200,
62711719200,
-28800,
0,
'PST'
    ],
    [
62711748000,
62729888400,
62711722800,
62729863200,
-25200,
1,
'PDT'
    ],
    [
62729888400,
62743197600,
62729859600,
62743168800,
-28800,
0,
'PST'
    ],
    [
62743197600,
62761338000,
62743172400,
62761312800,
-25200,
1,
'PDT'
    ],
    [
62761338000,
62774647200,
62761309200,
62774618400,
-28800,
0,
'PST'
    ],
    [
62774647200,
62792787600,
62774622000,
62792762400,
-25200,
1,
'PDT'
    ],
    [
62792787600,
62806701600,
62792758800,
62806672800,
-28800,
0,
'PST'
    ],
    [
62806701600,
62824237200,
62806676400,
62824212000,
-25200,
1,
'PDT'
    ],
    [
62824237200,
62838151200,
62824208400,
62838122400,
-28800,
0,
'PST'
    ],
    [
62838151200,
62855686800,
62838126000,
62855661600,
-25200,
1,
'PDT'
    ],
    [
62855686800,
62869600800,
62855658000,
62869572000,
-28800,
0,
'PST'
    ],
    [
62869600800,
62887741200,
62869575600,
62887716000,
-25200,
1,
'PDT'
    ],
    [
62887741200,
62901050400,
62887712400,
62901021600,
-28800,
0,
'PST'
    ],
    [
62901050400,
62919190800,
62901025200,
62919165600,
-25200,
1,
'PDT'
    ],
    [
62919190800,
62932500000,
62919162000,
62932471200,
-28800,
0,
'PST'
    ],
    [
62932500000,
62950640400,
62932474800,
62950615200,
-25200,
1,
'PDT'
    ],
    [
62950640400,
62964554400,
62950611600,
62964525600,
-28800,
0,
'PST'
    ],
    [
62964554400,
62982090000,
62964529200,
62982064800,
-25200,
1,
'PDT'
    ],
    [
62982090000,
62996004000,
62982061200,
62995975200,
-28800,
0,
'PST'
    ],
    [
62996004000,
63013539600,
62995978800,
63013514400,
-25200,
1,
'PDT'
    ],
    [
63013539600,
63027453600,
63013510800,
63027424800,
-28800,
0,
'PST'
    ],
    [
63027453600,
63044989200,
63027428400,
63044964000,
-25200,
1,
'PDT'
    ],
    [
63044989200,
63058903200,
63044960400,
63058874400,
-28800,
0,
'PST'
    ],
    [
63058903200,
63077043600,
63058878000,
63077018400,
-25200,
1,
'PDT'
    ],
    [
63077043600,
63090352800,
63077014800,
63090324000,
-28800,
0,
'PST'
    ],
    [
63090352800,
63108493200,
63090327600,
63108468000,
-25200,
1,
'PDT'
    ],
    [
63108493200,
63121802400,
63108464400,
63121773600,
-28800,
0,
'PST'
    ],
    [
63121802400,
63139942800,
63121777200,
63139917600,
-25200,
1,
'PDT'
    ],
    [
63139942800,
63153856800,
63139914000,
63153828000,
-28800,
0,
'PST'
    ],
    [
63153856800,
63171392400,
63153831600,
63171367200,
-25200,
1,
'PDT'
    ],
    [
63171392400,
63185306400,
63171363600,
63185277600,
-28800,
0,
'PST'
    ],
    [
63185306400,
63202842000,
63185281200,
63202816800,
-25200,
1,
'PDT'
    ],
    [
63202842000,
63216756000,
63202813200,
63216727200,
-28800,
0,
'PST'
    ],
    [
63216756000,
63234896400,
63216730800,
63234871200,
-25200,
1,
'PDT'
    ],
    [
63234896400,
63248205600,
63234867600,
63248176800,
-28800,
0,
'PST'
    ],
    [
63248205600,
63266346000,
63248180400,
63266320800,
-25200,
1,
'PDT'
    ],
    [
63266346000,
63279655200,
63266317200,
63279626400,
-28800,
0,
'PST'
    ],
    [
63279655200,
63297795600,
63279630000,
63297770400,
-25200,
1,
'PDT'
    ],
    [
63297795600,
63309290400,
63297766800,
63309261600,
-28800,
0,
'PST'
    ],
    [
63309290400,
63329850000,
63309265200,
63329824800,
-25200,
1,
'PDT'
    ],
    [
63329850000,
63340740000,
63329821200,
63340711200,
-28800,
0,
'PST'
    ],
    [
63340740000,
63361299600,
63340714800,
63361274400,
-25200,
1,
'PDT'
    ],
    [
63361299600,
63372189600,
63361270800,
63372160800,
-28800,
0,
'PST'
    ],
    [
63372189600,
63392749200,
63372164400,
63392724000,
-25200,
1,
'PDT'
    ],
    [
63392749200,
63404244000,
63392720400,
63404215200,
-28800,
0,
'PST'
    ],
    [
63404244000,
63424803600,
63404218800,
63424778400,
-25200,
1,
'PDT'
    ],
    [
63424803600,
63435693600,
63424774800,
63435664800,
-28800,
0,
'PST'
    ],
    [
63435693600,
63456253200,
63435668400,
63456228000,
-25200,
1,
'PDT'
    ],
    [
63456253200,
63467143200,
63456224400,
63467114400,
-28800,
0,
'PST'
    ],
    [
63467143200,
63487702800,
63467118000,
63487677600,
-25200,
1,
'PDT'
    ],
    [
63487702800,
63498592800,
63487674000,
63498564000,
-28800,
0,
'PST'
    ],
    [
63498592800,
63519152400,
63498567600,
63519127200,
-25200,
1,
'PDT'
    ],
    [
63519152400,
63530042400,
63519123600,
63530013600,
-28800,
0,
'PST'
    ],
    [
63530042400,
63550602000,
63530017200,
63550576800,
-25200,
1,
'PDT'
    ],
    [
63550602000,
63561492000,
63550573200,
63561463200,
-28800,
0,
'PST'
    ],
    [
63561492000,
63582051600,
63561466800,
63582026400,
-25200,
1,
'PDT'
    ],
    [
63582051600,
63593546400,
63582022800,
63593517600,
-28800,
0,
'PST'
    ],
    [
63593546400,
63614106000,
63593521200,
63614080800,
-25200,
1,
'PDT'
    ],
    [
63614106000,
63624996000,
63614077200,
63624967200,
-28800,
0,
'PST'
    ],
    [
63624996000,
63645555600,
63624970800,
63645530400,
-25200,
1,
'PDT'
    ],
    [
63645555600,
63656445600,
63645526800,
63656416800,
-28800,
0,
'PST'
    ],
    [
63656445600,
63677005200,
63656420400,
63676980000,
-25200,
1,
'PDT'
    ],
    [
63677005200,
63687895200,
63676976400,
63687866400,
-28800,
0,
'PST'
    ],
    [
63687895200,
63708454800,
63687870000,
63708429600,
-25200,
1,
'PDT'
    ],
    [
63708454800,
63719344800,
63708426000,
63719316000,
-28800,
0,
'PST'
    ],
    [
63719344800,
63739904400,
63719319600,
63739879200,
-25200,
1,
'PDT'
    ],
    [
63739904400,
63751399200,
63739875600,
63751370400,
-28800,
0,
'PST'
    ],
    [
63751399200,
63771958800,
63751374000,
63771933600,
-25200,
1,
'PDT'
    ],
];

sub olson_version { '2010o' }

sub has_dst_changes { 47 }

sub _max_year { 2020 }

sub _new_instance
{
    return shift->_init( @_, spans => $spans );
}

sub _last_offset { -28800 }

my $last_observance = bless( {
  'format' => 'P%sT',
  'gmtoff' => '-8:00',
  'local_start_datetime' => bless( {
    'formatter' => undef,
    'local_rd_days' => 722815,
    'local_rd_secs' => 0,
    'offset_modifier' => 0,
    'rd_nanosecs' => 0,
    'tz' => bless( {
      'name' => 'floating',
      'offset' => 0
    }, 'DateTime::TimeZone::Floating' ),
    'utc_rd_days' => 722815,
    'utc_rd_secs' => 0,
    'utc_year' => 1981
  }, 'DateTime' ),
  'offset_from_std' => 0,
  'offset_from_utc' => -28800,
  'until' => [],
  'utc_start_datetime' => bless( {
    'formatter' => undef,
    'local_rd_days' => 722815,
    'local_rd_secs' => 28800,
    'offset_modifier' => 0,
    'rd_nanosecs' => 0,
    'tz' => bless( {
      'name' => 'floating',
      'offset' => 0
    }, 'DateTime::TimeZone::Floating' ),
    'utc_rd_days' => 722815,
    'utc_rd_secs' => 28800,
    'utc_year' => 1981
  }, 'DateTime' )
}, 'DateTime::TimeZone::OlsonDB::Observance' )
;
sub _last_observance { $last_observance }

my $rules = [
  bless( {
    'at' => '2:00',
    'from' => '2007',
    'in' => 'Nov',
    'letter' => 'S',
    'name' => 'Canada',
    'offset_from_std' => 0,
    'on' => 'Sun>=1',
    'save' => '0',
    'to' => 'max',
    'type' => undef
  }, 'DateTime::TimeZone::OlsonDB::Rule' ),
  bless( {
    'at' => '2:00',
    'from' => '2007',
    'in' => 'Mar',
    'letter' => 'D',
    'name' => 'Canada',
    'offset_from_std' => 3600,
    'on' => 'Sun>=8',
    'save' => '1:00',
    'to' => 'max',
    'type' => undef
  }, 'DateTime::TimeZone::OlsonDB::Rule' )
]
;
sub _rules { $rules }


1;
