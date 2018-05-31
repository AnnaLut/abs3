prompt TRIGGER OFF
begin
execute immediate 'alter trigger TAIUD_BPKPARAMETERS_UPDATE disable';
execute immediate 'alter trigger TAIUD_ND_TXT_UPDATE disable';
execute immediate 'alter trigger TAIU_ACCOUNTSW_UPDATE disable';
execute immediate 'alter trigger TBIU_BPKPARAMETERS_CHECKS disable';
end;
/
prompt---1111111111111
begin
for m in (select kf from mv_kf)
  loop
    bc.go (m.kf);    
    insert into nd_txt
     (nd, tag, txt)
     select distinct dd.nd,'BUS_MOD',1 from cc_deal dd, nd_acc na,accounts a
      where dd.nd=na.nd and na.acc=a.acc and a.dazs is null
      and nbs in ('1500', '1502', '1510','1513','1520', '1521', '1522', '1524', '1211', '1212') and dd.SOS  <>  15
  and a.kf=m.kf
     and dd.nd not in( select nd from nd_txt where tag='BUS_MOD');
      end loop;
   COMMIT;
end; 
/
prompt---222222222222222
begin
for m in (select kf from mv_kf)
  loop
    bc.go (m.kf);
     insert into accountsw
     (acc, tag, value)
     select distinct  a.acc,'BUS_MOD',2 from  accounts a where a.nbs in ('3040', '3041','3042','3043','3044') and a.dazs is null
    and a.kf=m.kf
    and a.acc not in (select acc from accountsw where tag='BUS_MOD');
     end loop;
     COMMIT;
end;  
/

prompt --÷œ--3333333333333333333333333
  begin 
for k in (select kf from mv_kf )
  loop
    bc.go (k.kf);
    insert into cp_refw
     (ref,tag,value)  
    select distinct  cp.ref,'BUS_MOD',3 from cp_deal cp, accounts a where cp.acc=a.acc and cp.dazs is null and 
      substr(a.nls,1,4) in (1410, 1420, 1430, 1440, 1411, 1421)
    and cp.ref not in (select ref from cp_refw where tag='BUS_MOD');
    end loop;
    COMMIT;
end;  
/

prompt--÷œ--44444444444444444444444444
  begin 
for k in (select kf from mv_kf )
  loop
    bc.go (k.kf);
    insert into cp_refw
     (ref,tag,value)  
     select distinct cp.ref,'BUS_MOD',4 from cp_deal cp, accounts a where cp.acc=a.acc and cp.dazs is null and 
      substr(a.nls,1,4) in (1400, 1401, 1402, 3010, 3011, 3012, 3013, 3014)
      and cp.ref not in (select ref from cp_refw where tag='BUS_MOD');
      end loop;
    COMMIT;
end;  
/
prompt --÷œ--5555555555555555555555555555
  begin 
for k in (select kf from mv_kf )
  loop
    bc.go (k.kf);
    insert into cp_refw
     (ref,tag,value)  
       select distinct  cp.ref,'BUS_MOD',5 from cp_deal cp, accounts a where cp.acc=a.acc and cp.dazs is null and 
      substr(a.nls,1,4) in (1412, 1413, 1414, 1422, 1423, 1424, 3110, 3111, 3112, 3113, 3114, 3210, 3211, 3212, 3213, 3214, 3102, 3103, 3105)
      and cp.ref not in (select ref from cp_refw where tag='BUS_MOD');
      end loop;
     COMMIT;
end;  
/
prompt ‰Îˇ accp 
  begin 
for k in (select kf from mv_kf )
  loop
    bc.go (k.kf);
    insert into cp_refw
     (ref,tag,value)  
       select distinct  cp.ref,'BUS_MOD',5 from cp_deal cp, accounts a where cp.accp=a.acc and cp.dazs is null and 
      substr(a.nls,1,4) in (3102, 3103, 3105)
      and cp.ref not in (select ref from cp_refw where tag='BUS_MOD');
      end loop;
     COMMIT;
end;  
/

