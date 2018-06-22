PROMPT *** Run *** ====== upd_zapros_3046.sql =======*** Run ***

declare 
l_txt clob;
begin
l_txt := 'SELECT
       d.vidd       CV,
       v.TYPE_NAME      TN,
       d.dat_end        ED,
       jrnl.job_id      JOBID,
       list.job_name    JOBNAME,
       jrnl.run_id      RUNID,
       jrnl.bank_date   BDAT,
       jrnl.start_date  SDAT,
       jrnl.finish_date FDAT,
       jrnl.user_id     USERID,
       s.fio            USERNAME,
       log.branch       BRANCH,
       b.name           BRANCHNAME,
       log.deal_num     DPTNUM,
       c.okpo           OKPO,
       log.nls          ACCNUM,
       log.kv           CURID,
       t.name           CURNAME,
       log.ref          REF,
       log.dpt_sum      DPTSUM,
       log.int_sum      INTSUM,
       case  
       when dpt_bonus.get_MMFO_ZPcard_count(log.rnk) = 0 then ''Нет''
       else ''ДА''
       end NLSZ,
       decode(log.status,1,0,1) STATUS,
       substr(log.errmsg,1,250) ERRMSG,
       log.rate_val     RATE
       FROM dpt_jobs_list  list,
       dpt_jobs_jrnl  jrnl,
       v_dpt_jobs_log   log,
       customer       c,
       staff$base     s,
       branch         b,
       dpt_deposit    d,
       dpt_vidd       v,
       tabval         t
 WHERE list.job_code  = ''JOB_EXTN''
   AND list.job_id    = jrnl.job_id
   AND jrnl.job_id    = log.job_id
   AND jrnl.run_id    = log.run_id
   AND log.rnk        = c.rnk
   AND jrnl.user_id   = s.id
   AND log.branch LIKE SYS_CONTEXT( ''bars_context'', ''user_branch_mask'' )
   AND log.branch     = b.branch
   AND log.kv         = t.kv
   and log.DPT_ID     = d.deposit_id
   and d.vidd         =v.vidd
   AND jrnl.bank_date = :sFdat1
   AND (:Param0 = 0 OR (:Param0 = 1 AND log.status <> 1)) ';

update bars.zapros z 
set z.txt = l_txt
where z.kodz = 3046;

end;
/ 
commit;
/  
PROMPT *** End *** ====== upd_zapros_3046.sql =======*** End ***
