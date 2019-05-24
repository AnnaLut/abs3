PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_FX2X.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  procedure NBUR_P_FX2X ***

CREATE OR REPLACE PROCEDURE NBUR_P_FX2X (
                                           p_kod_filii  varchar2
                                           , p_report_date      date
                                           , p_form_id          number
                                           , p_scheme           varchar2 default 'C'
                                           , p_file_code        varchar2 default 'X2X'
                                      )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования X2X в формате XML для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.18.001  29/03/2019 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_                     char(30)  := 'v.18.001    23/05/2019 ';

  c_title                  constant varchar2(200 char) := $$PLSQL_UNIT;
  c_date_fmt               constant varchar2(10 char) := 'dd.mm.yyyy'; --Формат преобразования даты в строку
  c_amt_fmt                constant varchar2(50 char) := 'FM9999999999990D0000';  --Формат преобразования числа в строку
  
  c_EKPOK1                 constant varchar2(6 char) := 'A42001'; 
  c_EKPOK2                 constant varchar2(6 char) := 'A42002'; 

  l_datez                  date := p_report_date + 1;
  l_nbuc                   varchar2(20 char);
  l_file_code              varchar2(2 char) := substr(p_file_code, 2, 2);
  l_type                   number;
  
  c_old_file_code          constant varchar2(3 char) := '#X2';

  l_file_id       nbur_ref_files.id%type := nbur_files.GET_FILE_ID(p_file_code => p_file_code);
  l_version_id    nbur_lst_files.version_id%type;  
  
  --Exception
  e_ptsn_not_exsts exception;

  pragma exception_init( e_ptsn_not_exsts, -02149 );  
BEGIN
  logger.info (
                c_title
                || ' begin for'
                || ' date = ' || to_char(p_report_date, c_date_fmt)
                || ' kod_filii=' || p_kod_filii
                || ' form_id=' || p_form_id
                || ' p_scheme= ' || p_scheme
              );

  -- определение начальных параметров (код области или МФО или подразделение)
  nbur_files.P_PROC_SET(
                         p_kod_filii
                         , p_file_code
                         , p_scheme
                         , l_datez
                         , 0
                         , l_file_code
                         , l_nbuc
                         , l_type
                       );

  --Очистка партиции для хранения детального протокола
  begin
    execute immediate 'alter table NBUR_LOG_FX2X truncate subpartition for ( to_date('''
                      || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
  exception
    when e_ptsn_not_exsts then
      null;
  end;

  --Определяем версию файла для хранения детальеного протокола
  l_version_id := f_nbur_get_run_version(p_file_code => p_file_code
                                          , p_kf => p_kod_filii
                                          , p_report_date => p_report_date
                                        );

  logger.trace(c_title || ' Version_id is ' || l_version_id);

  -- очікуємо формування старого файлу
  nbur_waiting_form(p_kod_filii, p_report_date, c_old_file_code, c_title);
  
  -- детальний протокол
  insert into nbur_log_fX2X
      (REPORT_DATE, KF, VERSION_ID, NBUC, KU, EKP, F099, Q003_4, T070, 
       ACC_ID, ACC_NUM, KV, CUST_ID, ND, LINK_GROUP, LINK_CODE, COMM, BRANCH)
  select REPORT_DATE, KF, l_version_id, KF, KU, EKP, F099, Q003_4, T070, 
       ACC_ID, ACC_NUM, KV, CUST_ID, ND, LINK_GROUP, LINK_CODE, DESCRIPTION, BRANCH
  from (select REPORT_DATE, KF, VERSION_ID, kf as NBUC, 
           f_get_ku_by_nbuc(kf) as KU, 
           (case when seg_02 = '0000' then c_EKPOK2 else c_EKPOK1 end) as EKP, 
           seg_01 as F099, seg_02 as Q003_4, field_value as T070, 
           ACC_ID, ACC_NUM, KV, CUST_ID, ND, REF as LINK_GROUP, 
           NBUC as LINK_CODE, DESCRIPTION, kf as BRANCH          
        from v_nbur_#X2_dtl p
        where p.report_date = p_report_date and
              p.kf = p_kod_filii and    
              p.seg_01 not in ('47', '51') -- закриті показники, що використовуються як допоміжні
     ); 

  --Агрегированный нам не нужен, так как агрегированные данные будут поступать из XML-формата

  logger.info (c_title || ' end for date = '||to_char(p_report_date, c_date_fmt));
END NBUR_P_FX2X;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_FX2X.sql =========*** End *** =
PROMPT ===================================================================================== 