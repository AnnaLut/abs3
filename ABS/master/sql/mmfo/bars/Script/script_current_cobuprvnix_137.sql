prompt TRIGGER OFF
begin
execute immediate 'alter trigger TAIUD_ND_TXT_UPDATE disable';
execute immediate 'alter trigger TBIU_NDTXT disable';
execute immediate 'alter trigger TGR_ND_TXT disable';
execute immediate 'alter trigger TIU_ND_TXT_CHECK disable';
execute immediate 'alter trigger TI_ND_TXT_INS_VKR disable';
end;
/

prompt для accp bus_mod
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

prompt--SPPI ND_TXT
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
         bars.logger.info(''run_sppi_yes_ndtxt-''||:START_ID||''/''||:END_ID||'' ''||f_ourmfo||''date:''||to_char(sysdate,''dd.mm.hh24:mi:ss''));
       insert /*+ignore_row_on_dupkey_index(nd_txt PK_NDTXT) */ into nd_txt
       (nd, tag, txt)
        select nd,''SPPI'',''Так'' from nd_txt where tag=''BUS_MOD'' and txt in(1,6,7,8,9,10,11,12,14);
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

prompt --IFRS ND_TXT
DECLARE
  l_stmt varchar2(4000);
  l_chunk varchar2(4000);
  p_task varchar2 (100);
BEGIN
  p_task:='ifrs_task_ndtxt'||to_char(sysdate,'ddmmhh24miss');
  l_chunk := 'select kf as START_ID, kf as END_ID from bars.mv_kf';
  l_stmt := '
         begin
           bars_login.login_user(p_sessionid => substr(sys_guid(), 1, 32),
                                            p_userid    => 1,
                                            p_hostname  =>null ,
                                            p_appname   =>null);
         bc.go(:START_ID);
         bars.logger.info(''ifrs_task_ndtxt-''||:START_ID||''/''||:END_ID||'' ''||f_ourmfo||''date:''||to_char(sysdate,''dd.mm.hh24:mi:ss''));
       insert /*+ignore_row_on_dupkey_index(nd_txt PK_NDTXT) */ into nd_txt
       (nd, tag, txt)
         select nd,''IFRS'',''AC'' from nd_txt where ((tag=''BUS_MOD'' and txt in(1,6,7,8,9,10,11,12,14) )or (tag=''SPPI'' and txt=''Так'')) 
       group by nd
       having count(*)>1; 
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

prompt TRIGGER ON
begin
execute immediate 'alter trigger TAIUD_ND_TXT_UPDATE enable';
execute immediate 'alter trigger TBIU_NDTXT enable';
execute immediate 'alter trigger TGR_ND_TXT enable';
execute immediate 'alter trigger TIU_ND_TXT_CHECK enable';
execute immediate 'alter trigger TI_ND_TXT_INS_VKR enable';
end;
/

prompt --SYNC_ND_TXT_UPDATE haryn vasyl

DECLARE

  l_stmt varchar2(4000);

  l_chunk varchar2(4000);

  p_task varchar2 (100);

BEGIN

  p_task:='sync_nd_txt_update'||to_char(sysdate,'ddmmhh24miss');

  l_chunk := 'select kf as START_ID, kf as END_ID from bars.mv_kf';

  l_stmt := '

         declare

           l_id             number :=0;

           l_cnt            number :=0;

         begin

           bars_login.login_user(p_sessionid => substr(sys_guid(), 1, 32),

                                            p_userid    => 1,

                                            p_hostname  =>null ,

                                            p_appname   =>null);

         bc.go(:START_ID);

         bars.logger.info(''sync_nd_txt_update-''||:START_ID||''/''||:END_ID||'' ''||f_ourmfo||''date:''||to_char(sysdate,''dd.mm.hh24:mi:ss''));

         BARS.UPDATE_TBL_UTL.SYNC_ND_TXT_UPDATE(l_id, l_cnt);

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
