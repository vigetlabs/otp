function decrypted = decrypt( key, message )
 key = circshift([key key],1, 2) % Curse you matlab for your 1-indexed arrays
 decrypted = [char(bitxor(arrayfun(@(i)hex2dec([key(mod((i-1)*2,numel(key))+2),key(mod(i*2,numel(key))+1)]),1:numel(arrayfun(@(i)hex2dec(strcat(message(i*2-1),message(i*2))),1:(numel(message)/2),'un',0))),cell2mat(arrayfun(@(i)hex2dec(strcat(message(i*2-1),message(i*2))),1:(numel(message)/2),'un',0))))]
end
