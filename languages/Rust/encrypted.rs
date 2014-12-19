use serialize::hex::ToHex;

pub struct Encrypted {
  pub value: String
}

impl Encrypted {
  pub fn add_byte(&mut self, byte: u8) {
    let hex = vec![byte].to_hex();
    self.push(hex);
  }

  fn push(&mut self, segment: String) {
    self.value.push_str(segment.as_slice());
  }
}
