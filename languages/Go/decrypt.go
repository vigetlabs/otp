//encrypt.go
package main

import (
	"os"
	"io/ioutil"
	"bytes"
	"encoding/hex"
)

var (
	text	[]byte
	key	string
	err	error
)

func init() {
	text, err = ioutil.ReadAll(os.Stdin)
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

	var outbuf bytes.Buffer

	for i := 0; i < len(text); i += 2 {
		//Cipher byte
		j := i + 2
		cipher, _ := hex.DecodeString(string(text[i:j]))

		//Mask byte
		var maskbuf bytes.Buffer

		maskbuf.WriteByte(key[key_index])
		key_index = (key_index + 1) % len(key)
		maskbuf.WriteByte(key[key_index])
		key_index = (key_index + 1) % len(key)

		mask, _ := hex.DecodeString(maskbuf.String())

		//Decoded byte
		outbuf.WriteByte(cipher[0] ^ mask[0])
	}

	os.Stdout.Write(outbuf.Bytes())
}
