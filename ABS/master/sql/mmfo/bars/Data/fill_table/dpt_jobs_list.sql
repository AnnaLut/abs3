begin
  Insert into DPT_JOBS_LIST
    ( JOB_ID, JOB_CODE, JOB_NAME, JOB_PROC, ORD, RUN_LVL )
  Values
    ( 249, 'JOB_CLOS', 'Закриття прострочених вкладів', 'dpt_web.auto_move2archive_opt', 2, 1 );
exception
  when dup_val_on_index then
    update DPT_JOBS_LIST
       set JOB_CODE = 'JOB_CLOS'
         , JOB_NAME = 'Закриття прострочених вкладів'
         , JOB_PROC = 'dpt_web.auto_move2archive_opt'
         , ORD      = 2
         , RUN_LVL  = 1
     where JOB_ID   = 249;
end;
/

commit;

update DPT_JOBS_LIST
   set RUN_LVL = 2
 where JOB_ID  = 267;

commit;
