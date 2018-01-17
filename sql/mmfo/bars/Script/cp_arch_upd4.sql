declare
  l_date1 date := to_date('28122017','DDMMYYYY');
begin
  bc.go('300465');

  --310 | Списання безнадійної заборгованості за рахунок резерву по акціях "Зарожанск.цукр.завод"зг.ПП №1086 від 15.12.17р.та службової звписки №55/4-13/1263 від 27.12.17
  begin
    savepoint p310;
    insert into cp_payments(cp_ref, op_ref)
    values (10946304501, 121764684501);
    INSERT into cp_arch (REF,ID,DAT_UG,DAT_OPL,DAT_ROZ,N,SUMB,STR_REF,OP,ref_main) 
    values (121764684501,310,l_date1,l_date1,l_date1,26075000,26075000,'121764684501',20,10946304501);  

    for k in (select acc,ref from cp_deal 
              where ref in (10946304501))
    loop
      update int_accn set apl_dat=l_date1 where id=0 and acc=k.acc;
    end loop;    

    update cp_deal set active = -1, dazs =  l_date1 where ref =  10946304501;
    dbms_output.put_line('cp_arch_upd4: в архів по ЦП 310 - OK');
    logger.error('cp_arch_upd4: в архів по ЦП 310 - OK ');
    commit;

  exception 
    when others then
      dbms_output.put_line('cp_arch_upd4: Не зміг внести в архів по ЦП 310 '||sqlerrm);
      logger.error('cp_arch_upd4: Не зміг внести в архів по ЦП 310 '||sqlerrm);
      rollback to p310;
  end; 


  --312 | Спис.безнад.заборг.за рах.резерву по акціях ВАТ "Мактекс" зг.Пост.правління №1086 від 15.12.17р.та службової звписки №55/4-13/1263 від 27.12.17р.
  begin
    savepoint p312;
    insert into cp_payments(cp_ref, op_ref)
    values (10946304701, 121764893901);
    INSERT into cp_arch (REF,ID,DAT_UG,DAT_OPL,DAT_ROZ,N,SUMB,STR_REF,OP,ref_main) 
    values (121764893901,312,l_date1,l_date1,l_date1,202541875,202541875,'121764893901',20,10946304701);  

    for k in (select acc,ref from cp_deal 
              where ref in (10946304701))
    loop
      update int_accn set apl_dat=l_date1 where id=0 and acc=k.acc;
    end loop;    

    update cp_deal set active = -1, dazs =  l_date1 where ref =  10946304701;
    dbms_output.put_line('cp_arch_upd4: в архів по ЦП 312 - OK');
    logger.error('cp_arch_upd4: в архів по ЦП 312 - OK ');
    commit;

  exception 
    when others then
      dbms_output.put_line('cp_arch_upd4: Не зміг внести в архів по ЦП 312 '||sqlerrm);
      logger.error('cp_arch_upd4: Не зміг внести в архів по ЦП 312 '||sqlerrm);
      rollback to p312;
  end; 


  --313 | Спис.безнадійної заборгованості за рахунок резерву по акціях "Камінь Богуславщини"акц зг.ПП №1086 від 15.12.17р.та службової звписки №55/4-13/1263 від 27.12.17р
  begin
    savepoint p313;
    insert into cp_payments(cp_ref, op_ref)
    values (10946304801, 121764723401);
    INSERT into cp_arch (REF,ID,DAT_UG,DAT_OPL,DAT_ROZ,N,SUMB,STR_REF,OP,ref_main) 
    values (121764723401,313,l_date1,l_date1,l_date1,53115000,53115000,'121764723401',20,10946304801);  

    for k in (select acc,ref from cp_deal 
              where ref in (10946304801))
    loop
      update int_accn set apl_dat=l_date1 where id=0 and acc=k.acc;
    end loop;    

    update cp_deal set active = -1, dazs =  l_date1 where ref =  10946304801;
    dbms_output.put_line('cp_arch_upd4: в архів по ЦП 313 - OK');
    logger.error('cp_arch_upd4: в архів по ЦП 313 - OK ');
    commit;

  exception 
    when others then
      dbms_output.put_line('cp_arch_upd4: Не зміг внести в архів по ЦП 313 '||sqlerrm);
      logger.error('cp_arch_upd4: Не зміг внести в архів по ЦП 313 '||sqlerrm);
      rollback to p313;
  end; 


  --314 | Списання безнадійної заборгованості за рахунок резерву по акціях СМП "Карбід" зг.ПП №1086 від 15.12.17р. та службової звписки №55/4-13/1263 від 27.12.17р.
  begin
    savepoint p314;
    insert into cp_payments(cp_ref, op_ref)
    values (10946304901, 121764617701);
    INSERT into cp_arch (REF,ID,DAT_UG,DAT_OPL,DAT_ROZ,N,SUMB,STR_REF,OP,ref_main) 
    values (121764617701,314,l_date1,l_date1,l_date1,600000,600000,'121764617701',20,10946304901);  

    for k in (select acc,ref from cp_deal 
              where ref in (10946304901))
    loop
      update int_accn set apl_dat=l_date1 where id=0 and acc=k.acc;
    end loop;    

    update cp_deal set active = -1, dazs =  l_date1 where ref =  10946304901;
    dbms_output.put_line('cp_arch_upd4: в архів по ЦП 314 - OK');
    logger.error('cp_arch_upd4: в архів по ЦП 314 - OK ');
    commit;

  exception 
    when others then
      dbms_output.put_line('cp_arch_upd4: Не зміг внести в архів по ЦП 314 '||sqlerrm);
      logger.error('cp_arch_upd4: Не зміг внести в архів по ЦП 314 '||sqlerrm);
      rollback to p314;
  end; 

  --319 | Списання безнадійної заборгованості за рахунок резерву по акціях ВАТ "Горловський РМЗ" зг.ПП №1086 від 15.12.17р.та службової звписки №55/4-13/1263 від 27.12.17
  begin
    savepoint p319;
    insert into cp_payments(cp_ref, op_ref)
    values (10946305401, 121764649301);
    INSERT into cp_arch (REF,ID,DAT_UG,DAT_OPL,DAT_ROZ,N,SUMB,STR_REF,OP,ref_main) 
    values (121764649301,319,l_date1,l_date1,l_date1,9900225,9900225,'121764649301',20,10946305401);  

    for k in (select acc,ref from cp_deal 
              where ref in (10946305401))
    loop
      update int_accn set apl_dat=l_date1 where id=0 and acc=k.acc;
    end loop;    

    update cp_deal set active = -1, dazs =  l_date1 where ref =  10946305401;
    dbms_output.put_line('cp_arch_upd4: в архів по ЦП 319 - OK');
    logger.error('cp_arch_upd4: в архів по ЦП 319 - OK ');
    commit;

  exception 
    when others then
      dbms_output.put_line('cp_arch_upd4: Не зміг внести в архів по ЦП 319 '||sqlerrm);
      logger.error('cp_arch_upd4: Не зміг внести в архів по ЦП 319 '||sqlerrm);
      rollback to p319;
  end; 

  --307 | Спис.безнад.заборг.за рах.резерву по акціях ВАТ Племзавод "Олександрівський" зг.ПП №1086 від 15.12.17р.та службової звписки №55/4-13/1263 від 27.12.17р.
  begin
    savepoint p307;
    insert into cp_payments(cp_ref, op_ref)
    values (10946351901, 121764826401);
    INSERT into cp_arch (REF,ID,DAT_UG,DAT_OPL,DAT_ROZ,N,SUMB,STR_REF,OP,ref_main) 
    values (121764826401,319,l_date1,l_date1,l_date1,123450525,123450525,'121764826401',20,10946351901);  

    for k in (select acc,ref from cp_deal 
              where ref in (10946351901))
    loop
      update int_accn set apl_dat=l_date1 where id=0 and acc=k.acc;
    end loop;    

    update cp_deal set active = -1, dazs =  l_date1 where ref =  10946351901;
    dbms_output.put_line('cp_arch_upd4: в архів по ЦП 307 - OK');
    logger.error('cp_arch_upd4: в архів по ЦП 307 - OK ');
    commit;

  exception 
    when others then
      dbms_output.put_line('cp_arch_upd4: Не зміг внести в архів по ЦП 307 '||sqlerrm);
      logger.error('cp_arch_upd4: Не зміг внести в архів по ЦП 307 '||sqlerrm);
      rollback to p307;
  end; 

  
  commit;
  dbms_output.put_line('cp_arch_upd4:  OK ');
  logger.info('cp_arch_upd4:  OK ');  
  bc.home;  
  exception
    when others then
      dbms_output.put_line('cp_arch_upd4:  Щось пішло не так '||sqlerrm);
      logger.error('cp_arch_upd4:  Щось пішло не так '||sqlerrm);      
      rollback;
      bc.home;
end;  
/
