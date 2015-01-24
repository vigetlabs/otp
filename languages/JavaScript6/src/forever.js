export default function* forever (list, i=0) {
  let length = list.length

  while (true) {
    yield list[i++ % length]
  }
}
