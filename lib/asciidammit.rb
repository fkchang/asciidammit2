require "asciidammit/version"

# ported from asciidammit.py
# different API and classname (Asciidammit vs AsciiDammit)the the existing asciidammit gem
module Asciidammit

  CP1252_CHARS = { 0x80 => ['EUR', 'euro'],
    0x81 => [' ', ' '],
    0x82 => [',', 'sbquo'],
    0x83 => ['f', 'fnof'],
    0x84 => [',,', 'bdquo'],
    0x85 => ['...', 'hellip'],
    0x86 => ['+', 'dagger'],
    0x87 => ['++', 'Dagger'],
    0x88 => ['^', 'caret'],
    0x89 => ['%','%'],
    0x8A => ['S', 'Scaron'],
    0x8B => ['<', 'lt;'],
    0x8C => ['OE', 'OElig'],
    0x8D => ['?','?'],
    0x8E => ['Z', 'Z'],
    0x8F => ['?','?'],
    0x90 => ['?', '?'],
    0x91 => ["'", 'lsquo'],
    0x92 => ["'", 'rsquo'],
    0x93 => ['"', 'ldquo'],
    0x94 => ['"', 'rdquo'],
    0x95 => ['*', 'bull'],
    0x96 => ['-', 'ndash'],
    0x97 => ['--', 'mdash'],
    0x98 => ['~', 'tilde'],
    0x99 => ['[TM]', 'trade'],
    0x9a => ['s', 'scaron'],
    0x9b => ['>', 'gt'],
    0x9c => ['oe', 'oelig'],
    0x9d => ['?', '?'],
    0x9e => ['z', 'z'],
    0x9f => ['Y', 'Yuml'],
    0xa0 => [' ', 'nbsp'],
    0xa1 => ['!', 'iexcl'],
    0xa2 => ['c', 'cent'],
    0xa3 => ['GBP', 'pound'],
    0xa4 => ['$', 'curren'], #This approximation is especially lame.
    0xa5 => ['YEN', 'yen'],
    0xa6 => ['|', 'brvbar'],
    0xa7 => ['S', 'sect'],
    0xa8 => ['..', 'uml'],
    0xa9 => ['(c)', 'copy'],
    0xaa => ['[th]', 'ordf'],
    0xab => ['<<', 'laquo'],
    0xac => ['!', 'not'],
    0xad => [' ', 'shy'],
    0xae => ['[R]', 'reg'],
    0xaf => ['-', 'macr'],
    0xb0 => ['o', 'deg'],
    0xb1 => ['+-', 'plusmm'],
    0xb2 => ['2', 'sup2'],
    0xb3 => ['3', 'sup3'],
    0xb4 => ["'", 'acute'],
    0xb5 => ['u', 'micro'],
    0xb6 => ['P', 'para'],
    0xb7 => ['*', 'middot'],
    0xb8 => [',', 'cedil'],
    0xb9 => ['1', 'sup1'],
    0xba => ['[th]', 'ordm'],
    0xbb => ['>>', 'raquo'],
    0xbc => ['1/4', 'frac14'],
    0xbd => ['1/2', 'frac12'],
    0xbe => ['3/4', 'frac34'],
    0xbf => ['?', 'iquest'],
    0xc0 => ['A', "Agrave"],
    0xc1 => ['A', "Aacute"],
    0xc2 => ['A', "Acirc"],
    0xc3 => ['A', "Atilde"],
    0xc4 => ['A', "Auml"],
    0xc5 => ['A', "Aring"],
    0xc6 => ['AE', "Aelig"],
    0xc7 => ['C', "Ccedil"],
    0xc8 => ['E', "Egrave"],
    0xc9 => ['E', "Eacute"],
    0xca => ['E', "Ecirc"],
    0xcb => ['E', "Euml"],
    0xcc => ['I', "Igrave"],
    0xcd => ['I', "Iacute"],
    0xce => ['I', "Icirc"],
    0xcf => ['I', "Iuml"],
    0xd0 => ['D', "Eth"],
    0xd1 => ['N', "Ntilde"],
    0xd2 => ['O', "Ograve"],
    0xd3 => ['O', "Oacute"],
    0xd4 => ['O', "Ocirc"],
    0xd5 => ['O', "Otilde"],
    0xd6 => ['O', "Ouml"],
    0xd7 => ['*', "times"],
    0xd8 => ['O', "Oslash"],
    0xd9 => ['U', "Ugrave"],
    0xda => ['U', "Uacute"],
    0xdb => ['U', "Ucirc"],
    0xdc => ['U', "Uuml"],
    0xdd => ['Y', "Yacute"],
    0xde => ['b', "Thorn"],
    0xdf => ['B', "szlig"],
    0xe0 => ['a', "agrave"],
    0xe1 => ['a', "aacute"],
    0xe2 => ['a', "acirc"],
    0xe3 => ['a', "atilde"],
    0xe4 => ['a', "auml"],
    0xe5 => ['a', "aring"],
    0xe6 => ['ae', "aelig"],
    0xe7 => ['c', "ccedil"],
    0xe8 => ['e', "egrave"],
    0xe9 => ['e', "eacute"],
    0xea => ['e', "ecirc"],
    0xeb => ['e', "euml"],
    0xec => ['i', "igrave"],
    0xed => ['i', "iacute"],
    0xee => ['i', "icirc"],
    0xef => ['i', "iuml"],
    0xf0 => ['o', "eth"],
    0xf1 => ['n', "ntilde"],
    0xf2 => ['o', "ograve"],
    0xf3 => ['o', "oacute"],
    0xf4 => ['o', "ocirc"],
    0xf5 => ['o', "otilde"],
    0xf6 => ['o', "ouml"],
    0xf7 => ['/', "divide"],
    0xf8 => ['o', "oslash"],
    0xf9 => ['u', "ugrave"],
    0xfa => ['u', "uacute"],
    0xfb => ['u', "ucirc"],
    0xfc => ['u', "uuml"],
    0xfd => ['y', "yacute"],
    0xfe => ['b', "thorn"],
    0xff => ['y', "yuml"],
    # added by me for test crashing Vertical Response
    0x2010 => ['-', "#x2010"],
    0x2011 => ['-', "#x2011"],
    0x2012 => ['-', "#x2012"],
  }

  # from http://www.unicode.org/Public/MAPPINGS/VENDORS/MICSFT/WINDOWS/CP1252.TXT
  CP1252_MAP = {
    #
    #    Name:     cp1252 to Unicode table
    #    Unicode version: 2.0
    #    Table version: 2.01
    #    Table format:  Format A
    #    Date:          04/15/98
    #
    #    Contact:       Shawn.Steele@microsoft.com
    #
    #    General notes: none
    #
    #    Format: Three tab-separated columns
    #        Column #1 is the cp1252 code (in hex)
    #        Column #2 is the Unicode (in hex as 0xXXXX)
    #        Column #3 is the Unicode name (follows a comment sign, '#')
    #
    #    The entries are in cp1252 order
    #
    0x00 =>       0x0000, #NULL
    0x01 =>       0x0001, #START OF HEADING
    0x02 =>       0x0002, #START OF TEXT
    0x03 =>       0x0003, #END OF TEXT
    0x04 =>       0x0004, #END OF TRANSMISSION
    0x05 =>       0x0005, #ENQUIRY
    0x06 =>       0x0006, #ACKNOWLEDGE
    0x07 =>       0x0007, #BELL
    0x08 =>       0x0008, #BACKSPACE
    0x09 =>       0x0009, #HORIZONTAL TABULATION
    0x0A =>       0x000A, #LINE FEED
    0x0B =>       0x000B, #VERTICAL TABULATION
    0x0C =>       0x000C, #FORM FEED
    0x0D =>       0x000D, #CARRIAGE RETURN
    0x0E =>       0x000E, #SHIFT OUT
    0x0F =>       0x000F, #SHIFT IN
    0x10 =>       0x0010, #DATA LINK ESCAPE
    0x11 =>       0x0011, #DEVICE CONTROL ONE
    0x12 =>       0x0012, #DEVICE CONTROL TWO
    0x13 =>       0x0013, #DEVICE CONTROL THREE
    0x14 =>       0x0014, #DEVICE CONTROL FOUR
    0x15 =>       0x0015, #NEGATIVE ACKNOWLEDGE
    0x16 =>       0x0016, #SYNCHRONOUS IDLE
    0x17 =>       0x0017, #END OF TRANSMISSION BLOCK
    0x18 =>       0x0018, #CANCEL
    0x19 =>       0x0019, #END OF MEDIUM
    0x1A =>       0x001A, #SUBSTITUTE
    0x1B =>       0x001B, #ESCAPE
    0x1C =>       0x001C, #FILE SEPARATOR
    0x1D =>       0x001D, #GROUP SEPARATOR
    0x1E =>       0x001E, #RECORD SEPARATOR
    0x1F =>       0x001F, #UNIT SEPARATOR
    0x20 =>       0x0020, #SPACE
    0x21 =>       0x0021, #EXCLAMATION MARK
    0x22 =>       0x0022, #QUOTATION MARK
    0x23 =>       0x0023, #NUMBER SIGN
    0x24 =>       0x0024, #DOLLAR SIGN
    0x25 =>       0x0025, #PERCENT SIGN
    0x26 =>       0x0026, #AMPERSAND
    0x27 =>       0x0027, #APOSTROPHE
    0x28 =>       0x0028, #LEFT PARENTHESIS
    0x29 =>       0x0029, #RIGHT PARENTHESIS
    0x2A =>       0x002A, #ASTERISK
    0x2B =>       0x002B, #PLUS SIGN
    0x2C =>       0x002C, #COMMA
    0x2D =>       0x002D, #HYPHEN-MINUS
    0x2E =>       0x002E, #FULL STOP
    0x2F =>       0x002F, #SOLIDUS
    0x30 =>       0x0030, #DIGIT ZERO
    0x31 =>       0x0031, #DIGIT ONE
    0x32 =>       0x0032, #DIGIT TWO
    0x33 =>       0x0033, #DIGIT THREE
    0x34 =>       0x0034, #DIGIT FOUR
    0x35 =>       0x0035, #DIGIT FIVE
    0x36 =>       0x0036, #DIGIT SIX
    0x37 =>       0x0037, #DIGIT SEVEN
    0x38 =>       0x0038, #DIGIT EIGHT
    0x39 =>       0x0039, #DIGIT NINE
    0x3A =>       0x003A, #COLON
    0x3B =>       0x003B, #SEMICOLON
    0x3C =>       0x003C, #LESS-THAN SIGN
    0x3D =>       0x003D, #EQUALS SIGN
    0x3E =>       0x003E, #GREATER-THAN SIGN
    0x3F =>       0x003F, #QUESTION MARK
    0x40 =>       0x0040, #COMMERCIAL AT
    0x41 =>       0x0041, #LATIN CAPITAL LETTER A
    0x42 =>       0x0042, #LATIN CAPITAL LETTER B
    0x43 =>       0x0043, #LATIN CAPITAL LETTER C
    0x44 =>       0x0044, #LATIN CAPITAL LETTER D
    0x45 =>       0x0045, #LATIN CAPITAL LETTER E
    0x46 =>       0x0046, #LATIN CAPITAL LETTER F
    0x47 =>       0x0047, #LATIN CAPITAL LETTER G
    0x48 =>       0x0048, #LATIN CAPITAL LETTER H
    0x49 =>       0x0049, #LATIN CAPITAL LETTER I
    0x4A =>       0x004A, #LATIN CAPITAL LETTER J
    0x4B =>       0x004B, #LATIN CAPITAL LETTER K
    0x4C =>       0x004C, #LATIN CAPITAL LETTER L
    0x4D =>       0x004D, #LATIN CAPITAL LETTER M
    0x4E =>       0x004E, #LATIN CAPITAL LETTER N
    0x4F =>       0x004F, #LATIN CAPITAL LETTER O
    0x50 =>       0x0050, #LATIN CAPITAL LETTER P
    0x51 =>       0x0051, #LATIN CAPITAL LETTER Q
    0x52 =>       0x0052, #LATIN CAPITAL LETTER R
    0x53 =>       0x0053, #LATIN CAPITAL LETTER S
    0x54 =>       0x0054, #LATIN CAPITAL LETTER T
    0x55 =>       0x0055, #LATIN CAPITAL LETTER U
    0x56 =>       0x0056, #LATIN CAPITAL LETTER V
    0x57 =>       0x0057, #LATIN CAPITAL LETTER W
    0x58 =>       0x0058, #LATIN CAPITAL LETTER X
    0x59 =>       0x0059, #LATIN CAPITAL LETTER Y
    0x5A =>       0x005A, #LATIN CAPITAL LETTER Z
    0x5B =>       0x005B, #LEFT SQUARE BRACKET
    0x5C =>       0x005C, #REVERSE SOLIDUS
    0x5D =>       0x005D, #RIGHT SQUARE BRACKET
    0x5E =>       0x005E, #CIRCUMFLEX ACCENT
    0x5F =>       0x005F, #LOW LINE
    0x60 =>       0x0060, #GRAVE ACCENT
    0x61 =>       0x0061, #LATIN SMALL LETTER A
    0x62 =>       0x0062, #LATIN SMALL LETTER B
    0x63 =>       0x0063, #LATIN SMALL LETTER C
    0x64 =>       0x0064, #LATIN SMALL LETTER D
    0x65 =>       0x0065, #LATIN SMALL LETTER E
    0x66 =>       0x0066, #LATIN SMALL LETTER F
    0x67 =>       0x0067, #LATIN SMALL LETTER G
    0x68 =>       0x0068, #LATIN SMALL LETTER H
    0x69 =>       0x0069, #LATIN SMALL LETTER I
    0x6A =>       0x006A, #LATIN SMALL LETTER J
    0x6B =>       0x006B, #LATIN SMALL LETTER K
    0x6C =>       0x006C, #LATIN SMALL LETTER L
    0x6D =>       0x006D, #LATIN SMALL LETTER M
    0x6E =>       0x006E, #LATIN SMALL LETTER N
    0x6F =>       0x006F, #LATIN SMALL LETTER O
    0x70 =>       0x0070, #LATIN SMALL LETTER P
    0x71 =>       0x0071, #LATIN SMALL LETTER Q
    0x72 =>       0x0072, #LATIN SMALL LETTER R
    0x73 =>       0x0073, #LATIN SMALL LETTER S
    0x74 =>       0x0074, #LATIN SMALL LETTER T
    0x75 =>       0x0075, #LATIN SMALL LETTER U
    0x76 =>       0x0076, #LATIN SMALL LETTER V
    0x77 =>       0x0077, #LATIN SMALL LETTER W
    0x78 =>       0x0078, #LATIN SMALL LETTER X
    0x79 =>       0x0079, #LATIN SMALL LETTER Y
    0x7A =>       0x007A, #LATIN SMALL LETTER Z
    0x7B =>       0x007B, #LEFT CURLY BRACKET
    0x7C =>       0x007C, #VERTICAL LINE
    0x7D =>       0x007D, #RIGHT CURLY BRACKET
    0x7E =>       0x007E, #TILDE
    0x7F =>       0x007F, #DELETE
    0x80 =>       0x20AC, #EURO SIGN
    0x81 =>          nil, #UNDEFINED,
    0x82 =>       0x201A, #SINGLE LOW-9 QUOTATION MARK
    0x83 =>       0x0192, #LATIN SMALL LETTER F WITH HOOK
    0x84 =>       0x201E, #DOUBLE LOW-9 QUOTATION MARK
    0x85 =>       0x2026, #HORIZONTAL ELLIPSIS
    0x86 =>       0x2020, #DAGGER
    0x87 =>       0x2021, #DOUBLE DAGGER
    0x88 =>       0x02C6, #MODIFIER LETTER CIRCUMFLEX ACCENT
    0x89 =>       0x2030, #PER MILLE SIGN
    0x8A =>       0x0160, #LATIN CAPITAL LETTER S WITH CARON
    0x8B =>       0x2039, #SINGLE LEFT-POINTING ANGLE QUOTATION MARK
    0x8C =>       0x0152, #LATIN CAPITAL LIGATURE OE
    0x8D =>          nil, #UNDEFINED,
    0x8E =>       0x017D, #LATIN CAPITAL LETTER Z WITH CARON
    0x8F =>          nil, #UNDEFINED,
    0x90 =>          nil, #UNDEFINED,
    0x91 =>       0x2018, #LEFT SINGLE QUOTATION MARK
    0x92 =>       0x2019, #RIGHT SINGLE QUOTATION MARK
    0x93 =>       0x201C, #LEFT DOUBLE QUOTATION MARK
    0x94 =>       0x201D, #RIGHT DOUBLE QUOTATION MARK
    0x95 =>       0x2022, #BULLET
    0x96 =>       0x2013, #EN DASH
    0x97 =>       0x2014, #EM DASH
    0x98 =>       0x02DC, #SMALL TILDE
    0x99 =>       0x2122, #TRADE MARK SIGN
    0x9A =>       0x0161, #LATIN SMALL LETTER S WITH CARON
    0x9B =>       0x203A, #SINGLE RIGHT-POINTING ANGLE QUOTATION MARK
    0x9C =>       0x0153, #LATIN SMALL LIGATURE OE
    0x9D =>          nil, #UNDEFINED,
    0x9E =>       0x017E, #LATIN SMALL LETTER Z WITH CARON
    0x9F =>       0x0178, #LATIN CAPITAL LETTER Y WITH DIAERESIS
    0xA0 =>       0x00A0, #NO-BREAK SPACE
    0xA1 =>       0x00A1, #INVERTED EXCLAMATION MARK
    0xA2 =>       0x00A2, #CENT SIGN
    0xA3 =>       0x00A3, #POUND SIGN
    0xA4 =>       0x00A4, #CURRENCY SIGN
    0xA5 =>       0x00A5, #YEN SIGN
    0xA6 =>       0x00A6, #BROKEN BAR
    0xA7 =>       0x00A7, #SECTION SIGN
    0xA8 =>       0x00A8, #DIAERESIS
    0xA9 =>       0x00A9, #COPYRIGHT SIGN
    0xAA =>       0x00AA, #FEMININE ORDINAL INDICATOR
    0xAB =>       0x00AB, #LEFT-POINTING DOUBLE ANGLE QUOTATION MARK
    0xAC =>       0x00AC, #NOT SIGN
    0xAD =>       0x00AD, #SOFT HYPHEN
    0xAE =>       0x00AE, #REGISTERED SIGN
    0xAF =>       0x00AF, #MACRON
    0xB0 =>       0x00B0, #DEGREE SIGN
    0xB1 =>       0x00B1, #PLUS-MINUS SIGN
    0xB2 =>       0x00B2, #SUPERSCRIPT TWO
    0xB3 =>       0x00B3, #SUPERSCRIPT THREE
    0xB4 =>       0x00B4, #ACUTE ACCENT
    0xB5 =>       0x00B5, #MICRO SIGN
    0xB6 =>       0x00B6, #PILCROW SIGN
    0xB7 =>       0x00B7, #MIDDLE DOT
    0xB8 =>       0x00B8, #CEDILLA
    0xB9 =>       0x00B9, #SUPERSCRIPT ONE
    0xBA =>       0x00BA, #MASCULINE ORDINAL INDICATOR
    0xBB =>       0x00BB, #RIGHT-POINTING DOUBLE ANGLE QUOTATION MARK
    0xBC =>       0x00BC, #VULGAR FRACTION ONE QUARTER
    0xBD =>       0x00BD, #VULGAR FRACTION ONE HALF
    0xBE =>       0x00BE, #VULGAR FRACTION THREE QUARTERS
    0xBF =>       0x00BF, #INVERTED QUESTION MARK
    0xC0 =>       0x00C0, #LATIN CAPITAL LETTER A WITH GRAVE
    0xC1 =>       0x00C1, #LATIN CAPITAL LETTER A WITH ACUTE
    0xC2 =>       0x00C2, #LATIN CAPITAL LETTER A WITH CIRCUMFLEX
    0xC3 =>       0x00C3, #LATIN CAPITAL LETTER A WITH TILDE
    0xC4 =>       0x00C4, #LATIN CAPITAL LETTER A WITH DIAERESIS
    0xC5 =>       0x00C5, #LATIN CAPITAL LETTER A WITH RING ABOVE
    0xC6 =>       0x00C6, #LATIN CAPITAL LETTER AE
    0xC7 =>       0x00C7, #LATIN CAPITAL LETTER C WITH CEDILLA
    0xC8 =>       0x00C8, #LATIN CAPITAL LETTER E WITH GRAVE
    0xC9 =>       0x00C9, #LATIN CAPITAL LETTER E WITH ACUTE
    0xCA =>       0x00CA, #LATIN CAPITAL LETTER E WITH CIRCUMFLEX
    0xCB =>       0x00CB, #LATIN CAPITAL LETTER E WITH DIAERESIS
    0xCC =>       0x00CC, #LATIN CAPITAL LETTER I WITH GRAVE
    0xCD =>       0x00CD, #LATIN CAPITAL LETTER I WITH ACUTE
    0xCE =>       0x00CE, #LATIN CAPITAL LETTER I WITH CIRCUMFLEX
    0xCF =>       0x00CF, #LATIN CAPITAL LETTER I WITH DIAERESIS
    0xD0 =>       0x00D0, #LATIN CAPITAL LETTER ETH
    0xD1 =>       0x00D1, #LATIN CAPITAL LETTER N WITH TILDE
    0xD2 =>       0x00D2, #LATIN CAPITAL LETTER O WITH GRAVE
    0xD3 =>       0x00D3, #LATIN CAPITAL LETTER O WITH ACUTE
    0xD4 =>       0x00D4, #LATIN CAPITAL LETTER O WITH CIRCUMFLEX
    0xD5 =>       0x00D5, #LATIN CAPITAL LETTER O WITH TILDE
    0xD6 =>       0x00D6, #LATIN CAPITAL LETTER O WITH DIAERESIS
    0xD7 =>       0x00D7, #MULTIPLICATION SIGN
    0xD8 =>       0x00D8, #LATIN CAPITAL LETTER O WITH STROKE
    0xD9 =>       0x00D9, #LATIN CAPITAL LETTER U WITH GRAVE
    0xDA =>       0x00DA, #LATIN CAPITAL LETTER U WITH ACUTE
    0xDB =>       0x00DB, #LATIN CAPITAL LETTER U WITH CIRCUMFLEX
    0xDC =>       0x00DC, #LATIN CAPITAL LETTER U WITH DIAERESIS
    0xDD =>       0x00DD, #LATIN CAPITAL LETTER Y WITH ACUTE
    0xDE =>       0x00DE, #LATIN CAPITAL LETTER THORN
    0xDF =>       0x00DF, #LATIN SMALL LETTER SHARP S
    0xE0 =>       0x00E0, #LATIN SMALL LETTER A WITH GRAVE
    0xE1 =>       0x00E1, #LATIN SMALL LETTER A WITH ACUTE
    0xE2 =>       0x00E2, #LATIN SMALL LETTER A WITH CIRCUMFLEX
    0xE3 =>       0x00E3, #LATIN SMALL LETTER A WITH TILDE
    0xE4 =>       0x00E4, #LATIN SMALL LETTER A WITH DIAERESIS
    0xE5 =>       0x00E5, #LATIN SMALL LETTER A WITH RING ABOVE
    0xE6 =>       0x00E6, #LATIN SMALL LETTER AE
    0xE7 =>       0x00E7, #LATIN SMALL LETTER C WITH CEDILLA
    0xE8 =>       0x00E8, #LATIN SMALL LETTER E WITH GRAVE
    0xE9 =>       0x00E9, #LATIN SMALL LETTER E WITH ACUTE
    0xEA =>       0x00EA, #LATIN SMALL LETTER E WITH CIRCUMFLEX
    0xEB =>       0x00EB, #LATIN SMALL LETTER E WITH DIAERESIS
    0xEC =>       0x00EC, #LATIN SMALL LETTER I WITH GRAVE
    0xED =>       0x00ED, #LATIN SMALL LETTER I WITH ACUTE
    0xEE =>       0x00EE, #LATIN SMALL LETTER I WITH CIRCUMFLEX
    0xEF =>       0x00EF, #LATIN SMALL LETTER I WITH DIAERESIS
    0xF0 =>       0x00F0, #LATIN SMALL LETTER ETH
    0xF1 =>       0x00F1, #LATIN SMALL LETTER N WITH TILDE
    0xF2 =>       0x00F2, #LATIN SMALL LETTER O WITH GRAVE
    0xF3 =>       0x00F3, #LATIN SMALL LETTER O WITH ACUTE
    0xF4 =>       0x00F4, #LATIN SMALL LETTER O WITH CIRCUMFLEX
    0xF5 =>       0x00F5, #LATIN SMALL LETTER O WITH TILDE
    0xF6 =>       0x00F6, #LATIN SMALL LETTER O WITH DIAERESIS
    0xF7 =>       0x00F7, #DIVISION SIGN
    0xF8 =>       0x00F8, #LATIN SMALL LETTER O WITH STROKE
    0xF9 =>       0x00F9, #LATIN SMALL LETTER U WITH GRAVE
    0xFA =>       0x00FA, #LATIN SMALL LETTER U WITH ACUTE
    0xFB =>       0x00FB, #LATIN SMALL LETTER U WITH CIRCUMFLEX
    0xFC =>       0x00FC, #LATIN SMALL LETTER U WITH DIAERESIS
    0xFD =>       0x00FD, #LATIN SMALL LETTER Y WITH ACUTE
    0xFE =>       0x00FE, #LATIN SMALL LETTER THORN
    0xFF =>       0x00FF, #LATIN SMALL LETTER Y WITH DIAERESIS
    # added by me for crashing VR
    # http://unicode-search.net/unicode-namesearch.pl?term=hyphen
    0X2010 =>    0x2010, #HYPHEN
    0X2011 =>    0x2011, #NON BREAKING HYPHEN
    0X2012 =>    0x2012, #FIGURE DASH


  }

  # from http://redhanded.hobix.com/inspect/closingInOnUnicodeWithJcode.html
  def self.utf_encode( str )
    String.new str.gsub(/U\+([0-9a-fA-F]{4,4})/u){["#$1".hex ].pack('U*')}
  end


  UTF8_CHARS = { nil => ""}
  # Too lazy to manually create a table
  # map the cps1252 to the unicode values
  CP1252_CHARS.each { |cps_code, values|

    if CP1252_MAP[cps_code]
      hex_value = sprintf( '%04X', CP1252_MAP[cps_code])
      plain_ascii = values[0]
      # puts "#{cps_code}, #{values.inspect}, #{CP1252_MAP[cps_code]} #{hex_value}"
    else
      hex_value = sprintf( '%04X', cps_code)
      plain_ascii = ""
    end
    utf_encoded_value = utf_encode "U+#{hex_value}"
    # puts "\thex_value = #{hex_value} utf_encoded_value =  #{utf_encoded_value} #{utf_encode "U+2012"}"
    UTF8_CHARS[Regexp.new( utf_encoded_value)] = plain_ascii
  }


  def self.demoronize( orig_str)
    # hex_rep_ary = []
    # orig_str.each_byte { |b| hex_rep_ary << sprintf( "%x", b) }
    # hex_rep = hex_rep_ary.join( " ")
    string = orig_str.dup
    UTF8_CHARS.each { |regex, value|
      # puts " regex: #{regex} value: #{value} orig: #{orig_str} : #{hex_rep}"
      if string =~ regex
        # puts "subbing #{regex} for #{value}"
        string.gsub!( regex, value)
      end
    }
    string
  end
end