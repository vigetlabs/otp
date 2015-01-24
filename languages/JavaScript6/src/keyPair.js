import forever from './forever'

export default function* keyPair (key) {
  let mask = forever(key)

  while (true) {
    yield parseInt(mask.next().value + mask.next().value, 16)
  }
}