prompt---666666666666666666666666666
begin
for m in (select kf from mv_kf)
  loop
    bc.go (m.kf);    
    insert into nd_txt
     (nd, tag, txt)
    select distinct dd.nd,'BUS_MOD',6 from cc_deal dd, nd_acc na,accounts a where dd.nd=na.nd and na.acc=a.acc and a.dazs is null and dd.SOS <> 15
      and a.rnk in ( select cw.rnk from  customerw cw,customer c ,KL_K110 k1 where k1.K110=c.ved and cw.tag='BUSSL' and cw.value='1' and c.date_off is null 
      and cw.rnk=c.rnk and k1.k111 in('35'))
      and a.nbs in ('2020','2030','2060','2063','2071','2083','2103','2113','2123','2133')
    and dd.nd not in( select nd from nd_txt where tag='BUS_MOD');
      end loop;
   COMMIT;
end; 
/
prompt----777777777777777777777
begin
for m in (select kf from mv_kf)
  loop
    bc.go (m.kf);    
    insert into nd_txt
     (nd, tag, txt)
    select distinct dd.nd,'BUS_MOD',7 from cc_deal dd, nd_acc na,accounts a where dd.nd=na.nd and na.acc=a.acc and a.dazs is null and dd.SOS <> 15
      and a.rnk in (select cw.rnk from  customerw cw,customer c ,KL_K110 k1 where k1.K110=c.ved and cw.tag='BUSSL' and cw.value='1' and c.date_off is null 
      and cw.rnk=c.rnk and k1.k111 in('41','42','43','49','50','51','52'))
      and a.nbs in ('2020','2030','2060','2063','2071','2083','2103','2113','2123','2133')
       and dd.nd not in( select nd from nd_txt where tag='BUS_MOD');
      end loop;
   COMMIT;
end;
/
prompt ---88888888888888888
begin
for m in (select kf from mv_kf)
  loop
    bc.go (m.kf);    
    insert into nd_txt
     (nd, tag, txt)
    select distinct dd.nd,'BUS_MOD',8 from cc_deal dd, nd_acc na,accounts a where dd.nd=na.nd and na.acc=a.acc and a.dazs is null and dd.SOS  <>  15
      and a.rnk in (select cw.rnk from  customerw cw,customer c,KL_K110 k1  where k1.K110=c.ved and cw.tag='BUSSL' and cw.value='1' and c.date_off is null 
      and cw.rnk=c.rnk and k1.k111 in('01','02','03','10','11','12'))   
      and a.nbs in ('2020', '2030','2060','2063','2071','2083','2103','2113','2123','2133')
    and dd.nd not in( select nd from nd_txt where tag='BUS_MOD');
   end loop;
    COMMIT;
 end; 
/
prompt---9999999
begin
for m in (select kf from mv_kf)
  loop
    bc.go (m.kf);    
    insert into nd_txt
     (nd, tag, txt)
    select distinct dd.nd,'BUS_MOD',9 from cc_deal dd, nd_acc na,accounts a where dd.nd=na.nd and na.acc=a.acc and a.dazs is null and dd.SOS <> 15
      and a.rnk in (select cw.rnk from  customerw cw,customer c  where ((cw.tag='BUSSS' and cw.value='21') or (cw.tag='BUSSL' and cw.value='2')) 
      and c.date_off is null and cw.rnk=c.rnk
       group by cw.rnk
       having count(*)>1) 
       and a.nbs in ('2020','2030','2060','2063','2071','2083','2103','2113','2123','2133')
     and dd.nd not in( select nd from nd_txt where tag='BUS_MOD');
      end loop;
     COMMIT;
end; 
/
prompt----10101010
begin
for m in (select kf from mv_kf)
  loop
    bc.go (m.kf);    
    insert into nd_txt
     (nd, tag, txt)
    select distinct dd.nd,'BUS_MOD',10 from cc_deal dd, nd_acc na,accounts a where dd.nd=na.nd and na.acc=a.acc and a.dazs is null  and dd.SOS <> 15
      and a.rnk in (select cw.rnk from  customerw cw,customer c  where ((cw.tag='BUSSS' and cw.value='22') or (cw.tag='BUSSL' and cw.value='2')) 
      and c.date_off is null and cw.rnk=c.rnk
      group by cw.rnk
      having count(*)>1) 
      and a.nbs in ('2020','2030','2060','2063','2071','2083','2103','2113','2123','2133')
    and dd.nd not in( select nd from nd_txt where tag='BUS_MOD');
  end loop;
     COMMIT;
