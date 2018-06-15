PROMPT ===================================================================================== 
PROMPT *** Run *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_FF1X_NC.sql =======*** Run ***
PROMPT ===================================================================================== 

PROMPT *** Create  procedure NBUR_P_FF1X_NC ***

create or replace procedure nbur_p_ff1x_nc(
                                            p_report_date  date
                                            , p_kod_filii  varchar2
                                            , p_form_id    number
                                          )
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    Процедура формирования #73X для схема "C"
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :    30.03.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: p_report_date - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
begin

   P_FF1_NN ( p_report_date, 'C', 'X');


  insert
    into NBUR_DETAIL_PROTOCOLS
       ( REPORT_DATE, KF, REPORT_CODE, NBUC,
         FIELD_CODE,
         FIELD_VALUE, DESCRIPTION
       , ACC_ID, ACC_NUM, KV, MATURITY_DATE, CUST_ID, REF, ND, BRANCH )
  select p_report_date, p_kod_filii, 'F1X', nvl(trim(nbuc), '26'),
         (case when substr(kodp,2,2) ='11'  then 'AF1001'
               when substr(kodp,2,2) ='12'  then 'AF1002'
               when substr(kodp,2,2) ='41'  then 'AF1003'
               when substr(kodp,2,2) ='42'  then 'AF1004'
               else 'AF1000'
           end )
         ||substr(kodp,4,7),
         nvl(znap, ' '), COMM
       , ACC, NLS, KV, MDATE, RNK, REF, ND, TOBO
    from RNBU_TRACE;

  commit;

      insert
        into NBUR_AGG_PROTOCOLS
           ( REPORT_DATE, KF, REPORT_CODE, NBUC, FIELD_CODE, FIELD_VALUE )
      select p_report_date, p_kod_filii, 'F1X', nvl(trim(nbuc), '26'),
             (case when substr(kodp,2,2) ='11'  then 'AF1001'
                   when substr(kodp,2,2) ='12'  then 'AF1002'
                   when substr(kodp,2,2) ='41'  then 'AF1003'
                   when substr(kodp,2,2) ='42'  then 'AF1004'
                   else 'AF1000'
               end)   ||substr(kodp,4,7),
             SUM(to_number(znap))
       from RNBU_TRACE
      group by nvl(trim(nbuc), '26'), kodp;

  commit;

end nbur_p_ff1X_nc;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_FF1X_NC.sql =======*** End ***
PROMPT ===================================================================================== 