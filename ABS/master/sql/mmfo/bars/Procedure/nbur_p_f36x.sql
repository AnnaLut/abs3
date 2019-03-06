PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F36X.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  procedure NBUR_P_F36X ***

CREATE OR REPLACE PROCEDURE NBUR_P_F36X (
                                           p_kod_filii  varchar2
                                           , p_report_date      date
                                           , p_form_id          number
                                           , p_scheme           varchar2 default 'C'
                                           , p_file_code        varchar2 default '#36'
                                      )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования 36X в формате XML для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.18.002    07/12/2018 (24/10/2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_      char(30)  := 'v.19.004   06/03/2019';

  c_title                  constant varchar2(200 char) := $$PLSQL_UNIT;
  c_date_fmt               constant varchar2(10 char) := 'dd.mm.yyyy'; --Формат преобразования даты в строку
  c_amt_fmt                constant varchar2(50 char) := 'FM9999999999990D0000';  --Формат преобразования числа в строку

  l_datez                  date := p_report_date + 1;
  l_nbuc                   varchar2(20 char);
  l_file_code              varchar2(2 char) := substr(p_file_code, 2, 2);
  l_type                   number;

  l_file_id       nbur_ref_files.id%type := nbur_files.GET_FILE_ID(p_file_code => p_file_code);
  l_version_id    nbur_lst_files.version_id%type;

  l_date_z_end            date;
  l_b040_8                varchar2(8 char);
  l_clob                  clob;
  l_error                 varchar2(2000);

  --l_lim_day               number := F_get_CURR_LIM_DAY1;--Добовий ліміт купівлі безготівкової валюти(коп)

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
    execute immediate 'alter table NBUR_LOG_F36X truncate subpartition for ( to_date('''
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

  l_date_z_end := last_day(p_report_date) + 1;
  logger.info (c_title || ' l_date_z_end=' || to_char(l_date_z_end, c_date_fmt) );
  l_b040_8 := '00626804';

  -- підготовка даних для файлу
  l_clob := cim_reports.p_f531(l_date_z_end, l_error);

  if l_error is null or substr(l_error, 1, 3) = '#36' then
    -- детальний протокол
    --A36001
    INSERT INTO nbur_log_f36X (report_date, kf, version_id, nbuc, 
                               ekp, ku, 
                               b040, 
                               f021, 
                               k020, k021, q001_1, q001_2, q002_1, q002_2, 
                               q003_2, q003_3, 
                               q007_1, q007_2, q007_3, q007_4,
                               q007_5, k040, d070, f008, 
                               k112, f019, f020, 
                               r030, q023, q006, t070, t071, f105,
                               acc_id, acc_num, kv, cust_id, branch)
    SELECT  p_report_date as REPORT_DATE, p_kod_filii as KF, l_version_id AS VERSION_ID, p_kod_filii as NBUC,
            'A36001' as EKP, f_get_ku_by_nbuc(p_kod_filii) as KU,
            b040,
            (case
               when p22 = -1 then 5
               else p22
             end) as F021,
            k020, substr(f_nbur_get_k020_by_rnk(rnk), 1, 1) as k021, p06 as Q001_1, p08 as Q001_2, p07 as Q002_1, q002_2,
            case when length(Q003_2) > 4 then '9999' else Q003_2 end  as Q003_2, --по Івано-Франківську якась лажа вилізла, більше 9999
            p17 as Q003_3, 
            p16 as Q007_1, p21 as Q007_2, p23 as Q007_3, p24 as Q007_4,
            to_date(doc_date, 'ddmmyyyy') as Q007_5, lpad(p09, 3, '0') as K040, p01 as D070, p18 as F008, 
            substr(p02,1,1) as K112, nvl(p20, '9') as F019, p19 as F020,
            lpad(p14, 3, '0') as R030, l_b040_8 || b041 as Q023, p27 as Q006, p13 as T070, p15 as T071, '#' as f105,
            null as ACC_ID, null as ACC_NUM, p14 as KV, rnk as CUST_ID, BRANCH
    from (select f.*, l_b040_8 || b041 as b040,
                 to_char(row_number() over (order by f.k020, f.p17, f.p16, to_date(f.doc_date, 'ddmmyyyy')))  as Q003_2
          from cim_f36 f
          where f.create_date = l_date_z_end
            and f.branch like '/'||p_kod_filii||'/'
            and f.b041 > '0'
            and f.manual_include = 0)
    order by b041, k020, p17, p08, p16, p21, p01;
    
    --    
    --A36002
    INSERT INTO nbur_log_f36X (report_date, kf, version_id, nbuc, 
                               ekp, ku, 
                               b040, 
                               f021, 
                               k020, k021, q001_1, q001_2, q002_1, q002_2, 
                               q003_2, q003_3, 
                               q007_1, q007_2, q007_3, q007_4,
                               q007_5, k040, d070, f008, 
                               k112, f019, f020, 
                               r030, q023, q006, t070, t071, f105,
                               acc_id, acc_num, kv, cust_id, branch)
    select report_date, kf, version_id, nbuc, 
                               ekp, ku, 
                               b040, 
                               f021, 
                               k020, k021, q001_1, q001_2, q002_1, q002_2, 
                               case when length(Q003_2) > 4 then '9999' else Q003_2 end  as Q003_2,
                               q003_3, 
                               q007_1, q007_2, q007_3, q007_4,
                               q007_5, k040, d070, f008, 
                               k112, f019, f020, 
                               r030, q023, q006, t070, t071, f105,
                               acc_id, acc_num, kv, cust_id, branch
    from                                                      
        (SELECT  p_report_date as REPORT_DATE, p_kod_filii as KF, l_version_id AS VERSION_ID, p_kod_filii as NBUC,
                'A36002' as EKP, f_get_ku_by_nbuc(p_kod_filii) as KU,
                b040,
                '#' as F021,
                k020, substr(f_nbur_get_k020_by_rnk(CUST_ID), 1, 1) as k021, Q001_1, Q001_2, Q002_1, Q002_2,
                to_char(row_number() over (order by K020, Q003_3, Q007_1, Q007_5), 'fm0000')  as Q003_2, Q003_3, 
                Q007_1, Q007_2, Q007_3, Q007_4,
                Q007_5, K040, D070, F008, 
                K112, '#' as F019, '#' as F020,
                R030, Q023, Q006, T070, T071, F105,
                null as ACC_ID, null as ACC_NUM, KV, CUST_ID, BRANCH
        from table(cim_reports.p_f531_2(l_date_z_end)));


    logger.info (c_title || ' end for date = '||to_char(p_report_date, c_date_fmt));
    else
      logger.error (c_title || 'for date = '||to_char(p_report_date, c_date_fmt)||' Повідомлення: '||l_error);
      raise_application_error(-20001,c_title || 'for date = '||to_char(p_report_date, c_date_fmt)||' Повідомлення: '||l_error);
  end if;
END NBUR_P_F36X;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F36X.sql =========*** End *** =
PROMPT ===================================================================================== 