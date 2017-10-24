declare
  l_date1 date := to_date('24072017','DDMMYYYY');
  l_date2 date := to_date('16082017','DDMMYYYY');
begin
  bc.go('300465');
  --498 UA4000185557
  begin
    insert into cp_payments(cp_ref, op_ref)
    values (23573543301, 97666886901);
    INSERT into cp_arch (REF,ID,DAT_UG,DAT_OPL,DAT_ROZ,N,SUMB,STR_REF,OP,ref_main) 
    values (97666886901,498,l_date1,l_date1,l_date1,426180000,426180000,'97666886901',22,23573543301);  

    for k in (select acc,ref from cp_deal 
              where ref in (23573543301))
    loop
      update int_accn set apl_dat=l_date1 where id=0 and acc=k.acc;
    end loop;    

  exception 
    when others then
      dbms_output.put_line('cp_arch_upd3: Не зміг внести в архів по ЦП 498 UA4000185557 '||sqlerrm);
      logger.error('cp_arch_upd3: Не зміг внести в архів по ЦП 498 UA4000185557 '||sqlerrm);
      raise;
  end; 

  
  --519 UA4000186159
  begin
    insert into cp_payments(cp_ref, op_ref)
    values (24219298301, 100628538501);
    INSERT into cp_arch (REF,ID,DAT_UG,DAT_OPL,DAT_ROZ,N,SUMB,STR_REF,OP,ref_main) 
    values (100628538501,519,l_date2,l_date2,l_date2,46730000,46730000,'100628538501',22,24219298301);  
  exception 
    when others then
      dbms_output.put_line('cp_arch_upd3: Не зміг внести в архів по ЦП 519 UA4000186159 РЕФ 100628538501 '||sqlerrm);
      logger.error('cp_arch_upd3: Не зміг внести в архів по ЦП 519 UA4000186159 РЕФ 100628538501 '||sqlerrm);
      raise;
  end; 

  begin
    insert into cp_payments(cp_ref, op_ref)
    values (24219299401, 100628575201);
    INSERT into cp_arch (REF,ID,DAT_UG,DAT_OPL,DAT_ROZ,N,SUMB,STR_REF,OP,ref_main) 
    values (100628575201,519,l_date2,l_date2,l_date2,46730000,46730000,'100628575201',22,24219299401);  
  exception 
    when others then
      dbms_output.put_line('cp_arch_upd3: Не зміг внести в архів по ЦП 519 UA4000186159 РЕФ 100628575201 '||sqlerrm);
      logger.error('cp_arch_upd3: Не зміг внести в архів по ЦП 519 UA4000186159 РЕФ 100628575201 '||sqlerrm);
      raise;
  end; 

  begin
    insert into cp_payments(cp_ref, op_ref)
    values (24219303401, 100628622901);
    INSERT into cp_arch (REF,ID,DAT_UG,DAT_OPL,DAT_ROZ,N,SUMB,STR_REF,OP,ref_main) 
    values (100628622901,519,l_date2,l_date2,l_date2,46730000,46730000,'100628622901',22,24219303401);  
  exception 
    when others then
      dbms_output.put_line('cp_arch_upd3: Не зміг внести в архів по ЦП 519 UA4000186159 РЕФ 100628622901 '||sqlerrm);
      logger.error('cp_arch_upd3: Не зміг внести в архів по ЦП 519 UA4000186159 РЕФ 100628622901 '||sqlerrm);
      raise;
  end; 

  begin
    insert into cp_payments(cp_ref, op_ref)
    values (24219308601, 100628714001);
    INSERT into cp_arch (REF,ID,DAT_UG,DAT_OPL,DAT_ROZ,N,SUMB,STR_REF,OP,ref_main) 
    values (100628714001,519,l_date2,l_date2,l_date2,46710000,46710000,'100628714001',22,24219308601);  
  exception 
    when others then
      dbms_output.put_line('cp_arch_upd3: Не зміг внести в архів по ЦП 519 UA4000186159 РЕФ 100628714001 '||sqlerrm);
      logger.error('cp_arch_upd3: Не зміг внести в архів по ЦП 519 UA4000186159 РЕФ 100628714001 '||sqlerrm);
      raise;
  end; 

   
    
  for k in (select acc,ref from cp_deal 
            where ref in (24219298301,24219299401,24219303401,24219308601))
  loop
    update int_accn set apl_dat=l_date2 where id=0 and acc=k.acc;
  end loop;    

  commit;
  dbms_output.put_line('cp_arch_upd3:  OK ');
  logger.info('cp_arch_upd3:  OK ');  
  bc.home;  
  exception
    when others then
      dbms_output.put_line('cp_arch_upd3:  Щось пішло не так '||sqlerrm);
      logger.error('cp_arch_upd3:  Щось пішло не так '||sqlerrm);      
      rollback;
      bc.home;
end;  
/
