PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_FE8X.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  procedure NBUR_P_FE8X ***

CREATE OR REPLACE PROCEDURE NBUR_P_FE8X (
                                           p_kod_filii  varchar2
                                           , p_report_date      date
                                           , p_form_id          number
                                           , p_scheme           varchar2 default 'C'
                                           , p_file_code        varchar2 default 'E8X'
                                      )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования E8X в формате XML для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.18.003 19/09/2018 (31/07/2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_                     char(30)  := 'v.18.003    19.09.2018';

  c_title                  constant varchar2(200 char) := $$PLSQL_UNIT;
  c_date_fmt               constant varchar2(10 char) := 'dd.mm.yyyy'; --Формат преобразования даты в строку
  c_amt_fmt                constant varchar2(50 char) := 'FM9999999999990D0000';  --Формат преобразования числа в строку

  l_datez                  date := p_report_date + 1;
  l_nbuc                   varchar2(20 char);
  l_file_code              varchar2(2 char) := substr(p_file_code, 2, 2);
  l_type                   number;
  
  c_old_file_code    constant varchar2(3 char) := '#73';

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
    execute immediate 'alter table NBUR_LOG_FE8X truncate subpartition for ( to_date('''
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
  insert into nbur_log_fE8X
            (REPORT_DATE, KF, VERSION_ID, NBUC, KU, EKP, Q001, Q029, K074, K110, 
             K040, KU_1, Q020, K020, K014, R020, R030, Q003_1, Q003_2, Q007_1, Q007_2, 
             T070_1, T070_2, T070_3, T070_4, T090, Q003_12, K021, ACC_ID, ACC_NUM, KV, 
             CUST_ID, BRANCH)
    select REPORT_DATE, KF, VERSION_ID, NBUC, KU, EKP, Q001, Q029, K074, K110, 
           K040, KU_1, Q020, K020, K014, R020, R030, Q003_1, Q003_2, Q007_1, Q007_2, 
           T070_1, T070_2, T070_3, T070_4, T090, 
           row_number() over (order by k020, q003_1, r030, r020, acc_num) as Q003_12, 
           K021, ACC_ID, ACC_NUM, KV, CUST_ID, BRANCH
    from (
    with select_all as (    
    select *
    from (  
    select *      
    from v_nbur_#e8_dtl p
    where p.report_date = p_report_date and
          p.kf = p_kod_filii)      
    pivot (max(field_value) for seg_01 in ('010' as Q001, 
                                           '019' as Q029,
                                           '021' as K074, 
                                           '025' as K110,
                                           '050' as K040, 
                                           '055' as KU_1,
                                           '060' as Q020, 
                                           '090' as Q003_2,
                                           '111' as Q007_1, 
                                           '112' as Q007_2,
                                           '121' as T070_1, 
                                           '122' as T070_2,
                                           '123' as T070_3, 
                                           '124' as T070_4,
                                           '130' as T090,
                                           '206' as K014
                                           )))
    select a.report_date, a.kf, a.version_id, a.nbuc, 
           f_get_ku_by_nbuc(nbuc) ku, 'AE8001' ekp, 
           a.q001, a.q029, a.k074, a.k110, a.k040, 
           (case when a.ku_1 = '0' then '#' else a.ku_1 end) as ku_1, 
           a.q020, a.k020, a.k014, 
           d.r020, d.r030, b.q003_1, b.q003_2, b.q007_1, b.q007_2, 
           d.t070_1, d.t070_2, d.t070_3, d.t070_4, 
           nvl(trim(c.t090), '0.0000') as t090, a.k021, 
           d.acc_id, d.acc_num, d.kv, d.cust_id, d.branch
    from (        
    -- дані про кредитора                               
    select report_date, kf, l_version_id as version_id, nbuc, max(Q001) as Q001, max(Q029) as Q029, 
        max(K074) as K074, max(K110) as K110, max(K040) as K040, max(KU_1) as KU_1, 
        max(Q020) as Q020, seg_02 as K020, max(K014) as K014, max(seg_06) as K021
    from select_all                                      
    where seg_03 = '0000'          
    group by report_date, kf, nbuc, kf, seg_02) a
    left outer join 
    -- дані про кредит (без розрізу валют)
    (select seg_02 as K020, seg_03 as Q003_1, max(Q003_2) as Q003_2, 
        max((case when trim(Q007_1) is not null 
                  then substr(Q007_1,1,2)||'.'||substr(Q007_1,3,2)||'.'||substr(Q007_1,5,4) 
                  else null 
             end)) as Q007_1, 
        max((case when trim(Q007_2) is not null 
                  then substr(Q007_2,1,2)||'.'||substr(Q007_2,3,2)||'.'||substr(Q007_2,5,4) 
                  else null 
             end)) as Q007_2
    from select_all                                      
    where seg_03 <> '0000' and seg_04 = '0000' and seg_05 = '000'             
    group by seg_02, seg_03) b
    on (a.k020 = b.k020)
    left outer join 
    -- дані про валюту та відсоткову ставку по кредиту
    (select seg_02 as K020, seg_03 as Q003_1, seg_05 as R030, max(T090) as T090
    from select_all                                      
    where seg_03 <> '0000' and seg_04 = '0000' and seg_05 <> '000'             
    group by seg_02, seg_03, seg_05) c
    on (b.k020 = c.k020 and
        b.Q003_1 = c.Q003_1)
    left outer join 
    -- дані про рахунки та халишки по рахунках по кредиту
    (select seg_02 as K020, seg_03 as Q003_1, seg_05 as R030, seg_04 as R020, 
        nvl(sum(T070_1), 0) as T070_1, 
        nvl(sum(T070_2), 0) as T070_2, 
        nvl(sum(T070_3), 0) as T070_3, 
        nvl(sum(T070_4), 0) as T070_4, 
        ACC_ID, ACC_NUM, KV, CUST_ID, BRANCH
    from select_all                                      
    where seg_03 <> '0000' and seg_04 <> '0000' and seg_05 <> '000'             
    group by seg_02, seg_03, seg_04, seg_05, ACC_ID, ACC_NUM, KV, CUST_ID, BRANCH) d
    on (c.k020 = d.k020 and
        c.Q003_1 = d.Q003_1 and
        c.R030 = d.R030)    
    );

  --Агрегированный нам не нужен, так как агрегированные данные будут поступать из XML-формата

  logger.info (c_title || ' end for date = '||to_char(p_report_date, c_date_fmt));
END NBUR_P_FE8X;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_FE8X.sql =========*** End *** =
PROMPT ===================================================================================== 