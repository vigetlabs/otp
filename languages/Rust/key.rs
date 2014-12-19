use std::mem;
use serialize::hex::FromHex;

pub struct Key {
  pub value: String,
  pub index: uint,
}

impl Key {
  fn byte_for_chars(&self, char_0: u8, char_1: u8) -> u8 {
    let k_string = format!("{}{}", char_0.to_ascii(), char_1.to_ascii());
    let byte_vec = k_string.from_hex().ok().expect("bad key value");
    byte_vec[0]
  }

  pub fn next(&mut self) -> u8 {
    let key_char_bytes = self.value.as_bytes();

    let first_char_index = (self.index * 2) % key_char_bytes.len();
    let second_char_index = ((self.index * 2) + 1) % key_char_bytes.len();

    let next_index = self.index + 1;
    mem::replace(&mut self.index, next_index);

    self.byte_for_chars(key_char_bytes[first_char_index], key_char_bytes[second_char_index])
  }
}
