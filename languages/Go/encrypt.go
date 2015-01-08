//encrypt.go
package main

import (
	"os"
	"io/ioutil"
	"bytes"
	"encoding/hex"
)

func main() {
	message := readStdin()
	hexKey	:= NewHexKey(readKeyArg())

	var cryptbuf bytes.Buffer

	for i := range message {
		mask := hexKey.nextByte()
		char := message[i] ^ mask
		cryptbuf.WriteByte(char)
	}

	out := hex.EncodeToString(cryptbuf.Bytes())
	os.Stdout.Write([]byte(out))
}

func readStdin() []byte {
	message, err := ioutil.ReadAll(os.Stdin)
	if err != nil {
		panic("Couldn't read STDIN, exiting.")
	}
	return message
}

func readKeyArg() string {
	if len(os.Args) < 2 {
		panic("Invalid number of arguments")
	}
	return os.Args[1]
}

type HexKey struct {
	Key	string
	Index	int
}

func NewHexKey(key string) *HexKey {
	return &HexKey{key, 0}
}

func (key *HexKey) nextByte() byte {
	var nextByteBuf bytes.Buffer

	nextByteBuf.WriteByte(key.Key[key.Index])
	key.Index = (key.Index + 1) % len(key.Key)

	nextByteBuf.WriteByte(key.Key[key.Index])
	key.Index = (key.Index + 1) % len(key.Key)

	mask, _ := hex.DecodeString(nextByteBuf.String())
	return mask[0]
}
