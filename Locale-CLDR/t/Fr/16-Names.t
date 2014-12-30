#!/usr/bin/perl
# Do not normalise this test file. It has deliberately unnormalised characters in it.
use v5.10;
use strict;
use warnings;
use utf8;
use if $^V ge v5.12.0, feature => 'unicode_strings';

use Test::More tests => 25;
use Test::Exception;

use ok 'Locale::CLDR';

my $locale = Locale::CLDR->new('fr_FR');
my $other_locale = Locale::CLDR->new('fr_BE');

is($locale->locale_name(), 'français (France)', 'Locale name from current locale');
is($locale->locale_name('fr_CA'), 'français canadien', 'Locale name from string');
is($locale->locale_name($other_locale), 'français (Belgique)', 'Locale name from other locale object');

is($locale->language_name(), 'français', 'Language name from current locale');
is($locale->language_name('en'), 'anglais', 'Language name from string');
is($locale->language_name($other_locale), 'français', 'Language name from other locale object');

my $all_languages = {
    'aa' => 'afar',
    'ab' => 'abkhaze',
    'ace' => 'aceh',
    'ach' => 'acoli',
    'ada' => 'adangme',
    'ady' => 'adyghéen',
    'ae' => 'avestique',
    'aeb' => 'arabe tunisien',
    'af' => 'afrikaans',
    'afh' => 'afrihili',
    'agq' => 'aghem',
    'ain' => 'aïnou',
    'ak' => 'akan',
    'akk' => 'akkadien',
    'akz' => 'alabama',
    'ale' => 'aléoute',
    'aln' => 'guègue',
    'alt' => 'altaï du Sud',
    'am' => 'amharique',
    'an' => 'aragonais',
    'ang' => 'ancien anglais',
    'anp' => 'angika',
    'ar' => 'arabe',
    'ar_001' => 'arabe standard moderne',
    'arc' => 'araméen',
    'arn' => 'araukan',
    'aro' => 'araona',
    'arp' => 'arapaho',
    'arq' => 'arabe algérien',
    'arw' => 'arawak',
    'ary' => 'arabe marocain',
    'arz' => 'arabe égyptien',
    'as' => 'assamais',
    'asa' => 'assou',
    'ase' => 'langue des signes américaine',
    'ast' => 'asturien',
    'av' => 'avar',
    'avk' => 'kotava',
    'awa' => 'awadhi',
    'ay' => 'aymara',
    'az' => 'azéri',
    'az@alt=short' => 'azéri',
    'azb' => 'azéri méridional',
    'ba' => 'bachkir',
    'bal' => 'baloutchi',
    'ban' => 'balinais',
    'bar' => 'bavarois',
    'bas' => 'bassa',
    'bax' => 'bamoun',
    'bbc' => 'batak toba',
    'bbj' => 'ghomala',
    'be' => 'biélorusse',
    'bej' => 'bedja',
    'bem' => 'bemba',
    'bew' => 'betawi',
    'bez' => 'béna',
    'bfd' => 'bafut',
    'bfq' => 'badaga',
    'bg' => 'bulgare',
    'bho' => 'bhojpuri',
    'bi' => 'bichelamar',
    'bik' => 'bikol',
    'bin' => 'bini',
    'bjn' => 'banjar',
    'bkm' => 'kom',
    'bla' => 'siksika',
    'bm' => 'bambara',
    'bn' => 'bengali',
    'bo' => 'tibétain',
    'bpy' => 'bishnupriya',
    'bqi' => 'bakhtiari',
    'br' => 'breton',
    'bra' => 'braj',
    'brh' => 'brahoui',
    'brx' => 'bodo',
    'bs' => 'bosniaque',
    'bss' => 'akoose',
    'bua' => 'bouriate',
    'bug' => 'bugi',
    'bum' => 'boulou',
    'byn' => 'blin',
    'byv' => 'medumba',
    'ca' => 'catalan',
    'cad' => 'caddo',
    'car' => 'caribe',
    'cay' => 'cayuga',
    'cch' => 'atsam',
    'ce' => 'tchétchène',
    'ceb' => 'cebuano',
    'cgg' => 'kiga',
    'ch' => 'chamorro',
    'chb' => 'chibcha',
    'chg' => 'tchaghataï',
    'chk' => 'chuuk',
    'chm' => 'mari',
    'chn' => 'jargon chinook',
    'cho' => 'choctaw',
    'chp' => 'chipewyan',
    'chr' => 'cherokee',
    'chy' => 'cheyenne',
    'ckb' => 'sorani',
    'co' => 'corse',
    'cop' => 'copte',
    'cps' => 'capiznon',
    'cr' => 'cree',
    'crh' => 'turc de Crimée',
    'cs' => 'tchèque',
    'csb' => 'kachoube',
    'cu' => 'slavon d’église',
    'cv' => 'tchouvache',
    'cy' => 'gallois',
    'da' => 'danois',
    'dak' => 'dakota',
    'dar' => 'dargwa',
    'dav' => 'taita',
    'de' => 'allemand',
    'de_AT' => 'allemand autrichien',
    'de_CH' => 'allemand suisse',
    'del' => 'delaware',
    'den' => 'slavey',
    'dgr' => 'dogrib',
    'din' => 'dinka',
    'dje' => 'zarma',
    'doi' => 'dogri',
    'dsb' => 'bas-sorabe',
    'dtp' => 'dusun central',
    'dua' => 'douala',
    'dum' => 'moyen néerlandais',
    'dv' => 'maldivien',
    'dyo' => 'diola-fogny',
    'dyu' => 'dioula',
    'dz' => 'dzongkha',
    'dzg' => 'dazaga',
    'ebu' => 'embou',
    'ee' => 'éwé',
    'efi' => 'efik',
    'egl' => 'émilien',
    'egy' => 'égyptien ancien',
    'eka' => 'ekajuk',
    'el' => 'grec',
    'elx' => 'élamite',
    'en' => 'anglais',
    'en_AU' => 'anglais australien',
    'en_CA' => 'anglais canadien',
    'en_GB' => 'anglais britannique',
    'en_GB@alt=short' => 'anglais (R.-U.)',
    'en_US' => 'anglais américain',
    'en_US@alt=short' => 'anglais (É.-U.)',
    'enm' => 'moyen anglais',
    'eo' => 'espéranto',
    'es' => 'espagnol',
    'es_419' => 'espagnol latino-américain',
    'es_ES' => 'espagnol d’Europe',
    'es_MX' => 'espagnol mexicain',
    'esu' => 'youpik central',
    'et' => 'estonien',
    'eu' => 'basque',
    'ewo' => 'éwondo',
    'ext' => 'estrémègne',
    'fa' => 'persan',
    'fan' => 'fang',
    'fat' => 'fanti',
    'ff' => 'peul',
    'fi' => 'finnois',
    'fil' => 'filipino',
    'fit' => 'finnois tornédalien',
    'fj' => 'fidjien',
    'fo' => 'féroïen',
    'fon' => 'fon',
    'fr' => 'français',
    'fr_CA' => 'français canadien',
    'fr_CH' => 'français suisse',
    'frc' => 'français cadien',
    'frm' => 'moyen français',
    'fro' => 'ancien français',
    'frp' => 'franco-provençal',
    'frr' => 'frison du Nord',
    'frs' => 'frison oriental',
    'fur' => 'frioulan',
    'fy' => 'frison occidental',
    'ga' => 'irlandais',
    'gaa' => 'ga',
    'gag' => 'gagaouze',
    'gan' => 'gan',
    'gay' => 'gayo',
    'gba' => 'gbaya',
    'gbz' => 'dari zoroastrien',
    'gd' => 'gaélique écossais',
    'gez' => 'guèze',
    'gil' => 'gilbertais',
    'gl' => 'galicien',
    'glk' => 'gilaki',
    'gmh' => 'moyen haut-allemand',
    'gn' => 'guarani',
    'goh' => 'ancien haut allemand',
    'gom' => 'konkani de Goa',
    'gon' => 'gondi',
    'gor' => 'gorontalo',
    'got' => 'gotique',
    'grb' => 'grebo',
    'grc' => 'grec ancien',
    'gsw' => 'alémanique',
    'gu' => 'gujarati',
    'guc' => 'wayuu',
    'gur' => 'gurenne',
    'guz' => 'gusii',
    'gv' => 'manx',
    'gwi' => 'gwichʼin',
    'ha' => 'haoussa',
    'hai' => 'haida',
    'hak' => 'hakka',
    'haw' => 'hawaïen',
    'he' => 'hébreu',
    'hi' => 'hindi',
    'hif' => 'hindi fidjien',
    'hil' => 'hiligaynon',
    'hit' => 'hittite',
    'hmn' => 'hmong',
    'ho' => 'hiri motu',
    'hr' => 'croate',
    'hsb' => 'haut-sorabe',
    'hsn' => 'xiang',
    'ht' => 'haïtien',
    'hu' => 'hongrois',
    'hup' => 'hupa',
    'hy' => 'arménien',
    'hz' => 'héréro',
    'ia' => 'interlingua',
    'iba' => 'iban',
    'ibb' => 'ibibio',
    'id' => 'indonésien',
    'ie' => 'interlingue',
    'ig' => 'igbo',
    'ii' => 'yi du Sichuan',
    'ik' => 'inupiaq',
    'ilo' => 'ilokano',
    'inh' => 'ingouche',
    'io' => 'ido',
    'is' => 'islandais',
    'it' => 'italien',
    'iu' => 'inuktitut',
    'izh' => 'ingrien',
    'ja' => 'japonais',
    'jam' => 'créole anglais jamaïcain',
    'jbo' => 'lojban',
    'jgo' => 'ngomba',
    'jmc' => 'machame',
    'jpr' => 'judéo-persan',
    'jrb' => 'judéo-arabe',
    'jut' => 'jute',
    'jv' => 'javanais',
    'ka' => 'géorgien',
    'kaa' => 'karakalpak',
    'kab' => 'kabyle',
    'kac' => 'kachin',
    'kaj' => 'jju',
    'kam' => 'kamba',
    'kaw' => 'kawi',
    'kbd' => 'kabardin',
    'kbl' => 'kanembou',
    'kcg' => 'tyap',
    'kde' => 'makonde',
    'kea' => 'capverdien',
    'ken' => 'kenyang',
    'kfo' => 'koro',
    'kg' => 'kongo',
    'kgp' => 'caingangue',
    'kha' => 'khasi',
    'kho' => 'khotanais',
    'khq' => 'koyra chiini',
    'khw' => 'khowar',
    'ki' => 'kikuyu',
    'kiu' => 'kirmanjki',
    'kj' => 'kuanyama',
    'kk' => 'kazakh',
    'kkj' => 'kako',
    'kl' => 'groenlandais',
    'kln' => 'kalenjin',
    'km' => 'khmer',
    'kmb' => 'kiMboundou',
    'kn' => 'kannada',
    'ko' => 'coréen',
    'koi' => 'komi-permiak',
    'kok' => 'konkani',
    'kos' => 'kusaien',
    'kpe' => 'kpellé',
    'kr' => 'kanouri',
    'krc' => 'karatchaï balkar',
    'kri' => 'krio',
    'krj' => 'kinaray-a',
    'krl' => 'carélien',
    'kru' => 'kurukh',
    'ks' => 'kashmiri',
    'ksb' => 'chambala',
    'ksf' => 'bafia',
    'ksh' => 'francique ripuaire',
    'ku' => 'kurde',
    'kum' => 'koumyk',
    'kut' => 'kutenai',
    'kv' => 'komi',
    'kw' => 'cornique',
    'ky' => 'kirghize',
    'la' => 'latin',
    'lad' => 'ladino',
    'lag' => 'langi',
    'lah' => 'lahnda',
    'lam' => 'lamba',
    'lb' => 'luxembourgeois',
    'lez' => 'lezghien',
    'lfn' => 'lingua franca nova',
    'lg' => 'ganda',
    'li' => 'limbourgeois',
    'lij' => 'ligure',
    'liv' => 'livonien',
    'lkt' => 'lakota',
    'lmo' => 'lombard',
    'ln' => 'lingala',
    'lo' => 'lao',
    'lol' => 'mongo',
    'loz' => 'lozi',
    'lt' => 'lituanien',
    'ltg' => 'latgalien',
    'lu' => 'luba-katanga',
    'lua' => 'luba-lulua',
    'lui' => 'luiseno',
    'lun' => 'lunda',
    'luo' => 'luo',
    'lus' => 'lushai',
    'luy' => 'oluluyia',
    'lv' => 'letton',
    'lzh' => 'chinois littéraire',
    'lzz' => 'laze',
    'mad' => 'madurais',
    'maf' => 'mafa',
    'mag' => 'magahi',
    'mai' => 'maithili',
    'mak' => 'makassar',
    'man' => 'mandingue',
    'mas' => 'masai',
    'mde' => 'maba',
    'mdf' => 'moksa',
    'mdr' => 'mandar',
    'men' => 'mendé',
    'mer' => 'merou',
    'mfe' => 'créole mauricien',
    'mg' => 'malgache',
    'mga' => 'moyen irlandais',
    'mgh' => 'makhuwa-meetto',
    'mgo' => 'méta’',
    'mh' => 'marshall',
    'mi' => 'maori',
    'mic' => 'micmac',
    'min' => 'minangkabau',
    'mk' => 'macédonien',
    'ml' => 'malayalam',
    'mn' => 'mongol',
    'mnc' => 'mandchou',
    'mni' => 'manipuri',
    'moh' => 'mohawk',
    'mos' => 'moré',
    'mr' => 'marathe',
    'mrj' => 'mari occidental',
    'ms' => 'malais',
    'mt' => 'maltais',
    'mua' => 'mundang',
    'mul' => 'multilingue',
    'mus' => 'creek',
    'mwl' => 'mirandais',
    'mwr' => 'marwarî',
    'mwv' => 'mentawaï',
    'my' => 'birman',
    'mye' => 'myènè',
    'myv' => 'erzya',
    'mzn' => 'mazandérani',
    'na' => 'nauruan',
    'nan' => 'minnan',
    'nap' => 'napolitain',
    'naq' => 'nama',
    'nb' => 'norvégien bokmål',
    'nd' => 'ndébélé du Nord',
    'nds' => 'bas-allemand',
    'ne' => 'népalais',
    'new' => 'newari',
    'ng' => 'ndonga',
    'nia' => 'nias',
    'niu' => 'niué',
    'njo' => 'ao naga',
    'nl' => 'néerlandais',
    'nl_BE' => 'flamand',
    'nmg' => 'kwasio',
    'nn' => 'norvégien nynorsk',
    'nnh' => 'ngiemboon',
    'no' => 'norvégien',
    'nog' => 'nogaï',
    'non' => 'vieux norrois',
    'nov' => 'novial',
    'nqo' => 'n’ko',
    'nr' => 'ndébélé du Sud',
    'nso' => 'sotho du Nord',
    'nus' => 'nuer',
    'nv' => 'navaho',
    'nwc' => 'newarî classique',
    'ny' => 'nyanja',
    'nym' => 'nyamwezi',
    'nyn' => 'nyankolé',
    'nyo' => 'nyoro',
    'nzi' => 'nzema',
    'oc' => 'occitan',
    'oj' => 'ojibwa',
    'om' => 'oromo',
    'or' => 'oriya',
    'os' => 'ossète',
    'osa' => 'osage',
    'ota' => 'turc ottoman',
    'pa' => 'pendjabi',
    'pag' => 'pangasinan',
    'pal' => 'pahlavi',
    'pam' => 'pampangan',
    'pap' => 'papiamento',
    'pau' => 'palau',
    'pcd' => 'picard',
    'pdc' => 'allemand de Pennsylvanie',
    'pdt' => 'bas-prussien',
    'peo' => 'persan ancien',
    'pfl' => 'allemand palatin',
    'phn' => 'phénicien',
    'pi' => 'pali',
    'pl' => 'polonais',
    'pms' => 'piémontais',
    'pnt' => 'pontique',
    'pon' => 'pohnpei',
    'prg' => 'prussien',
    'pro' => 'provençal ancien',
    'ps' => 'pachto',
    'ps@alt=variant' => 'pashto',
    'pt' => 'portugais',
    'pt_BR' => 'portugais brésilien',
    'pt_PT' => 'portugais d’Europe',
    'qu' => 'quechua',
    'quc' => 'k’iche’',
    'qug' => 'quichua du Haut-Chimborazo',
    'raj' => 'rajasthani',
    'rap' => 'rapanui',
    'rar' => 'rarotongien',
    'rgn' => 'romagnol',
    'rif' => 'riffain',
    'rm' => 'romanche',
    'rn' => 'roundi',
    'ro' => 'roumain',
    'ro_MD' => 'moldave',
    'rof' => 'rombo',
    'rom' => 'tzigane',
    'root' => 'racine',
    'rtm' => 'rotuman',
    'ru' => 'russe',
    'rue' => 'ruthène',
    'rug' => 'roviana',
    'rup' => 'valaque',
    'rw' => 'rwanda',
    'rwk' => 'rwa',
    'sa' => 'sanskrit',
    'sad' => 'sandawe',
    'sah' => 'iakoute',
    'sam' => 'araméen samaritain',
    'saq' => 'samburu',
    'sas' => 'sasak',
    'sat' => 'santal',
    'saz' => 'saurashtra',
    'sba' => 'ngambay',
    'sbp' => 'sangu',
    'sc' => 'sarde',
    'scn' => 'sicilien',
    'sco' => 'écossais',
    'sd' => 'sindhi',
    'sdc' => 'sarde sassarais',
    'se' => 'sami du Nord',
    'see' => 'seneca',
    'seh' => 'sena',
    'sei' => 'séri',
    'sel' => 'selkoupe',
    'ses' => 'koyraboro senni',
    'sg' => 'sangho',
    'sga' => 'ancien irlandais',
    'sgs' => 'samogitien',
    'sh' => 'serbo-croate',
    'shi' => 'chleuh',
    'shn' => 'shan',
    'shu' => 'arabe tchadien',
    'si' => 'cinghalais',
    'sid' => 'sidamo',
    'sk' => 'slovaque',
    'sl' => 'slovène',
    'sli' => 'bas-silésien',
    'sly' => 'selayar',
    'sm' => 'samoan',
    'sma' => 'sami du Sud',
    'smj' => 'sami de Lule',
    'smn' => 'sami d’Inari',
    'sms' => 'sami skolt',
    'sn' => 'shona',
    'snk' => 'soninké',
    'so' => 'somali',
    'sog' => 'sogdien',
    'sq' => 'albanais',
    'sr' => 'serbe',
    'srn' => 'sranan tongo',
    'srr' => 'sérère',
    'ss' => 'swati',
    'ssy' => 'saho',
    'st' => 'sesotho',
    'stq' => 'frison de Saterland',
    'su' => 'soundanais',
    'suk' => 'sukuma',
    'sus' => 'soussou',
    'sux' => 'sumérien',
    'sv' => 'suédois',
    'sw' => 'swahili',
    'swb' => 'comorien',
    'swc' => 'swahili du Congo',
    'syc' => 'syriaque classique',
    'syr' => 'syriaque',
    'szl' => 'silésien',
    'ta' => 'tamoul',
    'tcy' => 'toulou',
    'te' => 'télougou',
    'tem' => 'temne',
    'teo' => 'teso',
    'ter' => 'tereno',
    'tet' => 'tetum',
    'tg' => 'tadjik',
    'th' => 'thaï',
    'ti' => 'tigrigna',
    'tig' => 'tigré',
    'tiv' => 'tiv',
    'tk' => 'turkmène',
    'tkl' => 'tokelau',
    'tkr' => 'tsakhur',
    'tl' => 'tagalog',
    'tlh' => 'klingon',
    'tli' => 'tlingit',
    'tly' => 'talysh',
    'tmh' => 'tamacheq',
    'tn' => 'tswana',
    'to' => 'tonguien',
    'tog' => 'tonga nyasa',
    'tpi' => 'tok pisin',
    'tr' => 'turc',
    'tru' => 'touroyo',
    'trv' => 'taroko',
    'ts' => 'tsonga',
    'tsd' => 'tsakonien',
    'tsi' => 'tsimshian',
    'tt' => 'tatar',
    'ttt' => 'tati caucasien',
    'tum' => 'tumbuka',
    'tvl' => 'tuvalu',
    'tw' => 'twi',
    'twq' => 'tasawaq',
    'ty' => 'tahitien',
    'tyv' => 'touva',
    'tzm' => 'tamazight',
    'udm' => 'oudmourte',
    'ug' => 'ouïghour',
    'ug@alt=variant' => 'ouïgour',
    'uga' => 'ougaritique',
    'uk' => 'ukrainien',
    'umb' => 'umbundu',
    'und' => 'langue indéterminée',
    'ur' => 'ourdou',
    'uz' => 'ouzbek',
    'vai' => 'vaï',
    've' => 'venda',
    'vec' => 'vénitien',
    'vep' => 'vepse',
    'vi' => 'vietnamien',
    'vls' => 'flamand occidental',
    'vmf' => 'franconien du Main',
    'vo' => 'volapuk',
    'vot' => 'vote',
    'vro' => 'võro',
    'vun' => 'vunjo',
    'wa' => 'wallon',
    'wae' => 'walser',
    'wal' => 'walamo',
    'war' => 'waray',
    'was' => 'washo',
    'wo' => 'wolof',
    'wuu' => 'chinois wu',
    'xal' => 'kalmouk',
    'xh' => 'xhosa',
    'xmf' => 'mingrélien',
    'xog' => 'soga',
    'yao' => 'yao',
    'yap' => 'yapois',
    'yav' => 'yangben',
    'ybb' => 'yemba',
    'yi' => 'yiddish',
    'yo' => 'yoruba',
    'yrl' => 'nheengatou',
    'yue' => 'cantonais',
    'za' => 'zhuang',
    'zap' => 'zapotèque',
    'zbl' => 'symboles Bliss',
    'zea' => 'zélandais',
    'zen' => 'zenaga',
    'zgh' => 'amazighe standard marocain',
    'zh' => 'chinois',
    'zh_Hans' => 'chinois simplifié',
    'zh_Hant' => 'chinois traditionnel',
    'zu' => 'zoulou',
    'zun' => 'zuni',
    'zxx' => 'sans contenu linguistique',
    'zza' => 'zazaki',
};

