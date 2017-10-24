declare
  l_id keytypes.id%type;
begin
  begin
    l_id := crypto_utl.create_keytype('Передача на оплату з ЦРКР','CRKR_TRANSFER');
    exception 
      when others then 
       if sqlcode = -1 then null; 
         else raise; 
       end if;       
  end;  
  begin
    crypto_utl.create_key(p_key_value  => 'TEST',
                          p_start_date => to_date('01.01.2017','DD.MM.YYYY'),
                          p_end_date   => to_date('31.12.2017','DD.MM.YYYY'),
                          p_code       => 'CRKR_TRANSFER');
    exception 
      when others then 
       if sqlcode = -20000 then null; 
         else raise; 
       end if;                             
  end;  
end;
/  