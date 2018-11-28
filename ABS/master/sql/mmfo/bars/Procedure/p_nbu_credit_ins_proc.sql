create or replace procedure p_nbu_credit_ins_proc ( p_file_id       in NBU_CREDIT_INSURANCE_FILES.ID%type,
                                                   p_message         out varchar2)
IS
   l_job_id   number;
   l_job_what varchar2(4000) ;

begin

   l_job_what :=  'p_nbu_credit_ins_proc_load ('|| gl.aUid ||', '''|| sys_context('bars_context','user_branch')|| ''', '|| p_file_id || ');';
   bms.enqueue_msg( 'Обробку реєстру поставлено в чергу:' || l_job_what, dbms_aq.no_delay, dbms_aq.never, gl.aUid );

    -- стартуем job
   savepoint before_job_start;
   dbms_job.submit( job       => l_job_id,
                   what      => l_job_what,
                   next_date => sysdate,
                   interval  => null,
                   no_parse  => true);

exception when others then
  bars_audit.info('ERROR'||substr(sqlerrm || chr(10) ||    dbms_utility.format_call_stack(), 0,4000));    -- произошли ошибки
  rollback to savepoint before_job_start;
end p_nbu_credit_ins_proc;
/

grant EXECUTE     on p_nbu_credit_ins_proc to BARS_ACCESS_DEFROLE;