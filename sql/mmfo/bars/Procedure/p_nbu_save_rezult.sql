

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/P_NBU_SAVE_REZULT.sql =========***
PROMPT ===================================================================================== 


PROMPT *** Create  procedure P_NBU_SAVE_REZULT ***

  CREATE OR REPLACE PROCEDURE BARS.P_NBU_SAVE_REZULT (p_report_date in date,
                                              p_kf          in varchar2,
                                              p_file_code   in varchar2) is
begin
   commit;
   
   if p_file_code like '#%' then
       insert into nbur_agg_protocols(REPORT_DATE, KF, REPORT_CODE, NBUC, 
            FIELD_CODE, FIELD_VALUE, ERROR_MSG, ADJ_IND)
       select unique datf, kf, p_file_code, nvl(trim(nbuc), '300465'), kodp, nvl(znap, ' '), ERR_MSG, fl_mod
       from tmp_nbu
       where kodf = substr(p_file_code,2,2) and
             datf = p_report_date and
             kf = p_kf;
   else
       insert into nbur_agg_protocols(REPORT_DATE, KF, REPORT_CODE, NBUC, 
            FIELD_CODE, FIELD_VALUE, ERROR_MSG, ADJ_IND)
       select unique datf, kf, p_file_code, nvl(trim(nbuc), '300465'), kodp, nvl(znap, ' '), ERR_MSG, fl_mod
       from tmp_irep
       where kodf = substr(p_file_code,2,2) and
             datf = p_report_date and
             kf = p_kf;
   end if;
                       
   insert into NBUR_DETAIL_PROTOCOLS(REPORT_DATE, KF, REPORT_CODE, NBUC, 
        FIELD_CODE, FIELD_VALUE, DESCRIPTION, ACC_ID, ACC_NUM, KV, 
        MATURITY_DATE, CUST_ID, REF, ND, BRANCH)
   select unique p_report_date, p_kf, p_file_code, nvl(trim(nbuc), '300465'), kodp, nvl(znap, ' '), COMM, ACC, 
        NLS, KV, MDATE, RNK,REF,  ND, TOBO
   from rnbu_trace;
   
   logger.info('NBUR : file='||p_file_code||
            ' dat='||to_char(p_report_date, 'dd.mm.yyyy')||' KF='||p_kf||' - OK');
   
   commit;
exception
    when others then
         logger.error('NBUR :error during saving file='||p_file_code||
            ' dat='||to_char(p_report_date, 'dd.mm.yyyy')||' KF='||p_kf||
            CHR(10)||sqlerrm||CHR(10)||dbms_utility.format_error_backtrace());
end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/P_NBU_SAVE_REZULT.sql =========***
PROMPT ===================================================================================== 
