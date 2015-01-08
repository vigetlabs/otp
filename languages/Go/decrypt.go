package main

import (
	"os"
	"io/ioutil"
	"bytes"
	"encoding/hex"
	"otp/languages/Go/key"
)

func main() {
	cipher	:= readStdin()
	hexKey	:= key.NewHexKey(readKeyArg())

	var textBuf bytes.Buffer

	for i := 0; i < len(cipher); i += 2 {
		j := i + 2
		cipherByte, _ := hex.DecodeString(string(cipher[i:j]))

		mask := hexKey.NextByte()
		char := cipherByte[0] ^ mask
		textBuf.WriteByte(char)
	}

	os.Stdout.Write(textBuf.Bytes())
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