end; 
/
prompt----11111111111111
begin
for m in (select kf from mv_kf)
  loop
    bc.go (m.kf);    
    insert into nd_txt
     (nd, tag, txt)
   select distinct dd.nd, 'BUS_MOD',11 from cc_deal dd, nd_acc na,accounts a where dd.nd=na.nd and na.acc=a.acc and a.dazs is null  and dd.SOS <> 15
      and a.rnk in (select cw.rnk from  customerw cw,customer c  where ((cw.tag='BUSSS' and cw.value='23') or (cw.tag='BUSSL' and cw.value='2')) 
      and c.date_off is null and cw.rnk=c.rnk
      group by cw.rnk
      having count(*)>1) 
      and a.nbs in ('2020','2030','2060','2063','2071','2083','2103','2113','2123','2133')
    and dd.nd not in( select nd from nd_txt where tag='BUS_MOD');
  end loop;
    COMMIT;
end; 
/
prompt--121212121212
begin
for m in (select kf from mv_kf)
  loop
    bc.go (m.kf);    
    insert into nd_txt
     (nd, tag, txt)
      select distinct nd,'BUS_MOD',12 from cc_deal where vidd in (11,12,13) and SOS <> 15 and kf=m.kf
      and nd not in( select nd from nd_txt where tag='BUS_MOD');
      end loop;
   COMMIT;
end; 
/
prompt--131313131313
DECLARE
  l_stmt varchar2(4000);
  l_chunk varchar2(4000);
  p_task varchar2 (100);
BEGIN
  p_task:='bpk_task '||to_char(sysdate,'ddmmhh24miss');
  l_chunk := 'select kf as START_ID, kf as END_ID from bars.mv_kf';
  l_stmt := '
         begin
           bars_login.login_user(p_sessionid => substr(sys_guid(), 1, 32),
                                            p_userid    => 1,
                                            p_hostname  =>null ,
                                            p_appname   =>null);
         bc.go(:START_ID);
         bars.logger.info(''run_bpk13-''||:START_ID||''/''||:END_ID||'' ''||f_ourmfo);

       INSERT /*+ ignore_row_on_dupkey_index(BPK_PARAMETERS PK_BPKPARAMETERS ) */ into bpk_parameters (nd,tag,value)
       	select distinct t.nd, ''BUS_MOD'', 13 from(
       		select nd from w4_acc where nvl(dat_close, date''1000-01-01'') =  date''1000-01-01''  and kf=:START_ID
       		union all
       		select nd from bpk_acc where nvl(dat_close, date''1000-01-01'') =  date''1000-01-01''   and kf=:START_ID) t;
       commit;
       end;';

 dbms_parallel_execute.create_task(p_task); 
 DBMS_PARALLEL_EXECUTE.create_chunks_by_sql(task_name => p_task,
                                             sql_stmt  => l_chunk,
                                             by_rowid  => FALSE);

 DBMS_PARALLEL_EXECUTE.run_task(task_name      => p_task,
                                 sql_stmt       => l_stmt,
                                 language_flag  => DBMS_SQL.NATIVE,
                                 parallel_level => 10);
                                 
   dbms_parallel_execute.drop_task(p_task);                              

