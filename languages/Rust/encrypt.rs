extern crate serialize;

use std::os;
use std::io;

mod key;
mod encrypted;

fn encrypt(message: &str, key_str: &str) -> String {
  let mut key = key::Key { value: key_str.to_string(), index: 0u };
  let mut encrypted = encrypted::Encrypted { value: "".to_string() };

  for message_byte in message.as_bytes().iter(){
    encrypted.add_byte(message_byte.bitxor(key.next()));
  }

  encrypted.value
}

fn main() {
  let args = os::args();
  for line in io::stdin().lock().lines() {
    print!("{}", encrypt(line.unwrap().as_slice().trim(), args[1].as_slice()))
  }
}
