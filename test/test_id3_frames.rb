require_relative 'test_helper'
include Mutagen::ID3::ParentFrames
include Mutagen::ID3::Frames

class ParentFrameSanityChecks < MiniTest::Test
  def test_text_frame
     assert_kind_of TextFrame, TextFrame.new(text:'text')
  end

  def test_url_frame
    assert_kind_of UrlFrame, UrlFrame.new('url')
  end

  def test_numeric_text_frame
    assert_kind_of NumericTextFrame, NumericTextFrame.new(text:'1')
  end

  def test_numeric_part_text_frame
    assert_kind_of NumericPartTextFrame, NumericPartTextFrame.new(text:'1/2')
  end

  def test_multi_text_frame
    assert_kind_of TextFrame, TextFrame.new(text:['a','b'])
  end
end

class FrameSanityChecker < MiniTest::Test
  def test_WXXX
    assert_kind_of WXXX, WXXX.new(url:'durl')
  end

  def test_TXXX
    assert_kind_of TXXX, TXXX.new(desc:'d', text:'text')
  end

  # def test_22_uses_direct_ints
  #   data = "TT1\x00\x00\x83\x00" + ("123456789abcdef" * 16)
  #   tag = _22._ID3__read_frames(data, Frames_2_2).to_a[0]
  #   assert_equal data[7...7+0x82], tag.text[0]
  # end

  # def test_frame_too_small
  #   assert_equal [], _24._ID3__read_frames('012345678', Frames).to_a
  #   assert_equal [], _23._ID3__read_frames('012345678', Frames).to_a
  #   assert_equal [], _22._ID3__read_frames('01234', Frames_2_2).to_a
  #   assert_equal [], _22._ID3__read_frames('TT1'+"\x00"*3, Frames_2_2).to_a
  # end

  # def test_unknown_22_frame
  #   data = "XYZ\x00\x00\x01\x00"
  #   assert_equal [data], _22._ID3__read_frames(data, {}).to_a
  # end
  #
  # def test_zlib_latin1
  #   tag = TPE1.from_data(_24, 0x9, "\x00\x00\x00\x0f""x\x9cc(\xc9\xc8,V\x00\xa2D\xfd\x92\xd4\xe2\x12\x00&\x7f\x05%")
  #   assert_equal 0, tag.encoding
  #   assert_equal ['this is a/test'], tag
  # end

  # def test_datalen_but_not_compressed
  # def test_utf8
  # def test_zlib_utf16
  # def test_load_write
  # def test_22_to_24

  def test_single_TXYZ
    assert_equal TIT2.new(text:'a').hash_key, TIT2.new(text:'b').hash_key
  end

  # def test_multi_TXXX
  #   assert_equal TXXX.new(text:'a').hash_key, TXXX.new(text:'b').hash_key
  #   refute_equal TXXX.new(desc:'a').hash_key, TXXX.new(desc:'b').hash_key
  # end
end

class TestTextFrame < MiniTest::Test
  def test_list_iface
    frame = TextFrame.new
    frame << 'a'
    frame.push *%w(b c)
    assert_equal %w(a b c), frame.text
  end

  def test_list_iter
    frame = TextFrame.new
    frame.push *%w(a b c)
    assert_equal %w(a b c), frame.map {|c| c}
  end
end

class TestGenres < MiniTest::Test
  TCON = TCON
  GENRES = Mutagen::Constants::GENRES

  def _g(s)
    TCON.new(text:s).genres
  end

  def test_empty
    assert_equal [], _g('')
  end

  # def test_num
  #   GENRES.each_with_index do |genre, i|
  #     assert_equal [genre], _g("(%02d)" % i)
  #   end
  # end
end