END;
/
prompt ----14141414114141
begin
for m in (select kf from mv_kf)
  loop
    bc.go (m.kf);    
    insert into nd_txt
     (nd, tag, txt)
  select distinct dd.nd,'BUS_MOD',14 from cc_deal dd, nd_acc na,accounts a where dd.nd=na.nd and na.acc=a.acc and a.dazs is null and dd.SOS <> 15
      and a.rnk in (select cw.rnk from  customerw cw,customer c,KL_K110 k1 where k1.K110=c.ved and cw.tag='BUSSL' and cw.value='1' and c.date_off is null 
      and cw.rnk=c.rnk and k1.k111 not in('01','02','03','10','11','12','35','41','42','43','49','50','51','52')) 
      and a.nbs in ('2020','2030','2060','2063','2071','2083','2103','2113','2123','2133')
    and dd.nd not in( select nd from nd_txt where tag='BUS_MOD');
      end loop;
      COMMIT;
end; 
/
prompt ----1515151515
DECLARE
  l_stmt varchar2(4000);
  l_chunk varchar2(4000);
  p_task varchar2 (100);
BEGIN
  p_task:='bpk_15_task'||to_char(sysdate,'ddmmhh24miss');
  l_chunk := 'select kf as START_ID, kf as END_ID from bars.mv_kf';
  l_stmt := '
         begin
           bars_login.login_user(p_sessionid => substr(sys_guid(), 1, 32),
                                            p_userid    => 1,
                                            p_hostname  =>null ,
                                            p_appname   =>null);
         bc.go(:START_ID);
         bars.logger.info(''run_bpk15-''||:START_ID||''/''||:END_ID||'' ''||f_ourmfo);

       insert /*+ ignore_row_on_dupkey_index(accountsw  PK_ACCOUNTSW) */ into accountsw
       (acc, tag, value)
             select distinct a.acc,''BUS_MOD'',15 from
             (select acc from  accounts   where dazs is null and (nbs in (1811,1819,2800,2801,2805,2806,2809,3548,3570,3578,3541,3710)
             or (nbs=3540 and OB22 in (01,03))))a;
       commit;
       end;';

 dbms_parallel_execute.create_task(p_task); 
 DBMS_PARALLEL_EXECUTE.create_chunks_by_sql(task_name => p_task,
                                             sql_stmt  => l_chunk,
                                             by_rowid  => FALSE);

 DBMS_PARALLEL_EXECUTE.run_task(task_name      => p_task,
                                 sql_stmt       => l_stmt,
                                 language_flag  => DBMS_SQL.NATIVE,
                                 parallel_level => 10);
                                 
   dbms_parallel_execute.drop_task(p_task);                              

END;
/
prompt---CC_DEAL VIDD=110 join acc_over Œ‚Â‰‡ÙÚ
prompt---666666666666666666666666666
begin
for m in (select kf from mv_kf)
  loop
    bc.go (m.kf);    
    insert into nd_txt
     (nd, tag, txt)
   select dd.nd,'BUS_MOD',6
    from cc_deal dd, nd_acc na, accounts a
   where dd.nd = na.nd
     and na.acc = a.acc
     and a.dazs is null
     and dd.SOS <> 15
     and a.rnk in (select cw.rnk
                     from customerw cw, customer c, KL_K110 k1
                    where k1.K110 = c.ved
                      and cw.tag = 'BUSSL'
                      and cw.value = '1'
                      and c.date_off is null
                      and cw.rnk = c.rnk
                      and k1.k111 in ('35'))
            and dd.vidd = '110'
            and dd.nd not in( select nd from nd_txt where tag='BUS_MOD')
   union 
  select o.nd,'BUS_MOD',6
    from accounts a, acc_over o
   where o.acc = a.acc
     and a.dazs is null
     and a.rnk in (select cw.rnk
                     from customerw cw, customer c, KL_K110 k1
                    where k1.K110 = c.ved
                      and cw.tag = 'BUSSL'
                      and cw.value = '1'
                      and c.date_off is null
                      and cw.rnk = c.rnk
                      and k1.k111 in ('35'))
            and o.nd not in( select nd from nd_txt where tag='BUS_MOD');
      end loop;
     COMMIT;
