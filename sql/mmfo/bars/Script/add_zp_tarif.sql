begin
  insert into bars.zp_tarif (kod, kv, kf) values (435,980,'300465');
exception when others then  
  if sqlcode = -00001 then 
    null;   
  else 
    raise; 
  end if;   
end;
/
commit;

begin
  insert into bars.zp_tarif (kod, kv, kf) values (435,980,'322669');
exception when others then  
  if sqlcode = -00001 then 
    null;   
  else 
    raise; 
  end if;   
end;
/
commit;

begin
  insert into bars.zp_tarif (kod, kv, kf) values (435,980,'304665');
exception when others then  
  if sqlcode = -00001 then 
    null;   
  else 
    raise; 
  end if;   
end;
/
commit;

begin
  insert into bars.zp_tarif (kod, kv, kf) values (435,980,'335106');
exception when others then  
  if sqlcode = -00001 then 
    null;   
  else 
    raise; 
  end if;   
end;
/
commit;

begin
  insert into bars.zp_tarif (kod, kv, kf) values (435,980,'351823');
exception when others then  
  if sqlcode = -00001 then 
    null;   
  else 
    raise; 
  end if;   
end;
/
commit;

begin
  insert into bars.zp_tarif (kod, kv, kf) values (435,980,'352457');
exception when others then  
  if sqlcode = -00001 then 
    null;   
  else 
    raise; 
  end if;   
end;
/
commit;

begin
  insert into bars.zp_tarif (kod, kv, kf) values (435,980,'353553');
exception when others then  
  if sqlcode = -00001 then 
    null;   
  else 
    raise; 
  end if;   
end;
/
commit;
