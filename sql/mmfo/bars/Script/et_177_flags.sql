
begin
update tts set flags='1100100001000000000000000011000000010000000000000000000000000000' where tt='177';
end;

/
COMMIT;


update tts set nlsk=null,nlsb=null where tt='177';

commit; 
