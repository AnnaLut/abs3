

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CLEAR_REPORT_SESSION.sql =========
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CLEAR_REPORT_SESSION ***

  CREATE OR REPLACE PROCEDURE BARS.CLEAR_REPORT_SESSION (p_query_id in cbirep_queries.id%type) is
    l_cq_row  cbirep_queries%rowtype;
    l_dj_row  dba_jobs%rowtype;
    l_djr_row dba_jobs_running%rowtype;
  begin
    -- параметры сессии
    select cq.*
      into l_cq_row
      from cbirep_queries cq
     where cq.id = p_query_id;

    -- смотрим есть ли джоб
    begin
      select dj.*
        into l_dj_row
        from dba_jobs dj
       where dj.job = l_cq_row.job_id;
    exception
      when no_data_found then
        return;
    end;

    -- смотрим работает ли джоб
    begin
      select djr.*
        into l_djr_row
        from dba_jobs_running djr
       where djr.job = l_cq_row.job_id;
    exception
      when no_data_found then
        -- удалям джоб
        dbms_job.broken(l_cq_row.job_id, true);
        commit;
        dbms_job.remove(l_cq_row.job_id);
        commit;
        return;
    end;

    -- удаляем работающий джоб и сесссию
    dbms_job.broken(l_cq_row.job_id, true);
    commit;
    declare
      l_s_row v$session%rowtype;
    begin
      select s.* into l_s_row from v$session s where s.sid = l_djr_row.sid;
      execute immediate 'alter system kill session ''' || l_s_row.sid || ',' ||
                        l_s_row.serial# || '''';
    exception
      when no_data_found then
        null;
    end;
    dbms_job.remove(l_cq_row.job_id);
    commit;

  exception
    when no_data_found then
      null;
  end clear_report_session;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CLEAR_REPORT_SESSION.sql =========
PROMPT ===================================================================================== 
