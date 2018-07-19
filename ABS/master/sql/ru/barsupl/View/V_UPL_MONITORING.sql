

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSUPL/View/V_UPL_MONITORING.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** Create  view V_UPL_MONITORING ***

CREATE OR REPLACE FORCE VIEW BARSUPL.V_UPL_MONITORING
( JOB_NAME, DESCRIPT, group_number, state, START_TIME, FINISH_TIME, RUN_DURATION, NEXT_RUN_DATE, UPLOAD_PERCENT, BANK_DATE, KF, FILE_ID, SQL_ID, File_Descript, UPL_ERRORS)
AS
with stat as ( select st1.id, st1.start_time, st1.rec_type, st1.group_id, st1.upl_bankdate, st1.stop_time, st1.file_id,
                      st1.sql_id, st1.upl_errors, st1.status_id, st1.parent_id,  coalesce(bars.gl.kf, '000000') kf
                 from BARSUPL.UPL_STATS st1
               --union all
               --select st2.id, st2.start_time, st2.rec_type, st2.group_id, st2.upl_bankdate, st2.stop_time, st2.file_id,
               --       st2.sql_id, st2.upl_errors, st2.status_id, st2.parent_id, coalesce(bars.gl.kf, '000000') kf
               --  from BARSUPL.UPL_STATS_ARCHIVE st2 
               -- where ST2.START_TIME>sysdate-33
             )
select job_gr.jname job_name,  job_gr.descript, job_gr.grnumb group_number, job_gr.state,
       last_file.start_time, last_file.finish_time, job_gr.run_duration, job_gr.next_run_date,
        trunc(( select decode(count(*),0,1, count(*))-1
                  from stat st1
                 where ST1.PARENT_ID = last_file.parent_id ) /
              ( select decode(count(*),0,1,count(*))
                  from BARSUPL.UPL_FILES fi,
                       BARSUPL.UPL_FILEGROUPS_RLN fg
                  where FG.GROUP_ID=job_gr.grnumb and
                        FI.FILE_ID = FG.FILE_ID and
                        FI.ISACTIVE<>0
              ) ,2 ) *100||'%' as upload_percent,
        last_file.bdt Bank_Date, last_file.kf, last_file.FILE_ID, last_file.SQL_ID, FL.DESCRIPT File_Descript, last_file.UPL_ERRORS
        --last_file.STATUS_ID,--, job_gr.kf
 from (select J.JOB_NAME jname, AJ.DESCRIPT,
              coalesce(bars.gl.kf, '000000') kf,
              J.state,
              to_char(J.LAST_START_DATE,'dd.mm.yyyy hh24:mi:ss')LAST_START_DATE,
              J.LAST_START_DATE l_start_d,
              J.LAST_RUN_DURATION,
              coalesce(EXTRACT(HOUR from  J.LAST_RUN_DURATION),0)||' hrs. '||coalesce(EXTRACT(MINUTE  from  J.LAST_RUN_DURATION),0)||' min '
               ||coalesce(trunc(EXTRACT(SECOND  from  J.LAST_RUN_DURATION)),0)||' sec' as RUN_DURATION, 
              to_char(J.NEXT_RUN_DATE,'dd.mm.yyyy hh24:mi')NEXT_RUN_DATE,-- aj.kf,
              j.grnumb 
         from ( select j1.owner,
                       j1.JOB_NAME,
                       GR.JOB_NAME standrt_j_name,
                       J1.LAST_START_DATE,
                       -- J1.LAST_RUN_DURATION,
                       nvl(J1.LAST_RUN_DURATION, (sysdate- J1.LAST_START_DATE)) LAST_RUN_DURATION, 
                       J1.NEXT_RUN_DATE,
                       --J1.JOB_ACTION
                       gr.value  grnumb,
                       J1.STATE
                  from dba_scheduler_jobs j1,
                       BARSUPL.UPL_AUTOJOB_PARAM_VALUES gr
                 where J1.OWNER = 'BARSUPL' and
                       instr(j1.JOB_NAME,GR.JOB_NAME)>0 and GR.PARAM='GROUPID'
                 union all
                select JARCH.OWNER,
                       JARCH.JOB_NAME,
                       GR.JOB_NAME standrt_j_name, 
                       JARCH.ACTUAL_START_DATE LAST_START_DATE,
                       JARCH.RUN_DURATION,
                       null,
                       gr.value  grnumb,
                       JARCH.STATUS
                  from DBA_SCHEDULER_JOB_RUN_DETAILS jarch,BARSUPL.UPL_AUTOJOB_PARAM_VALUES gr
                 where Jarch.OWNER = 'BARSUPL' and
                       JARCH.LOG_DATE > sysdate-33 and
                       instr(JARCH.JOB_NAME,GR.JOB_NAME)>0 and GR.PARAM='GROUPID'
              ) j
         left join BARSUPL.UPL_AUTOJOBS aj on (J.standrt_j_name = AJ.JOB_NAME) 
        where --J.state= 'RUNNING' and 
              --J.ENABLED='TRUE' and
              J.OWNER = 'BARSUPL' and
              j.grnumb is not null
      ) job_gr
    left join
      (select st1.GROUP_ID,
              ST1.UPL_BANKDATE bdt,
              (select ST2.START_TIME
                 from stat st2
                where ST2.id = st1.PARENT_ID
                  and ST2.REC_TYPE ='GROUP') START_TIME,
              ST1.STOP_TIME Finish_time,
              ST1.FILE_ID,
              ST1.SQL_ID,
              ST1.UPL_ERRORS,
              ST1.STATUS_ID,
              ST1.PARENT_ID,
              coalesce(bars.gl.kf, '000000') kf
         from stat st1
        where st1.id in (select max(st.id)
                           from stat st 
                          where ST.REC_TYPE ='FILE' --and ST.FILE_ID <> 2
                          group by ST.GROUP_ID, ST.UPL_BANKDATE, st.kf
                        )
      ) last_file
             on (last_file.GROUP_ID = job_gr.grnumb  and  job_gr.kf=last_file.kf )
    left join BARSUPL.UPL_FILES fl 
             on (FL.FILE_ID = last_file.FILE_ID )
WHERE last_file.START_TIME between job_gr.l_start_d-1/24/60 and job_gr.l_start_d+1/24/60;

begin
  execute immediate 'GRANT SELECT ON V_UPL_monitoring      TO BARS';
exception when others then null;
end;
/

begin
  execute immediate 'GRANT SELECT ON V_UPL_monitoring      TO BARS_ACCESS_DEFROLE';
exception when others then null;
end;
/

begin
  execute immediate 'GRANT SELECT ON V_UPL_monitoring      TO BARSREADER_ROLE';
exception when others then null;
end;
/

begin
  execute immediate 'GRANT SELECT ON V_UPL_monitoring      TO UPLD';
exception when others then null;
end;
/

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSUPL/View/V_UPL_MONITORING.sql =========*** End ***
PROMPT ===================================================================================== 
