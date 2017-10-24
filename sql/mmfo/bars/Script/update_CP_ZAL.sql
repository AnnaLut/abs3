  begin
    execute immediate 'alter table CP_ZAL add id_cp_zal number';
  exception
    when others then
      if sqlcode = -1430 then
        null;
      else
        raise;
      end if;
  end;
/


declare

  L_CP_ZAL number;

begin

  bc.go(300465);
  for rec in (select cz.rowid
                from cp_zal cz
               where cz.id_cp_zal is null /*and cz.ref = 92955631101*/
              )  
   loop
    L_CP_ZAL := bars_sqnc.get_nextval('S_CP_ZAL');
    
    update cp_zal cz
       set cz.id_cp_zal = L_CP_ZAL
     where cz.rowid = rec.rowid;
  
  end loop;
  commit;
  bc.home;
  exception when others  then
     bc.home;
end;
/