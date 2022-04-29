# coding: utf-8
require 'asciidammit'
describe Asciidammit do
  # keep this for handy string w/lots of symbols
  it "should demoronize the special characters provided by word" do
    expect(Asciidammit.demoronize( "—–‑­ ©®™§¶…‘’“”" )).to eq  "----  (c)[R][TM]SP...''\"\""
  end
  # the MS Word provided symbols 1 at a time
  [
   ["—", "--" ],
   ["–", "-"],
    ["‑", "-"],
    ["­", " "],
   [" ", " "],
   ["©", "(c)"],
   ["®", "[R]"],
   ["™", "[TM]"],
   ["§", "S"],
   ["¶", "P"],
   ["…", "..."],
   ["‘", "'"],
   ["’", "'"],
   ["“", "\""],
   ["”", "\""],

  ].each { |ms_symbol, ascii|
    it "should convert #{ms_symbol} to #{ascii}" do
      expect(Asciidammit.demoronize( ms_symbol)).to eq ascii
    end
  }

end
