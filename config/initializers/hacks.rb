

class String

  def self.random(length = 40, *args)
    chars = []
    chars += ("a".."z").to_a if args.empty? || args.include?(:lowercase)
    chars += ("A".."Z").to_a if args.empty? || args.include?(:uppercase)
    chars += ("0".."9").to_a if args.empty? || args.include?(:digits)
    return nil if chars.empty?
    Array.new(length) { chars.rand }.join
  end

  def to_number
    n = 0
    each_byte { |b| n = n << 8; n += b }
    n
  end

  def self.backward_hash
    @backward_hash ||= {
      "a" => "AaÀÁÂÃÄÅàáâãäåĀāĂăĄąǍǎǞǟǠǡǺǻȀȁȂȃȦȧḀḁẠạảẤấẦầẨẩẪẫẬậẮắẰằẲẳẴẵẶặÅ",
      "ae" => "ÆæǢǣǼǽ",
      "b" => "BbḂḃḄḅḆḇ",
      "c" => "CcÇçĆćĈĉĊċČčḈḉ",
      "d" => "DdĎďḊḋḌḍḎḏḐḑḒḓĐđ",
      "dz" => "ǱǲǳǄǅǆ",
      "e" => "EeÈÉÊèéêëĒēĔĕĖėĘęĚěȄȅȆȇȨȩḔḕḖḗḘḙḚḛḜḝẸẹẺẻẼẽẾếỀỂểỄễệ",
      "f" => "FfḞḟ",
      "g" => "GgĜĝĞğġĢģǦǧǴǵḠḡ",
      "h" => "HhĤĥȞȟḢḣḤḥḦḧḨḩḪḫẖ",
      "i" => "IiÌÍÎÏìíîïĨĩĪīĬĭĮįİıǏǐȈȉȊȋɪḬḭḮḯỈỉỊị",
      "ij" => "Ĳĳ",
      "j" => "JjĴĵǰ",
      "k" => "KkķǨǩḰḱḲḳḵ",
      "l" => "LlĹĺĻļĽľḶḷḸḹḺḻḼḽ",
      "lj" => "Ǉǈǉ",
      "m" => "MmḾṀṁṂṃ",
      "n" => "NnÑñŃńŅņŇňǸǹṄṅṆṇṈṉṋ",
      "nj" => "Ǌǋǌ",
      "o" => "OoÒÓÔÕÖòóôõöŌōŏőƠơǑǒǪǫǬǭȌȍȎȏȪȫȬȭȮȯȰȱṌṎṏṐṑṒṓỌọỎỏỐốỒồỔổỖỗỘộỚớỜờỞởỠỡỢợƟɵØ",
      "oe" => "Œœɶ",
      "p" => "PpṔṕṖṗ",
      "q" => "Qq",
      "r" => "RrŔŕŖŗŘřȐȑȒȓṘṙṚṛṜṝṞṟ",
      "s" => "SsŚśŜŝŞşŠšſȘșṠṡṢṣṤṥṦṧṨṩẛ",
      "ss" => "ß",
      "t" => "TtŢŤťȚțṪṫṬṭṮṯṰṱẗ",
      "u" => "UuÙÚÛÜùúûüŨũŪūŬŭŮůŰűŲųƯưǓǔǕǖǗǘǙǚǛǜȔȕȖȗṲṳṴṵṶṷṸṹṺṻỤụỦủỨứỪừỬửỮữỰự",
      "v" => "VvṼṽṾṿ",
      "w" => "WwŴŵẀẁẂẄẅẇẈẉẘ",
      "x" => "XxẊẋẌẍ",
      "y" => "YÝýÿŶŷŸȲȳẎẏẙỲỳỴỵỶỷỸỹ",
      "z" => "ZzŹźŻżŽžẐẑẒẓẔẕƵƶ"
    }
  end

  def self.forward_hash
    @forward_hash ||= {}
    if @forward_hash.empty?
      backward_hash.keys.each do |ascii_char|
        backward_hash[ascii_char].unpack("U#{backward_hash[ascii_char].size}").each do |utf8_char|
          @forward_hash[utf8_char] = ascii_char
        end
      end
    end
    @forward_hash
  end

  def random(length = 40, *args)
    chars = []
    chars += ("a".."z").to_a if args.empty? || args.include?(:lowercase)
    chars += ("A".."Z").to_a if args.empty? || args.include?(:uppercase)
    chars += ("0".."9").to_a if args.empty? || args.include?(:digits)
    return nil if chars.empty?
    Array.new(length) { chars.rand }.join
  end

  def ascii
    a = self.unpack("U#{self.size}")
    a.collect { |utf8_char|
      utf8_char < 128 ? utf8_char.chr : String.forward_hash[utf8_char]
    }.join.downcase
  end

  def chunk(count = 4)
    self.reverse.scan(%r{.{1,#{count}}}).join(' ').reverse
  end

  def to_hash_from_story
    self.split(" and ").inject({}){ |hash_so_far, key_value|
      key, value =
      key_value.split(":").map{ |v| v.strip}
      hash_so_far.merge(key.downcase => value.gsub("'",""))
    }
  end

  def to_number
    n = 0
    each_byte { |b| n = n << 8; n += b }
    n
  end

  def from_hex
    split.collect { |c| c.to_i(16).chr }.join
  end

  def to_hex
    hex = ''
    each_byte { |b| hex << sprintf('%02x ' % b) }
    hex.strip!
    hex
  end

  def to_normalized_phone_number
    number = scan(/\d+/).join
    number = "4219#{$1}" if number =~ /^09(\d+)/
    number
  end
end
