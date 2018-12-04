prompt PARAMS$GLOBAL

begin
  insert into PARAMS$GLOBAL ( PAR, VAL, COMM, SRV_FLAG )
  values ('CRYPTO_USE_VEGA2', '1', 'Робота з підписом типу VEGA2', 0);
exception
  when dup_val_on_index then
    update params$global set val = '1' where par = 'CRYPTO_USE_VEGA2'; 
end;
/

begin
  insert into PARAMS$GLOBAL ( PAR, VAL, COMM, SRV_FLAG )
  values ('CRYPTO_CA_KEY', 'C817873B5039886D302F96639F6CF46F670A39880326F733DDC2C6E3EB2B392C', 'Ключ АЦСК, яким видано сертифікати', 0);
exception
  when dup_val_on_index then
    update params$global set val = 'C817873B5039886D302F96639F6CF46F670A39880326F733DDC2C6E3EB2B392C' where par = 'CRYPTO_CA_KEY'; 
end;
/
