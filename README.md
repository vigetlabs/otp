One-Time Pad (OTP)
==================

We're gonna write a pair of programs in your language of choice to simulate using a [one-time pad][otp] to encode and decode a message. The programs, `encrypt` and `decrypt`, will take a single argument, a hexadecimal string that represents the key, read in the plaintext (for `encrypt`) or ciphertext (for `decrypt`) from `STDIN`, and output the result on `STDOUT`.

[otp]: http://en.wikipedia.org/wiki/One-time_pad

A one-time pad works by bitwise `XOR`ing the message against the key, and then `XOR`ing the resulting ciphertext against the same key to retrieve the original message. It's called a 'one-time pad' because, if your adversary intercepts multiple messages encrypted with the same pad, it's easy to figure out the key. In real life, you'd want your key to be at least as long as the message you're encrypting, but for the purposes of this exercise, we'll just loop over the key as many times as necessary to encrypt the message.

So to encrypt, for each character in the message:

  * Convert the character to its [ASCII representation][ascii] (so 'a' becomes 97)
  * Pull off two characters from the key and convert them to a hex number (so '00' becomes 0, 'ff' becomes 255)
  * `XOR` the results of :point_up: and print out the resulting number in hex

[ascii]: http://en.wikipedia.org/wiki/ASCII#ASCII_printable_code_chart

Decrypting is similar:

  * Pull off two hex chars from the ciphertext & two from the key
  * Convert both pairs to numbers and `XOR` them
  * Convert the resulting number to an ASCII character and print it out

You'll call your programs like this (`-n` so that `echo` doesn't stick a newline after your message):

    $ echo -n 'secret message' | ./encrypt b33fd4d
    c05ab7a956896dde5aa7a8529a28
    $ echo -n c05ab7a956896dde5aa7a8529a28 | ./decrypt b33fd4d
    secret message
    $ echo -n 'secret message' | ./encrypt b33fd4d | ./decrypt b33fd4d
    secret message

The test suite should hopefully make things a little more clear. To start:

1. Create a directory based on the name of your implementation language (e.g. `languages/C`)
2. Create a simple `Rakefile` that has, at a minimum, a `build` task within your language's namespace (e.g. `C:build`).  You should check the environment and fail fast if dependencies aren't met.
3. Create your implementation and run `rake` from the project root.

### Example Rakefile

```ruby
namespace :C do
  task :check do
    `which cc`
    raise "Please ensure that you have a valid C compiler" unless $?.success?
  end

  task :build => :check
    path = File.dirname(__FILE__)
    `cd #{path}; make encrypt`
  end
end
```

* * *

### A quick note on bits, bytes, characters, and hex

I guess it's important to note that an ASCII character is stored as a single byte, which is to say 8 bits, or somewhere between 0 and 255. A hexadecimal digit represents 4 bits & and can have values between 0 and 15 (displayed as 'f'). Two hexadecimal digits together represent 8 bits or one byte.
