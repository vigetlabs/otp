require 'minitest/autorun'
require 'open3'

class OtpTest < MiniTest::Test
  include Open3

  def run_program(*commands, &block)
    command = commands.map {|c| "#{ENV['LANGUAGE_PATH']}/#{c}" }.join(' | ')
    popen2(command, &block)
  end

  def test_encrypt_single_char_with_zero_key
    run_program('encrypt 0') do |stdin, stdout|
      stdin.print 'a'
      stdin.close

      # ascii 'a' is decimal 97 & hexadecimal 61
      assert_equal '61', stdout.read
    end
  end

  def test_encrypt_multiple_chars_with_zero_key
    run_program('encrypt 0') do |stdin, stdout|
      stdin.print 'aaa'
      stdin.close

      assert_equal '616161', stdout.read
    end
  end

  def test_decrypt_with_zero_key
    run_program('decrypt 0') do |stdin, stdout|
      stdin.print '61'
      stdin.close

      assert_equal 'a', stdout.read
    end
  end

  def test_encrypt_with_long_message_and_key
    run_program('encrypt deadbeef') do |stdin, stdout|
      stdin.print 'this is the secret message'
      stdin.close

      assert_equal 'aac5d79cfec4cdcfaac5dbcfadc8dd9dbbd99e82bbdecd8eb9c8', stdout.read
    end
  end

  def test_encrypt_then_decrypt
    run_program('encrypt deadbeef', 'decrypt deadbeef') do |stdin, stdout|
      message = 'this is the secret message'
      stdin.print message
      stdin.close

      assert_equal message, stdout.read
    end
  end

  def test_encrypt_then_decrypt_with_incorrect_key
    run_program('encrypt deadbeef', 'decrypt deadbeee') do |stdin, stdout|
      message = 'this is the secret message'
      stdin.print message
      stdin.close

      assert message != stdout.read
    end
  end
end
