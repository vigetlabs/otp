package key

import (
	"bytes"
	"encoding/hex"
)

type HexKey struct {
	key	string
	index	int
}

func NewHexKey(key string) *HexKey {
	return &HexKey{key, 0}
}

func (k *HexKey) NextByte() byte {
	var nextByteBuf bytes.Buffer

	nextByteBuf.WriteByte(k.key[k.index])
	k.index = (k.index + 1) % len(k.key)

	nextByteBuf.WriteByte(k.key[k.index])
	k.index = (k.index + 1) % len(k.key)

	mask, _ := hex.DecodeString(nextByteBuf.String())
	return mask[0]
}
