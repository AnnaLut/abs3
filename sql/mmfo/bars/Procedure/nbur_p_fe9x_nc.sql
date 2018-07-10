

PROMPT ===================================================================================== 
PROMPT *** Run *** ========= Scripts /Sql/BARS/Procedure/NBUR_P_FE9X_NC.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  procedure NBUR_P_FE9X_NC ***

  CREATE OR REPLACE PROCEDURE BARS.NBUR_P_FE9X_NC (
                              p_report_date       date,
                              p_kod_filii         varchar2,
                              p_form_id           number )
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    Процедура формирования #E9 для схема "C"
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :    17.05.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: p_report_date - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin

    p_fE9_sb (p_report_date, 'D', 'X');
    
  insert
    into NBUR_DETAIL_PROTOCOLS
       ( REPORT_DATE, KF, REPORT_CODE, NBUC,
         FIELD_CODE,
         FIELD_VALUE, DESCRIPTION
       , ACC_ID, ACC_NUM, KV, MATURITY_DATE, CUST_ID, REF, ND, BRANCH )
  select p_report_date, p_kod_filii, 'E9X', nvl(trim(nbuc), '26'),
         substr(kodp,1,16)||substr(kodp,19),
         nvl(znap, ' '), COMM
       , ACC, NLS, KV, MDATE, RNK, REF, ND, TOBO
    from RNBU_TRACE;

  insert
    into NBUR_DETAIL_PROTOCOLS
       ( REPORT_DATE, KF, REPORT_CODE, NBUC,
         FIELD_CODE,
         FIELD_VALUE, DESCRIPTION, branch )
      with d060_not_work as (
                     select d060k030, d060, txt
                       from kl_d060
                      where d060 in ( select d060
                                        from kl_fe9
                                       where nvl(pr_del, 1) <> 0
                                         and kf =p_kod_filii 
                                       group by d060
                                       minus
                                       select substr(kodp,3,2) d060
                                         from rnbu_trace
                                        group by substr(kodp,3,2)    )
                        and d_close is null
              ) 
        select p_report_date, p_kod_filii, 'E9X',
               (select obl from branch where branch='/'||p_kod_filii||'/') nbuc,
               '1'||'0'||d060_not_work.d060||'1'||'3'||'0000000006'||
                (case when d060_not_work.d060k030='1' then '980' else '000' end)||         -- r030
               '804'||'000'||
                (case when d060_not_work.d060k030='1' then '804' else '000' end)||'000',
               '0', 'D060 '||d060_not_work.D060||' '||d060_not_work.TXT||' не приймали участь', p_kod_filii 
          from d060_not_work 
        union
        select p_report_date, p_kod_filii, 'E9X',
               (select obl from branch where branch='/'||p_kod_filii||'/') nbuc,
               '3'||'0'||d060_not_work.d060||'1'||'3'||'0000000006'||
                (case when d060_not_work.d060k030='1' then '980' else '000' end)||         -- r030
               '804'||'000'||
                (case when d060_not_work.d060k030='1' then '804' else '000' end)||'000',
               '0', 'D060 '||d060_not_work.D060||' '||d060_not_work.TXT||' не приймали участь', p_kod_filii 
          from d060_not_work  ;
  commit;

      insert
        into NBUR_AGG_PROTOCOLS
           ( REPORT_DATE, KF, REPORT_CODE, NBUC, FIELD_CODE, FIELD_VALUE )
      select p_report_date, p_kod_filii, 'E9X',
             nbuc, FIELD_CODE,
             SUM(to_number(FIELD_VALUE))
       from NBUR_DETAIL_PROTOCOLS
      group by nbuc, FIELD_CODE;
/*      insert
        into NBUR_AGG_PROTOCOLS
           ( REPORT_DATE, KF, REPORT_CODE, NBUC, FIELD_CODE, FIELD_VALUE )
      select p_report_date, p_kod_filii, 'E9X', nvl(trim(nbuc), '26'),
             substr(kodp,1,16)||substr(kodp,19),
             SUM(to_number(znap))
       from RNBU_TRACE
      group by nvl(trim(nbuc), '26'), kodp;

  commit;

  insert
    into NBUR_AGG_PROTOCOLS
       ( REPORT_DATE, KF, REPORT_CODE, NBUC,
         FIELD_CODE, FIELD_VALUE)
      with d060_not_work as (
                     select d060k030, d060, txt
                       from kl_d060
                      where d060 in ( select d060
                                        from kl_fe9
                                       where nvl(pr_del, 1) <> 0
                                         and kf =p_kod_filii 
                                       group by d060
                                       minus
                                       select substr(kodp,3,2) d060
                                         from rnbu_trace
                                        group by substr(kodp,3,2)    )
                        and d_close is null
              ) 
        select p_report_date, p_kod_filii, 'E9X',
               (select obl from branch where branch='/'||p_kod_filii||'/') nbuc,
               '1'||'0'||d060_not_work.d060||'1'||'3'||'0000000006'||
                (case when d060_not_work.d060k030='1' then '980' else '#' end)||         -- r030
               '804'||'#'||
                (case when d060_not_work.d060k030='1' then '804' else '#' end)||'#', '0'
          from d060_not_work 
        union
        select p_report_date, p_kod_filii, 'E9X',
               (select obl from branch where branch='/'||p_kod_filii||'/') nbuc,
               '2'||'0'||d060_not_work.d060||'1'||'3'||'0000000006'||
                (case when d060_not_work.d060k030='1' then '980' else '#' end)||         -- r030
               '804'||'#'||
                (case when d060_not_work.d060k030='1' then '804' else '#' end)||'#', '0'
          from d060_not_work  ;  */
  commit;

end;
/
show err;



PROMPT ===================================================================================== 
PROMPT *** End *** ========= Scripts /Sql/BARS/Procedure/NBUR_P_FE9X_NC.sql =========*** End
PROMPT ===================================================================================== 
