function encrypted = encrypt( key, message )
 key = circshift([key key],1, 2) % Curse you matlab for your 1-indexed arrays
 encrypted = lower(strjoin(arrayfun(@(c,k)dec2hex(bitxor(int16(c),k)),message,arrayfun(@(i)hex2dec([key(mod((i-1)*2,numel(key))+2),key(mod(i*2,numel(key))+1)]),1:numel(message)),'un',0),''))
end
