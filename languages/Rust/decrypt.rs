extern crate serialize;

use serialize::hex::FromHex;
use std::os;
use std::io;

mod key;
mod decrypted;

fn decrypt(encrypted_message: &str, key_str: &str) -> String {
  let mut key = key::Key { value: key_str.to_string(), index: 0u };
  let mut decrypted = decrypted::Decrypted { value: "".to_string() };

  for chars in encrypted_message.as_bytes().chunks(2) {
    let message_hex = format!("{}{}", chars[0].to_ascii(), chars[1].to_ascii());
    let message_byte_vec = message_hex.from_hex().ok().expect("bad encrypted message value");

    decrypted.add_byte(message_byte_vec[0].bitxor(key.next()))
  }

  decrypted.value
}

fn main() {
  let args = os::args();
  for line in io::stdin().lock().lines() {
    print!("{}", decrypt(line.unwrap().as_slice().trim(), args[1].as_slice()))
  }
}
