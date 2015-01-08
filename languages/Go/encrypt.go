//encrypt.go
package main

import (
	"os"
	"io/ioutil"
	"bytes"
	"encoding/hex"
)

var (
	message	[]byte
	key	string
	err	error
)

func init() {
	message, err = ioutil.ReadAll(os.Stdin)
	if err != nil {
		panic("Couldn't read STDIN, exiting.")
	}

	if len(os.Args) < 2 {
		panic("Invalid number of arguments")
	}
	key = os.Args[1]
}

func main() {
	key_index := 0

	var cryptbuf bytes.Buffer

	for i := range message {
		// Get next mask
		var maskbuf bytes.Buffer
		maskbuf.WriteByte(key[key_index])
		key_index = (key_index + 1) % len(key)
		maskbuf.WriteByte(key[key_index])
		key_index = (key_index + 1) % len(key)

		mask, _ := hex.DecodeString(maskbuf.String())

		// Encrypt character
		char := message[i] ^ mask[0]
		cryptbuf.WriteByte(char)
	}

	out := hex.EncodeToString(cryptbuf.Bytes())
	os.Stdout.Write([]byte(out))
}
