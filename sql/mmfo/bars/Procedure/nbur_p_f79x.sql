PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F79X.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  procedure NBUR_P_F79X ***

CREATE OR REPLACE PROCEDURE NBUR_P_F79X (
                                           p_kod_filii  varchar2
                                           , p_report_date      date
                                           , p_form_id          number
                                           , p_scheme           varchar2 default 'C'
                                           , p_file_code        varchar2 default '79X'
                                      )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования 79X в формате XML для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.18.002 18/10/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_                     char(30)  := 'v.18.002    18.10.2018';

  c_title                  constant varchar2(200 char) := $$PLSQL_UNIT;
  c_date_fmt               constant varchar2(10 char) := 'dd.mm.yyyy'; --Формат преобразования даты в строку
  c_amt_fmt                constant varchar2(50 char) := 'FM9999999999990D0000';  --Формат преобразования числа в строку
  
  c_EKPOK1                 constant varchar2(6 char) := 'A79001'; 

  l_datez                  date := p_report_date + 1;
  l_nbuc                   varchar2(20 char);
  l_file_code              varchar2(2 char) := substr(p_file_code, 2, 2);
  l_type                   number;
  
  c_old_file_code          constant varchar2(3 char) := '#79';

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
    execute immediate 'alter table NBUR_LOG_F79X truncate subpartition for ( to_date('''
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
  insert into nbur_log_f79X
      (REPORT_DATE, KF, VERSION_ID, NBUC, EKP, KU, R030, K030, Q001, K020, K021, 
       Q007_1, Q007_2, Q007_3, Q007_4, Q003_1, Q003_2, Q003_3, T070_1, T070_2, 
       T070_3, T070_4, T090_1, T090_2, ACC_ID, ACC_NUM, KV, CUST_ID, BRANCH)
  select REPORT_DATE, KF, l_version_id as VERSION_ID, NBUC, EKP, 
    KU, R030, K030, Q001, K020, K021, 
    to_date(Q007_1, 'ddmmyyyy') as Q007_1, 
    to_date(Q007_2, 'ddmmyyyy') as Q007_2, 
    to_date(Q007_3, 'ddmmyyyy') as Q007_3, 
    to_date(Q007_4, 'ddmmyyyy') as Q007_4, 
    Q003_1, Q003_2, Q003_3, 
    nvl(to_number(T070_1), 0) as T070_1, 
    nvl(to_number(T070_2), 0) as T070_2, 
    nvl(to_number(T070_3), 0) as T070_3, 
    nvl(to_number(T070_4), 0) as T070_4, 
    nvl(to_number(T090_1), 0) as T090_1, 
    nvl(to_number(T090_2), 0) as T090_2, 
    ACC_ID, ACC_NUM, KV, CUST_ID, BRANCH
  from (
    select REPORT_DATE, KF, NBUC, 
        f_get_ku_by_nbuc(nbuc) as KU,
        c_EKPOK1 as EKP, SEG_01, FIELD_VALUE,
        seg_03 as R030, 
        seg_02 as K020,
        seg_04 as Q003_3, 
        ACC_ID, ACC_NUM, KV, CUST_ID, BRANCH
    from v_nbur_#79_dtl p
    where p.report_date = p_report_date and
          p.kf = p_kod_filii)
    pivot (max(field_value) for seg_01 in 
                ('01' as Q001, 
                 '02' as Q007_1, 
                 '03' as Q007_2, 
                 '04' as Q007_3,
                 '05' as Q003_1, 
                 '07' as T070_1,
                 '08' as T070_2, 
                 '10' as T070_3, 
                 '09' as T090_1,
                 '12' as T090_2, 
                 '13' as K030,
                 '14' as Q003_2, 
                 '15' as Q007_4,
                 '16' as T070_4, 
                 '17' as K021)); 

  --Агрегированный нам не нужен, так как агрегированные данные будут поступать из XML-формата

  logger.info (c_title || ' end for date = '||to_char(p_report_date, c_date_fmt));
END NBUR_P_F79X;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F79X.sql =========*** End *** =
PROMPT ===================================================================================== 