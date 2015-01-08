package main

import (
	"os"
	"io/ioutil"
	"bytes"
	"encoding/hex"
	"otp/languages/Go/key"
)

func main() {
	message := readStdin()
	hexKey	:= key.NewHexKey(readKeyArg())

	var cryptbuf bytes.Buffer

	for i := range message {
		mask := hexKey.NextByte()
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
