  begin
    execute immediate 'drop trigger TR_SQNC_CP_ZAL';
  exception
    when others then
      if sqlcode = -4080 then
        null;
      else
        raise;
      end if;
  end;
/

  begin
    execute immediate 'drop function f_get_from_accountspv';
  exception
    when others then
      if sqlcode = -4043 then
        null;
      else
        raise;
      end if;
  end;
/

  begin
    execute immediate 'drop function f_get_from_accountspv_dat2';
  exception
    when others then
      if sqlcode = -4043 then
        null;
      else
        raise;
      end if;
  end;
/

  begin
    execute immediate 'drop view CP_V_ZAL_ACC_1';
  exception
    when others then
      if sqlcode = -942 then
        null;
      else
        raise;
      end if;
  end;
/



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

begin   
 execute immediate 'alter table CP_ZAL rename column datz to DATZ_FROM';
exception when others then
  if  sqlcode=-957 then null; else raise; end if;
 end;
/


begin   
 execute immediate 'alter table CP_ZAL add DATZ_TO date';
exception when others then
  if  sqlcode=-1430  then null; else raise; end if;
 end;
/



declare

  L_CP_ZAL number;

  l_acc           cp_deal.acc%type; 
  l_cnt           pls_integer := 0;
  l_id_cp_zal     cp_zal.id_cp_zal%type;
  l_rnk           cp_zal.rnk%type;
begin
  execute immediate 'ALTER TABLE CP_ZAL DISABLE ALL TRIGGERS';
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

  /*трансформуємо наявну історію в нову 
    так як потрібно тепер вести в розрізі rnk
  */
  select count(*) 
  into l_cnt
  from (select ref, count(*) from cp_zal group by ref having count(*) > 1);
  
  if l_cnt > 0 then --у нас проблеми хьюстон
    dbms_output.put_line('Не можу відпрацювати скрипт по зміні принципу історізації в заставних ЦП табл. cp_zal. Потрібно ручне втручання');
    bars_audit.error('Не можу відпрацювати скрипт по зміні принципу історізації в заставних ЦП табл. cp_zal. Потрібно ручне втручання');
    else
      insert into cp_zal_old(ref, id, kolz, datz,      rnk, back_date)   
                      select ref, id, kolz, datz_from, rnk, sysdate from cp_zal;                       
    
      l_cnt := 0;
      for cur in (select a.acc, a.dat1, a.dat2, a.val, c.ref, c.id from ACCOUNTSP a, cp_deal c 
                  where a.acc = c.acc 
                    and a.parid = 85 
                  order by a.acc, a.dat2)
      loop
        if l_acc = cur.acc then
          l_cnt := l_cnt + 1;
          else 
            l_cnt := 0;
            l_rnk := null;
        end if;  
        l_acc := cur.acc;
        if l_cnt = 0 then
          begin
            select id_cp_zal 
            into l_id_cp_zal
            from cp_zal where ref = cur.ref;
            
            update cp_zal 
            set kolz = to_number(cur.val),
                datz_from =  cur.dat1,
                datz_to   =  cur.dat2
            where id_cp_zal = l_id_cp_zal
            returning rnk into l_rnk; --вважається що то була історія по цьому RNK що вони встигли вже ввести
            
            exception 
              when no_data_found then
                insert into cp_zal(ref,
                                   id,
                                   kolz,
                                   datz_from,
                                   id_cp_zal,
                                   rnk,
                                   datz_to)
                 values (cur.ref, cur.id, to_number(cur.val), cur.dat1,  bars_sqnc.get_nextval('S_CP_ZAL'), null,  cur.dat2);                  
          end;  
          
                   
         else
                insert into cp_zal(ref,
                                   id,
                                   kolz,
                                   datz_from,
                                   id_cp_zal,
                                   rnk,
                                   datz_to)
                 values (cur.ref, cur.id, to_number(cur.val), cur.dat1,  bars_sqnc.get_nextval('S_CP_ZAL'), l_rnk,  cur.dat2);          
        end if;  
      end loop;   
    delete from cp_zal where datz_from is null;
  end if;  


  commit;
  bc.home;
  execute immediate 'ALTER TABLE CP_ZAL ENABLE ALL TRIGGERS';
  exception when others  then
     bc.home;
     execute immediate 'ALTER TABLE CP_ZAL ENABLE ALL TRIGGERS';
     raise;
end;
/

