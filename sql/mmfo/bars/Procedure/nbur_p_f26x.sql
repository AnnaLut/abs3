PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F42X.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  procedure NBUR_P_F26X ***

CREATE OR REPLACE PROCEDURE NBUR_P_F26X (
                                           p_kod_filii  varchar2
                                           , p_report_date      date
                                           , p_form_id          number
                                           , p_scheme           varchar2 default 'C'
                                           , p_file_code        varchar2 default '26X'
                                      )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования 26X в формате XML для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.18.001 20/09/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_                     char(30)  := 'v.18.001    20.09.2018';

  c_title                  constant varchar2(200 char) := $$PLSQL_UNIT;
  c_date_fmt               constant varchar2(10 char) := 'dd.mm.yyyy'; --Формат преобразования даты в строку
  c_amt_fmt                constant varchar2(50 char) := 'FM9999999999990D0000';  --Формат преобразования числа в строку
  
  c_EKPOK1                 constant varchar2(6 char) := 'A42001'; 
  c_EKPOK2                 constant varchar2(6 char) := 'A42002'; 

  l_datez                  date := p_report_date + 1;
  l_nbuc                   varchar2(20 char);
  l_file_code              varchar2(2 char) := substr(p_file_code, 2, 2);
  l_type                   number;
  
  c_old_file_code          constant varchar2(3 char) := '#42';

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
    execute immediate 'alter table NBUR_LOG_F26X truncate subpartition for ( to_date('''
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
  insert into nbur_log_f26X
      (REPORT_DATE, KF, VERSION_ID, NBUC, EKP, KU, T020, R020, R011, R013, R030, 
       K040, Q001, K020, K021, K180, K190, S181, S245, S580, F033, T070, T071, 
       ACC_ID, ACC_NUM, KV, CUST_ID, BRANCH)
    select a.REPORT_DATE, a.KF, l_version_id, a.NBUC, 
         (case when to_number(R020||T020) in (15001, 15021, 15092, 15101, 15131, 15192, 
                                   15201, 15211, 15221, 15241, 15281, 15292, 15321, 
                                   15331, 15381, 15421, 15431, 15481, 15492, 16001, 
                                   16071, 16092, 18111, 18191, 18902, 30401, 30411, 
                                   30421, 30431, 30441, 30491, 31121, 31181, 31192, 
                                   31401, 31411, 31421, 31431, 31441, 32121, 32181, 
                                   32192, 35401, 35601, 35681, 35692, 36922, 91001, 
                                   92001, 92011, 92021, 92031, 92041, 92061, 92071, 
                                   92081, 93501, 93511, 93521, 93531, 93541, 93561, 
                                   93571, 93581, 93591) OR
                    to_number(R020) in (1508, 1526, 1516, 1518, 1535, 1536, 1545, 1546, 3115, 3116, 3216, 3566) 
               then 'A26001'
               when to_number(R020||T020) in (15002, 15072, 16002, 16022, 16102, 16132, 
                                   16212, 16222, 16232, 16282, 
                                   19112, 19122, 19192, 33502, 33512, 33522, 33532, 
                                   33542, 33592, 33602, 33612, 33622, 33632, 33642, 
                                   36402, 92102, 92112, 92122, 92132, 92142, 92162, 
                                   92172, 92182, 93602, 93612, 93622, 93632, 93642, 
                                   93662, 93672, 93682, 93692)  OR
                    to_number(R020) in (1608, 1616, 1618, 1626)  
               then 'A26002'
               else 'XXXXXX'  
          end) as EKP, 
         f_get_ku_by_nbuc(nbuc) as KU,
         b.T020, b.R020, b.R011, b.R013, b.R030, a.K040, a.Q001, a.K020, a.K021, a.K180, a.K190, 
         b.S181, replace(b.S245, '0', '#') as S245, b.S580, a.F033, b.T070, 
         (case when b.r030 = '980' then b.T070 else b.T071 end) as T071, 
         b.ACC_ID, b.ACC_NUM, b.KV, a.CUST_ID, b.BRANCH
    from (     
    -- інформація про банки             
    select REPORT_DATE, KF, NBUC, K020, (case when K040 = '804' then '3' else '4' end) as K021, 
           K040, Q001, K180, '#' as K190, F033, CUST_ID, BRANCH 
    from (
    select REPORT_DATE, KF, NBUC, SEG_04 as R020, SEG_05 as R011, SEG_06 as R013, SEG_07 as R030, 
       SEG_02 as K040, SEG_03 as K020, SEG_09 as S181, SEG_10 as S245, 
       SEG_11 as S580, SEG_08 as F033, SEG_01, FIELD_VALUE, CUST_ID, BRANCH
    from v_nbur_#26_dtl p
    where p.report_date = p_report_date and
          p.kf = p_kod_filii and 
          p.seg_04 = '0000')   
    pivot (max(field_value) for seg_01 in ('97' as K180, '98' as Q001, '99' as K190))) a
    left outer join
    -- інформація про рахунки та залишки
    (select R020, R030, R011, R013, S181, S245, S580,  
           (case when DEBG is not null then '1' else '2' end) T020, 
           nvl(DEBG, 0) + nvl(KREG, 0) T070, nvl(DEBV, 0) + nvl(KREV, 0) T071,
           CUST_ID, ACC_ID, ACC_NUM, KV, BRANCH
    from (
    select SEG_04 as R020, SEG_05 as R011, SEG_06 as R013, SEG_07 as R030, 
       SEG_02 as K040, SEG_03 as K020, SEG_09 as S181, SEG_10 as S245, 
       SEG_11 as S580, SEG_08 as F033, SEG_01, FIELD_VALUE, 
       CUST_ID, ACC_ID, ACC_NUM, KV, BRANCH
    from v_nbur_#26_dtl p
    where p.report_date = p_report_date and
          p.kf = p_kod_filii and 
          p.seg_04 <> '0000')   
    pivot (max(field_value) for seg_01 in ('10' as DEBG, '11' as DEBV, '20' as KREG, '21' as KREV))) b
    on (a.cust_id = b.cust_id); 

  --Агрегированный нам не нужен, так как агрегированные данные будут поступать из XML-формата

  logger.info (c_title || ' end for date = '||to_char(p_report_date, c_date_fmt));
END NBUR_P_F26X;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F26X.sql =========*** End *** =
PROMPT ===================================================================================== 