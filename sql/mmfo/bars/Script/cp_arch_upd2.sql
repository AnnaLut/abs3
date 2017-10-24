declare
  l_date date := to_date('04072017','DDMMYYYY');
begin
  bc.go('300465');
  --427 UA4000178388
  begin
    insert into cp_payments(cp_ref, op_ref)
    values (70657222501, 95643533001);
    INSERT into cp_arch (REF,ID,DAT_UG,DAT_OPL,DAT_ROZ,R,STR_REF,OP,ref_main) 
    values (95643533001,427,l_date,l_date,l_date,498600000,'95643533001',4,70657222501);
  exception 
    when others then
      dbms_output.put_line('cp_arch_upd2: Не зміг внести в архів по ЦП 427 UA4000178388 '||sqlerrm);
      logger.error('cp_arch_upd2: Не зміг внести в архів по ЦП 427 UA4000178388 '||sqlerrm);
  end;
  
  --480 UA4000185151
  begin
    insert into cp_payments(cp_ref, op_ref)
    values (23045636001, 95654108001);
    INSERT into cp_arch (REF,ID,DAT_UG,DAT_OPL,DAT_ROZ,N,SUMB,STR_REF,OP,ref_main) 
    values (95654108001,480,l_date,l_date,l_date,3188150000,3188150000,'95654108001',22,23045636001);  
  exception 
    when others then
      dbms_output.put_line('cp_arch_upd2: Не зміг внести в архів по ЦП 480 UA4000185151 РЕФ 95654108001 '||sqlerrm);
      logger.error('cp_arch_upd2: Не зміг внести в архів по ЦП 480 UA4000185151 РЕФ 95654108001 '||sqlerrm);
  end; 
   
  begin  
    insert into cp_payments(cp_ref, op_ref)
    values (25012823101, 95654123501);
    INSERT into cp_arch (REF,ID,DAT_UG,DAT_OPL,DAT_ROZ,N,SUMB,STR_REF,OP,ref_main) 
    values (95654123501,480,l_date,l_date,l_date,250000000,250000000,'95654123501',22,25012823101);  
  exception 
    when others then
      dbms_output.put_line('cp_arch_upd2: Не зміг внести в архів по ЦП 480 UA4000185151 РЕФ 95654123501 '||sqlerrm);
      logger.error('cp_arch_upd2: Не зміг внести в архів по ЦП 480 UA4000185151 РЕФ 95654123501 '||sqlerrm);
  end; 
    

  begin
    insert into cp_payments(cp_ref, op_ref)
    values (25013085201, 95654195801);
    INSERT into cp_arch (REF,ID,DAT_UG,DAT_OPL,DAT_ROZ,N,SUMB,STR_REF,OP,ref_main) 
    values (95654195801,480,l_date,l_date,l_date,250000000,250000000,'95654195801',22,25013085201);  
  exception 
    when others then
      dbms_output.put_line('cp_arch_upd2: Не зміг внести в архів по ЦП 480 UA4000185151 РЕФ 95654195801 '||sqlerrm);
      logger.error('cp_arch_upd2: Не зміг внести в архів по ЦП 480 UA4000185151 РЕФ 95654195801 '||sqlerrm);
  end; 
    
  
  begin
    insert into cp_payments(cp_ref, op_ref)
    values (25013095401, 95654212201);
    INSERT into cp_arch (REF,ID,DAT_UG,DAT_OPL,DAT_ROZ,N,SUMB,STR_REF,OP,ref_main) 
    values (95654212201,480,l_date,l_date,l_date,250000000,250000000,'95654212201',22,25013095401);  
  exception 
    when others then
      dbms_output.put_line('cp_arch_upd2: Не зміг внести в архів по ЦП 480 UA4000185151 РЕФ 95654212201 '||sqlerrm);
      logger.error('cp_arch_upd2: Не зміг внести в архів по ЦП 480 UA4000185151 РЕФ 95654212201 '||sqlerrm);
  end; 
    
  
  begin
    insert into cp_payments(cp_ref, op_ref)
    values (25013263501, 95654230901);
    INSERT into cp_arch (REF,ID,DAT_UG,DAT_OPL,DAT_ROZ,N,SUMB,STR_REF,OP,ref_main) 
    values (95654230901,480,l_date,l_date,l_date,250000000,250000000,'95654230901',22,25013263501);  
  exception 
    when others then
      dbms_output.put_line('cp_arch_upd2: Не зміг внести в архів по ЦП 480 UA4000185151 РЕФ 95654230901 '||sqlerrm);
      logger.error('cp_arch_upd2: Не зміг внести в архів по ЦП 480 UA4000185151 РЕФ 95654230901 '||sqlerrm);
  end; 
    
  for k in (select acc,ref from cp_deal 
            where ref in (25013263501,25013095401,25013085201,25012823101,23045636001,70657222501))
  loop
    update int_accn set apl_dat=l_date where id=0 and acc=k.acc;
  end loop;    

  commit;
  dbms_output.put_line('cp_arch_upd2:  OK ');
  logger.info('cp_arch_upd2:  OK ');  
  bc.home;  
  exception
    when others then
      dbms_output.put_line('cp_arch_upd2:  Щось пішло не так '||sqlerrm);
      logger.error('cp_arch_upd2:  Щось пішло не так '||sqlerrm);      
      bc.home;
end;  
/
