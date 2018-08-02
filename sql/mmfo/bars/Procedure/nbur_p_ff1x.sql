PROMPT ===================================================================================== 
PROMPT *** Run *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_FF1X.sql =======*** Run ***
PROMPT ===================================================================================== 

PROMPT *** Create  procedure NBUR_P_FF1X ***

create or replace procedure NBUR_P_FF1X(p_kod_filii        varchar2
                                          , p_report_date    date
                                          , p_form_id        number
                                          , p_scheme         varchar2 default 'C'
                                          , p_file_code      varchar2 default 'F1X'
                                          )
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    Процедура формирования #73X для схема "C"
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :    v.16.001     30/07/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: p_report_date - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  c_title                constant varchar2(100 char) := $$PLSQL_UNIT || '.';

  l_nbuc                 varchar2(20);
  l_type                 number;
  l_datez                date := p_report_date + 1;
  l_file_code            varchar2(2) := substr(p_file_code, 2, 2);

  l_version_id           number; --Номер версии файла
  l_old_file_code        varchar2(3) := '#F1';

  e_ptsn_not_exsts       exception;

  pragma exception_init( e_ptsn_not_exsts, -02149 );
BEGIN
  logger.info (c_title || ' begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

  -- определение начальных параметров (код области или МФО или подразделение)
  nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 0, l_file_code, l_nbuc, l_type);

  --Подготавливаем партицию для вставки данных
  begin
    execute immediate 'alter table NBUR_LOG_F1PX truncate subpartition for ( to_date('''
                      || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
  exception
    when e_ptsn_not_exsts then
      null;
  end;

  --Определяем версию файла для хранения детальеного протокола (сели рабочей нет, то ставим -1)
  l_version_id := coalesce(f_nbur_get_run_version(p_file_code => p_file_code
                                                   , p_kf => p_kod_filii
                                                   , p_report_date => p_report_date
                                                 )
                           , -1);

  logger.trace(c_title || ' Version_id is ' || l_version_id);

  -- очікуємо формування старого файлу
  nbur_waiting_form(p_kod_filii, p_report_date, l_old_file_code, c_title);    
  
  insert
    into NBUR_DETAIL_PROTOCOLS
       ( REPORT_DATE, KF, REPORT_CODE, NBUC,
         FIELD_CODE,
         FIELD_VALUE, DESCRIPTION
       , ACC_ID, ACC_NUM, KV, MATURITY_DATE, CUST_ID, REF, ND, BRANCH )
  select p_report_date, 
         p_kod_filii, 
         p_file_code, 
         nvl(trim(nbuc), l_nbuc),
         (case when seg_02 ='11'  then 'AF1001'
               when seg_02 ='12'  then 'AF1002'
               when seg_02 ='41'  then 'AF1003'
               when seg_02 ='42'  then 'AF1004'
               else 'XXXXXX'
           end)
         ||seg_04 || seg_05 || seg_06
       , nvl(field_value, ' ')
       , DESCRIPTION
       , ACC_ID
       , ACC_NUM, KV
       , MATURITY_DATE
       , CUST_ID
       , REF
       , ND
       , BRANCH 
   from v_nbur_#f1_dtl t
   where report_date = p_report_date and
         kf = p_kod_filii;
   commit;

   insert
   into NBUR_AGG_PROTOCOLS
       ( REPORT_DATE, KF, REPORT_CODE, NBUC, FIELD_CODE, FIELD_VALUE )
   select p_report_date, 
         p_kod_filii, 
         p_file_code, 
         nvl(trim(nbuc), l_nbuc),
         (case when seg_02 ='11'  then 'AF1001'
               when seg_02 ='12'  then 'AF1002'
               when seg_02 ='41'  then 'AF1003'
               when seg_02 ='42'  then 'AF1004'
               else 'XXXXXX'
           end)
         ||seg_04 || seg_05 || seg_06
       , nvl(field_value, ' ')
   from v_nbur_#f1 t
   where report_date = p_report_date and
         kf = p_kod_filii;
   commit;

  logger.info (c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

end NBUR_P_FF1X;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_FF1X.sql =======*** End ***
PROMPT ===================================================================================== 