is_deeply($locale->all_languages, $all_languages, 'All languages');

is($locale->script_name(), '', 'Script name from current locale');
is($locale->script_name('latn'), 'latin', 'Script name from string');
is($locale->script_name($other_locale), '', 'Script name from other locale object');

my $all_scripts = {
    'Afak' => 'afaka',
    'Arab' => 'arabe',
    'Arab@alt=variant' => 'arabo-persan',
    'Armi' => 'araméen impérial',
    'Armn' => 'arménien',
    'Avst' => 'avestique',
    'Bali' => 'balinais',
    'Bamu' => 'bamoum',
    'Bass' => 'bassa',
    'Batk' => 'batak',
    'Beng' => 'bengali',
    'Blis' => 'symboles Bliss',
    'Bopo' => 'bopomofo',
    'Brah' => 'brâhmî',
    'Brai' => 'braille',
    'Bugi' => 'bouguis',
    'Buhd' => 'bouhide',
    'Cakm' => 'chakma',
    'Cans' => 'syllabaire autochtone canadien unifié',
    'Cari' => 'carien',
    'Cham' => 'cham',
    'Cher' => 'cherokee',
    'Cirt' => 'cirth',
    'Copt' => 'copte',
    'Cprt' => 'syllabaire chypriote',
    'Cyrl' => 'cyrillique',
    'Cyrs' => 'cyrillique (variante slavonne)',
    'Deva' => 'dévanâgarî',
    'Dsrt' => 'déséret',
    'Dupl' => 'sténographie Duployé',
    'Egyd' => 'démotique égyptien',
    'Egyh' => 'hiératique égyptien',
    'Egyp' => 'hiéroglyphes égyptiens',
    'Ethi' => 'éthiopique',
    'Geok' => 'géorgien khoutsouri',
    'Geor' => 'géorgien',
    'Glag' => 'glagolitique',
    'Goth' => 'gotique',
    'Gran' => 'grantha',
    'Grek' => 'grec',
    'Gujr' => 'goudjarâtî',
    'Guru' => 'gourmoukhî',
    'Hang' => 'hangûl',
    'Hani' => 'sinogrammes',
    'Hano' => 'hanounóo',
    'Hans' => 'simplifié',
    'Hans@alt=stand-alone' => 'sinogrammes simplifiés',
    'Hant' => 'traditionnel',
    'Hant@alt=stand-alone' => 'sinogrammes traditionnels',
    'Hebr' => 'hébreu',
    'Hira' => 'hiragana',
    'Hluw' => 'hiéroglyphes anatoliens',
    'Hmng' => 'pahawh hmong',
    'Hrkt' => 'katakana ou hiragana',
    'Hung' => 'ancien hongrois',
    'Inds' => 'indus',
    'Ital' => 'ancien italique',
    'Java' => 'javanais',
    'Jpan' => 'japonais',
    'Jurc' => 'jurchen',
    'Kali' => 'kayah li',
    'Kana' => 'katakana',
    'Khar' => 'kharochthî',
    'Khmr' => 'khmer',
    'Khoj' => 'khojkî',
    'Knda' => 'kannara',
    'Kore' => 'coréen',
    'Kpel' => 'kpellé',
    'Kthi' => 'kaithî',
    'Lana' => 'lanna',
    'Laoo' => 'lao',
    'Latf' => 'latin (variante brisée)',
    'Latg' => 'latin (variante gaélique)',
    'Latn' => 'latin',
    'Lepc' => 'lepcha',
    'Limb' => 'limbou',
    'Lina' => 'linéaire A',
    'Linb' => 'linéaire B',
    'Lisu' => 'lisu',
    'Loma' => 'loma',
    'Lyci' => 'lycien',
    'Lydi' => 'lydien',
    'Mand' => 'mandéen',
    'Mani' => 'manichéen',
    'Maya' => 'hiéroglyphes mayas',
    'Mend' => 'mendé',
    'Merc' => 'méroïtique cursif',
    'Mero' => 'méroïtique',
    'Mlym' => 'malayalam',
    'Mong' => 'mongol',
    'Moon' => 'moon',
    'Mroo' => 'mro',
    'Mtei' => 'meitei mayek',
    'Mymr' => 'birman',
    'Narb' => 'nord-arabique',
    'Nbat' => 'nabatéen',
    'Nkgb' => 'nakhi géba',
    'Nkoo' => 'n’ko',
    'Nshu' => 'nüshu',
    'Ogam' => 'ogam',
    'Olck' => 'ol tchiki',
    'Orkh' => 'orkhon',
    'Orya' => 'oriya',
    'Osma' => 'osmanais',
    'Palm' => 'palmyrénien',
    'Perm' => 'ancien permien',
    'Phag' => 'phags pa',
    'Phli' => 'pehlevi des inscriptions',
    'Phlp' => 'pehlevi des psautiers',
    'Phlv' => 'pehlevi des livres',
    'Phnx' => 'phénicien',
    'Plrd' => 'phonétique de Pollard',
    'Prti' => 'parthe des inscriptions',
    'Rjng' => 'rejang',
    'Roro' => 'rongorongo',
    'Runr' => 'runique',
    'Samr' => 'samaritain',
    'Sara' => 'sarati',
    'Sarb' => 'sud-arabique ancien',
    'Saur' => 'saurashtra',
    'Sgnw' => 'écriture des signes',
    'Shaw' => 'shavien',
    'Shrd' => 'charada',
    'Sind' => 'sindhî',
    'Sinh' => 'cinghalais',
    'Sora' => 'sora sompeng',
    'Sund' => 'sundanais',
    'Sylo' => 'sylotî nâgrî',
    'Syrc' => 'syriaque',
    'Syre' => 'syriaque estranghélo',
    'Syrj' => 'syriaque occidental',
    'Syrn' => 'syriaque oriental',
    'Tagb' => 'tagbanoua',
    'Takr' => 'tâkrî',
    'Tale' => 'taï-le',
    'Talu' => 'nouveau taï-lue',
    'Taml' => 'tamoul',
    'Tang' => 'tangoute',
    'Tavt' => 'taï viêt',
    'Telu' => 'télougou',
    'Teng' => 'tengwar',
    'Tfng' => 'tifinagh',
    'Tglg' => 'tagal',
    'Thaa' => 'thâna',
    'Thai' => 'thaï',
    'Tibt' => 'tibétain',
    'Tirh' => 'tirhouta',
    'Ugar' => 'ougaritique',
    'Vaii' => 'vaï',
    'Visp' => 'parole visible',
    'Wara' => 'warang citi',
    'Wole' => 'woléaï',
    'Xpeo' => 'cunéiforme persépolitain',
    'Xsux' => 'cunéiforme suméro-akkadien',
    'Yiii' => 'yi',
    'Zinh' => 'hérité',
    'Zmth' => 'notation mathématique',
    'Zsym' => 'symboles',
    'Zxxx' => 'non écrit',
    'Zyyy' => 'commun',
    'Zzzz' => 'écriture inconnue',
};