end; 
/
prompt----777777777777777777777
begin
for m in (select kf from mv_kf)
  loop
    bc.go (m.kf);    
    insert into nd_txt
     (nd, tag, txt)
   select dd.nd,'BUS_MOD',7
  from cc_deal dd, nd_acc na, accounts a
  where dd.nd = na.nd
   and na.acc = a.acc
   and a.dazs is null
   and dd.SOS  <>  15
   and dd.vidd = '110'
   and a.rnk in
       (select cw.rnk
          from customerw cw, customer c, KL_K110 k1
         where k1.K110 = c.ved
           and cw.tag = 'BUSSL'
           and cw.value = '1'
           and c.date_off is null
           and cw.rnk = c.rnk
           and k1.k111 in ('41', '42', '43', '49', '50', '51', '52')
       and dd.nd not in( select nd from nd_txt where tag='BUS_MOD'))
 union
 select o.nd,'BUS_MOD',7
 from accounts a, acc_over o
 where o.acc = a.acc
   and a.dazs is null
   and a.rnk in
       (select cw.rnk
          from customerw cw, customer c, KL_K110 k1
         where k1.K110 = c.ved
           and cw.tag = 'BUSSL'
           and cw.value = '1'
           and c.date_off is null
           and cw.rnk = c.rnk
           and k1.k111 in ('41', '42', '43', '49', '50', '51', '52'))
        and o.nd not in( select nd from nd_txt where tag='BUS_MOD' );
      end loop;
    COMMIT;
end; 
/
prompt ---88888888888888888
begin
for m in (select kf from mv_kf)
  loop
    bc.go (m.kf);    
    insert into nd_txt
     (nd, tag, txt)
  select distinct dd.nd,'BUS_MOD',8 from cc_deal dd, nd_acc na,accounts a where dd.nd=na.nd and na.acc=a.acc and a.dazs is null and dd.SOS <> 15 and dd.vidd = '110'
      and a.rnk in (select cw.rnk from  customerw cw,customer c,KL_K110 k1  where k1.K110=c.ved and cw.tag='BUSSL' and cw.value='1' and c.date_off is null 
      and cw.rnk=c.rnk and k1.k111 in('01','02','03','10','11','12'))
    and dd.nd not in( select nd from nd_txt where tag='BUS_MOD')
   union 
   select o.nd,'BUS_MOD',8
    from accounts a, acc_over o
   where o.acc = a.acc
     and a.dazs is null
     and a.rnk in (select cw.rnk from  customerw cw,customer c,KL_K110 k1  where k1.K110=c.ved and cw.tag='BUSSL' and cw.value='1' and c.date_off is null 
      and cw.rnk=c.rnk and k1.k111 in('01','02','03','10','11','12'))
    and o.nd not in( select nd from nd_txt where tag='BUS_MOD');
      end loop;
       COMMIT;
end; 
/
prompt ---9999999
begin
for m in (select kf from mv_kf)
  loop
    bc.go (m.kf);    
    insert into nd_txt
     (nd, tag, txt)
  select distinct dd.nd,'BUS_MOD',9 from cc_deal dd, nd_acc na,accounts a where dd.nd=na.nd and na.acc=a.acc and a.dazs is null and dd.SOS <> 15 and dd.vidd = '110'
      and a.rnk in (select cw.rnk from  customerw cw,customer c  where ((cw.tag='BUSSS' and cw.value='21') or (cw.tag='BUSSL' and cw.value='2')) 
      and c.date_off is null and cw.rnk=c.rnk
      group by cw.rnk
      having count(*)>1)
    and dd.nd not in( select nd from nd_txt where tag='BUS_MOD')
        union 
  select o.nd,'BUS_MOD',9
    from accounts a, acc_over o
   where o.acc = a.acc
     and a.dazs is null
     and a.rnk in (select cw.rnk from  customerw cw,customer c  where ((cw.tag='BUSSS' and cw.value='21') or (cw.tag='BUSSL' and cw.value='2')) 
     and c.date_off is null and cw.rnk=c.rnk
     group by cw.rnk
     having count(*)>1)
   and o.nd not in( select nd from nd_txt where tag='BUS_MOD');
      end loop;
      COMMIT;
