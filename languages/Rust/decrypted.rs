pub struct Decrypted {
  pub value: String
}

impl Decrypted {
  pub fn add_byte(&mut self, byte: u8) {
    self.push(byte.to_ascii().to_string());
  }

  fn push(&mut self, segment: String) {
    self.value.push_str(segment.as_slice());
  }
}