is_deeply($locale->all_scripts, $all_scripts, 'All scripts');

is($locale->territory_name(), 'France', 'Territory name from current locale');
is($locale->territory_name('GB'), 'Royaume-Uni', 'Territory name from string');
is($locale->territory_name($other_locale), 'Belgique', 'Territory name from other locale object');

my $all_territories = {
    '001' => 'Monde',
    '002' => 'Afrique',
    '003' => 'Amérique du Nord',
    '005' => 'Amérique du Sud',
    '009' => 'Océanie',
    '011' => 'Afrique occidentale',
    '013' => 'Amérique centrale',
    '014' => 'Afrique orientale',
    '015' => 'Afrique septentrionale',
    '017' => 'Afrique centrale',
    '018' => 'Afrique australe',
    '019' => 'Amériques',
    '021' => 'Amérique septentrionale',
    '029' => 'Caraïbes',
    '030' => 'Asie orientale',
    '034' => 'Asie du Sud',
    '035' => 'Asie du Sud-Est',
    '039' => 'Europe méridionale',
    '053' => 'Australasie',
    '054' => 'Mélanésie',
    '057' => 'région micronésienne',
    '061' => 'Polynésie',
    '142' => 'Asie',
    '143' => 'Asie centrale',
    '145' => 'Asie occidentale',
    '150' => 'Europe',
    '151' => 'Europe orientale',
    '154' => 'Europe septentrionale',
    '155' => 'Europe occidentale',
    '419' => 'Amérique latine',
    'AC' => 'Île de l’Ascension',
    'AD' => 'Andorre',
    'AE' => 'Émirats arabes unis',
    'AF' => 'Afghanistan',
    'AG' => 'Antigua-et-Barbuda',
    'AI' => 'Anguilla',
    'AL' => 'Albanie',
    'AM' => 'Arménie',
    'AN' => 'Antilles néerlandaises',
    'AO' => 'Angola',
    'AQ' => 'Antarctique',
    'AR' => 'Argentine',
    'AS' => 'Samoa américaines',
    'AT' => 'Autriche',
    'AU' => 'Australie',
    'AW' => 'Aruba',
    'AX' => 'Îles Åland',
    'AZ' => 'Azerbaïdjan',
    'BA' => 'Bosnie-Herzégovine',
    'BB' => 'Barbade',
    'BD' => 'Bangladesh',
    'BE' => 'Belgique',
    'BF' => 'Burkina Faso',
    'BG' => 'Bulgarie',
    'BH' => 'Bahreïn',
    'BI' => 'Burundi',
    'BJ' => 'Bénin',
    'BL' => 'Saint-Barthélemy',
    'BM' => 'Bermudes',
    'BN' => 'Brunéi Darussalam',
    'BO' => 'Bolivie',
    'BQ' => 'Pays-Bas caribéens',
    'BR' => 'Brésil',
    'BS' => 'Bahamas',
    'BT' => 'Bhoutan',
    'BV' => 'Île Bouvet',
    'BW' => 'Botswana',
    'BY' => 'Biélorussie',
    'BZ' => 'Belize',
    'CA' => 'Canada',
    'CC' => 'Îles Cocos',
    'CD' => 'Congo-Kinshasa',
    'CD@alt=variant' => 'Congo (RDC)',
    'CF' => 'République centrafricaine',
    'CG' => 'Congo-Brazzaville',
    'CG@alt=variant' => 'République du Congo',
    'CH' => 'Suisse',
    'CI' => 'Côte d’Ivoire',
    'CK' => 'Îles Cook',
    'CL' => 'Chili',
    'CM' => 'Cameroun',
    'CN' => 'Chine',
    'CO' => 'Colombie',
    'CP' => 'Île Clipperton',
    'CR' => 'Costa Rica',
    'CU' => 'Cuba',
    'CV' => 'Cap-Vert',
    'CW' => 'Curaçao',
    'CX' => 'Île Christmas',
    'CY' => 'Chypre',
    'CZ' => 'République tchèque',
    'DE' => 'Allemagne',
    'DG' => 'Diego Garcia',
    'DJ' => 'Djibouti',
    'DK' => 'Danemark',
    'DM' => 'Dominique',
    'DO' => 'République dominicaine',
    'DZ' => 'Algérie',
    'EA' => 'Ceuta et Melilla',
    'EC' => 'Équateur',
    'EE' => 'Estonie',
    'EG' => 'Égypte',
    'EH' => 'Sahara occidental',
    'ER' => 'Érythrée',
    'ES' => 'Espagne',
    'ET' => 'Éthiopie',
    'EU' => 'Union européenne',
    'FI' => 'Finlande',
    'FJ' => 'Fidji',
    'FK' => 'Îles Malouines',
    'FK@alt=variant' => 'Îles Falkland',
    'FM' => 'États fédérés de Micronésie',
    'FO' => 'Îles Féroé',
    'FR' => 'France',
    'GA' => 'Gabon',
    'GB' => 'Royaume-Uni',
    'GB@alt=short' => 'R.-U.',
    'GD' => 'Grenade',
    'GE' => 'Géorgie',
    'GF' => 'Guyane française',
    'GG' => 'Guernesey',
    'GH' => 'Ghana',
    'GI' => 'Gibraltar',
    'GL' => 'Groenland',
    'GM' => 'Gambie',
    'GN' => 'Guinée',
    'GP' => 'Guadeloupe',
    'GQ' => 'Guinée équatoriale',
    'GR' => 'Grèce',
    'GS' => 'Îles Géorgie du Sud et Sandwich du Sud',
    'GT' => 'Guatemala',
    'GU' => 'Guam',
    'GW' => 'Guinée-Bissau',
    'GY' => 'Guyana',
    'HK' => 'R.A.S. chinoise de Hong Kong',
    'HK@alt=short' => 'Hong Kong',
    'HM' => 'Îles Heard et McDonald',
    'HN' => 'Honduras',
    'HR' => 'Croatie',
    'HT' => 'Haïti',
    'HU' => 'Hongrie',
    'IC' => 'Îles Canaries',
    'ID' => 'Indonésie',
    'IE' => 'Irlande',
    'IL' => 'Israël',
    'IM' => 'Île de Man',
    'IN' => 'Inde',
    'IO' => 'Territoire britannique de l’océan Indien',
    'IQ' => 'Irak',
    'IR' => 'Iran',
    'IS' => 'Islande',
    'IT' => 'Italie',
    'JE' => 'Jersey',
    'JM' => 'Jamaïque',
    'JO' => 'Jordanie',
    'JP' => 'Japon',
    'KE' => 'Kenya',
    'KG' => 'Kirghizistan',
    'KH' => 'Cambodge',
    'KI' => 'Kiribati',
    'KM' => 'Comores',
    'KN' => 'Saint-Christophe-et-Niévès',
    'KP' => 'Corée du Nord',
    'KR' => 'Corée du Sud',
    'KW' => 'Koweït',
    'KY' => 'Îles Caïmans',
    'KZ' => 'Kazakhstan',
    'LA' => 'Laos',
    'LB' => 'Liban',
    'LC' => 'Sainte-Lucie',
    'LI' => 'Liechtenstein',
    'LK' => 'Sri Lanka',
    'LR' => 'Libéria',
    'LS' => 'Lesotho',
    'LT' => 'Lituanie',
    'LU' => 'Luxembourg',
    'LV' => 'Lettonie',
    'LY' => 'Libye',
    'MA' => 'Maroc',
    'MC' => 'Monaco',
    'MD' => 'Moldavie',
    'ME' => 'Monténégro',
    'MF' => 'Saint-Martin (partie française)',
    'MG' => 'Madagascar',
    'MH' => 'Îles Marshall',
    'MK' => 'Macédoine',
    'MK@alt=variant' => 'Macédoine (ARYM)',
    'ML' => 'Mali',
    'MM' => 'Myanmar',
    'MN' => 'Mongolie',
    'MO' => 'R.A.S. chinoise de Macao',
    'MO@alt=short' => 'Macao',
    'MP' => 'Îles Mariannes du Nord',
    'MQ' => 'Martinique',
    'MR' => 'Mauritanie',
    'MS' => 'Montserrat',
    'MT' => 'Malte',
    'MU' => 'Maurice',
    'MV' => 'Maldives',
    'MW' => 'Malawi',
    'MX' => 'Mexique',
    'MY' => 'Malaisie',
    'MZ' => 'Mozambique',
    'NA' => 'Namibie',
    'NC' => 'Nouvelle-Calédonie',
    'NE' => 'Niger',
    'NF' => 'Île Norfolk',
    'NG' => 'Nigéria',
    'NI' => 'Nicaragua',
    'NL' => 'Pays-Bas',
    'NO' => 'Norvège',
    'NP' => 'Népal',
    'NR' => 'Nauru',
    'NU' => 'Niue',
    'NZ' => 'Nouvelle-Zélande',
    'OM' => 'Oman',
    'PA' => 'Panama',
    'PE' => 'Pérou',
    'PF' => 'Polynésie française',
    'PG' => 'Papouasie-Nouvelle-Guinée',
    'PH' => 'Philippines',
    'PK' => 'Pakistan',
    'PL' => 'Pologne',
    'PM' => 'Saint-Pierre-et-Miquelon',
    'PN' => 'Pitcairn',
    'PR' => 'Porto Rico',
    'PS' => 'Territoires palestiniens',
    'PS@alt=short' => 'Palestine',
    'PT' => 'Portugal',
    'PW' => 'Palaos',
    'PY' => 'Paraguay',
    'QA' => 'Qatar',
    'QO' => 'régions éloignées de l’Océanie',
    'RE' => 'La Réunion',
    'RO' => 'Roumanie',
    'RS' => 'Serbie',
    'RU' => 'Russie',
    'RW' => 'Rwanda',
    'SA' => 'Arabie saoudite',
    'SB' => 'Îles Salomon',
    'SC' => 'Seychelles',
    'SD' => 'Soudan',
    'SE' => 'Suède',
    'SG' => 'Singapour',
    'SH' => 'Sainte-Hélène',
    'SI' => 'Slovénie',
    'SJ' => 'Svalbard et Jan Mayen',
    'SK' => 'Slovaquie',
    'SL' => 'Sierra Leone',
    'SM' => 'Saint-Marin',
    'SN' => 'Sénégal',
    'SO' => 'Somalie',
    'SR' => 'Suriname',
    'SS' => 'Soudan du Sud',
    'ST' => 'Sao Tomé-et-Principe',
    'SV' => 'El Salvador',
    'SX' => 'Saint-Martin (partie néerlandaise)',
    'SY' => 'Syrie',
    'SZ' => 'Swaziland',
    'TA' => 'Tristan da Cunha',
    'TC' => 'Îles Turques-et-Caïques',
    'TD' => 'Tchad',
    'TF' => 'Terres australes françaises',
    'TG' => 'Togo',
    'TH' => 'Thaïlande',
    'TJ' => 'Tadjikistan',
    'TK' => 'Tokelau',
    'TL' => 'Timor oriental',
    'TL@alt=variant' => 'Timor-Oriental',
    'TM' => 'Turkménistan',
    'TN' => 'Tunisie',
    'TO' => 'Tonga',
    'TR' => 'Turquie',
    'TT' => 'Trinité-et-Tobago',
    'TV' => 'Tuvalu',
    'TW' => 'Taïwan',
    'TZ' => 'Tanzanie',
    'UA' => 'Ukraine',
    'UG' => 'Ouganda',
    'UM' => 'Îles mineures éloignées des États-Unis',
    'US' => 'États-Unis',
    'US@alt=short' => 'É.-U.',
    'UY' => 'Uruguay',
    'UZ' => 'Ouzbékistan',
    'VA' => 'État de la Cité du Vatican',
    'VC' => 'Saint-Vincent-et-les-Grenadines',
    'VE' => 'Venezuela',
    'VG' => 'Îles Vierges britanniques',
    'VI' => 'Îles Vierges des États-Unis',
    'VN' => 'Vietnam',
    'VU' => 'Vanuatu',
    'WF' => 'Wallis-et-Futuna',
    'WS' => 'Samoa',
    'XK' => 'Kosovo',
    'YE' => 'Yémen',
    'YT' => 'Mayotte',
    'ZA' => 'Afrique du Sud',
    'ZM' => 'Zambie',
    'ZW' => 'Zimbabwe',
    'ZZ' => 'région indéterminée',
};

is_deeply($locale->all_territories(), $all_territories, 'All Territories');

is($locale->variant_name(), '', 'Variant name from current locale');
is($locale->variant_name('BOHORIC'), 'alphabet Bohorič', 'Variant name from string');
is($locale->variant_name($other_locale), '', 'Variant name from other locale object');

is($locale->key_name('colCaseLevel'), 'Tri sensible à la casse', 'Key name from string');

is($locale->type_name(colCaseFirst => 'lower'), 'Trier avec les minuscules d’abord', 'Type name from string');

is($locale->measurement_system_name('metric'), 'métrique', 'Measurement system name French Metric');
is($locale->measurement_system_name('us'), 'américain', 'Measurement system name French US');
is($locale->measurement_system_name('uk'), 'impérial', 'Measurement system name French UK');

is($locale->transform_name('Numeric'), 'Numérique', 'Transform name from string');