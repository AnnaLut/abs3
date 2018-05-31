prompt----NEW SPPI
prompt--ND_TXT
DECLARE
  l_stmt varchar2(4000);
  l_chunk varchar2(4000);
  p_task varchar2 (100);
BEGIN
  p_task:='sppi_task_ndtxt'||to_char(sysdate,'ddmmhh24miss');
  l_chunk := 'select kf as START_ID, kf as END_ID from bars.mv_kf';
  l_stmt := '
         begin
           bars_login.login_user(p_sessionid => substr(sys_guid(), 1, 32),
                                            p_userid    => 1,
                                            p_hostname  =>null ,
                                            p_appname   =>null);
         bc.go(:START_ID);
         bars.logger.info(''run_sppi_yes_ndtxt-''||:START_ID||''/''||:END_ID||'' ''||f_ourmfo);
       insert /*+ignore_row_on_dupkey_index(nd_txt PK_NDTXT) */ into nd_txt
       (nd, tag, txt)
        select nd,''SPPI'',''връ'' from nd_txt where tag=''BUS_MOD'' and txt in(1,6,7,8,9,10,11,12,14);
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
prompt--CP_REFW
  begin 
for k in (select kf from mv_kf )
  loop
    bc.go (k.kf);
    insert /*+ignore_row_on_dupkey_index(cp_refw XPK_CPREFW) */ into cp_refw
     (ref,tag,value)  
    select c.ref,'SPPI','ЭГ' from cp_refw c, cp_deal dd  where c.ref=dd.ref and tag='BUS_MOD' and value=4;
   end loop;
  COMMIT;
end;  
/
  begin 
for k in (select kf from mv_kf )
  loop
    bc.go (k.kf);
    insert /*+ignore_row_on_dupkey_index(cp_refw XPK_CPREFW) */into cp_refw
     (ref,tag,value)  
    select c.ref,'SPPI','връ' from cp_refw c, cp_deal dd  where c.ref=dd.ref and tag='BUS_MOD' and value in(3,5);
   end loop;
  COMMIT;
end;  
/

prompt---bpk_parameters
DECLARE
  l_stmt varchar2(4000);
  l_chunk varchar2(4000);
  p_task varchar2 (100);
BEGIN
  p_task:='sppi_task_bpk'||to_char(sysdate,'ddmmhh24miss');
  l_chunk := 'select kf as START_ID, kf as END_ID from bars.mv_kf';
  l_stmt := '
         begin
           bars_login.login_user(p_sessionid => substr(sys_guid(), 1, 32),
                                            p_userid    => 1,
                                            p_hostname  =>null ,
                                            p_appname   =>null);
         bc.go(:START_ID);
         bars.logger.info(''run_sppi_yes_bpk-''||:START_ID||''/''||:END_ID||'' ''||f_ourmfo);
       INSERT /*+ ignore_row_on_dupkey_index(BPK_PARAMETERS PK_BPKPARAMETERS ) */ into bpk_parameters (nd,tag,value)
       select distinct t.nd, ''SPPI'',''връ'' from(
       select nd from w4_acc where nvl(dat_close, date''1000-01-01'') =  date''1000-01-01'' and kf=:START_ID
       union all
       select nd from bpk_acc where nvl(dat_close, date''1000-01-01'') =  date''1000-01-01'' and kf=:START_ID)t;
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
prompt-- accountsw 
prompt--1111
begin
for m in (select kf from mv_kf)
  loop
    bc.go (m.kf);
     insert into accountsw
     (acc, tag, value)
     select acc,'SPPI','ЭГ' from accountsw where tag='BUS_MOD' and value ='2' and kf=m.kf 
     and acc not in (select acc from accountsw where tag='SPPI' and value='ЭГ' and kf=m.kf);       
     end loop;
COMMIT;
end;  
/   

prompt---22222
prompt---SPPI (BUS_MOD=15)
prompt----

DECLARE
  l_stmt varchar2(4000);
  l_chunk varchar2(4000);
  p_task varchar2 (100);
BEGIN
  p_task:='SPPI_yes_task_accountsw'||to_char(sysdate,'ddmmhh24miss');
  l_chunk := 'select kf as START_ID, kf as END_ID from bars.mv_kf';
  l_stmt := '
         begin
           bars_login.login_user(p_sessionid => substr(sys_guid(), 1, 32),
                                            p_userid    => 1,
                                            p_hostname  =>null ,
                                            p_appname   =>null);
         bc.go(:START_ID);
         bars.logger.info(''run_sppi_yes-''||:START_ID||''/''||:END_ID||'' ''||f_ourmfo);

       insert /*+ ignore_row_on_dupkey_index(accountsw  PK_ACCOUNTSW) */ into accountsw
       (acc, tag, value)
             select distinct a.acc,''SPPI'',''връ'' from
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
prompt--update CP_REFW
prompt--11111
begin 
for k in (select kf from mv_kf )
  loop
    bc.go (k.kf);
      begin
      update cp_refw set value='връ' where ref in (select ref from cp_refw where tag='BUS_MOD' and value=3) and tag='SPPI';
       end;
      end loop;
 COMMIT;
bc.home;
end;  
/
prompt--222
  begin 
for k in (select kf from mv_kf )
  loop
    bc.go (k.kf);
      begin
      update cp_refw set value='връ' where ref in (select ref from cp_refw where tag='BUS_MOD' and value=5) and tag='SPPI';
      end;
      end loop;
   COMMIT;
bc.home;
end;  
/



