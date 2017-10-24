

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/CREATE_JOB_UPDATE_SEC_CTX.sql ====
PROMPT ===================================================================================== 


PROMPT *** Create  procedure CREATE_JOB_UPDATE_SEC_CTX ***

  CREATE OR REPLACE PROCEDURE BARS.CREATE_JOB_UPDATE_SEC_CTX (p_user_id in integer, p_date in date default sysdate) is
  --
  -- создает задание на обновление глобального контекста масок пользователя для доступа к счетам
  --
  l_job		   binary_integer;
  l_what       varchar2(128);
begin
  l_what := 'bars.sec.update_sec_ctx('||p_user_id||');';
  begin
    select job into l_job from sys.job$
    where what=l_what and next_date=p_date and rownum=1;
    bars_audit.trace('create_job_update_sec_ctx(p_user_id=>'||p_user_id
                 ||', p_date=>'''||to_char(p_date,'DD.MM.YYYY HH24:MI:SS')||''') - job already exists with id='||l_job);
    return;
  exception when no_data_found then
    bars_audit.trace('create_job_update_sec_ctx(p_user_id=>'||p_user_id
                 ||', p_date=>'''||to_char(p_date,'DD.MM.YYYY HH24:MI:SS')||''')');
  end;
  sys.dbms_job.submit(
    job       => l_job,
    what      => l_what,
    next_date => p_date);
end create_job_update_sec_ctx;
/
show err;

PROMPT *** Create  grants  CREATE_JOB_UPDATE_SEC_CTX ***
grant EXECUTE                                                                on CREATE_JOB_UPDATE_SEC_CTX to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/CREATE_JOB_UPDATE_SEC_CTX.sql ====
PROMPT ===================================================================================== 