end; 
/
prompt----10101010 
begin
for m in (select kf from mv_kf)
  loop
    bc.go (m.kf);    
    insert into nd_txt
     (nd, tag, txt)
  select distinct dd.nd,'BUS_MOD',10 from cc_deal dd, nd_acc na,accounts a where dd.nd=na.nd and na.acc=a.acc and a.dazs is null  and dd.SOS <> 15 and  dd.vidd='110'
      and a.rnk in (select cw.rnk from  customerw cw,customer c  where ((cw.tag='BUSSS' and cw.value='22') or (cw.tag='BUSSL' and cw.value='2')) 
      and c.date_off is null and cw.rnk=c.rnk
      group by cw.rnk
     having count(*)>1) 
   and dd.nd not in( select nd from nd_txt where tag='BUS_MOD')
    union 
    select o.nd,'BUS_MOD',10
    from accounts a, acc_over o
   where o.acc = a.acc
     and a.dazs is null
     and a.rnk in (select cw.rnk from  customerw cw,customer c  where ((cw.tag='BUSSS' and cw.value='22') or (cw.tag='BUSSL' and cw.value='2')) 
      and c.date_off is null and cw.rnk=c.rnk
      group by cw.rnk
     having count(*)>1)
    and o.nd not in( select nd from nd_txt where tag='BUS_MOD');
      end loop;
       COMMIT;
end; 
/
prompt----11111111111111
begin
for m in (select kf from mv_kf)
  loop
    bc.go (m.kf);    
    insert into nd_txt
     (nd, tag, txt)
  select distinct dd.nd,'BUS_MOD',11 from cc_deal dd, nd_acc na,accounts a where dd.nd=na.nd and na.acc=a.acc and a.dazs is null  and dd.SOS <> 15 and dd.vidd='110'
      and a.rnk in (select cw.rnk from  customerw cw,customer c  where ((cw.tag='BUSSS' and cw.value='23') or (cw.tag='BUSSL' and cw.value='2')) 
      and c.date_off is null and cw.rnk=c.rnk
      group by cw.rnk
     having count(*)>1)
  and dd.nd not in( select nd from nd_txt where tag='BUS_MOD')  
      union 
    select o.nd,'BUS_MOD',11
    from accounts a, acc_over o
   where o.acc = a.acc
     and a.dazs is null
     and a.rnk in (select cw.rnk from  customerw cw,customer c  where ((cw.tag='BUSSS' and cw.value='23') or (cw.tag='BUSSL' and cw.value='2')) 
      and c.date_off is null and cw.rnk=c.rnk
      group by cw.rnk
     having count(*)>1)
   and o.nd not in( select nd from nd_txt where tag='BUS_MOD');   
      end loop;
	COMMIT;
bc.home;
end; 
/    
prompt ----1414141411414
begin
for m in (select kf from mv_kf)
  loop
    bc.go (m.kf);    
    insert into nd_txt
     (nd, tag, txt)
 select distinct dd.nd,'BUS_MOD',14 from cc_deal dd, nd_acc na,accounts a where dd.nd=na.nd and na.acc=a.acc and a.dazs is null and dd.SOS <> 15 and  dd.vidd='110'
      and a.rnk in (select cw.rnk from  customerw cw,customer c,KL_K110 k1 where k1.K110=c.ved and cw.tag='BUSSL' and cw.value='1' and c.date_off is null 
      and cw.rnk=c.rnk and k1.k111 not in('01','02','03','10','11','12','35','41','42','43','49','50','51','52')) 
    and dd.nd not in( select nd from nd_txt where tag='BUS_MOD')  
      union
      select o.nd,'BUS_MOD',14
    from accounts a, acc_over o
   where o.acc = a.acc
     and a.dazs is null
     and a.rnk in (select cw.rnk from  customerw cw,customer c,KL_K110 k1 where k1.K110=c.ved and cw.tag='BUSSL' and cw.value='1' and c.date_off is null 
      and cw.rnk=c.rnk and k1.k111 not in('01','02','03','10','11','12','35','41','42','43','49','50','51','52'))
    and o.nd not in( select nd from nd_txt where tag='BUS_MOD'); 
      end loop;
COMMIT;
bars_context.home();
end; 
/
