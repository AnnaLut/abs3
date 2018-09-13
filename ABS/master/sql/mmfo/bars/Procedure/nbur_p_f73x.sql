CREATE OR REPLACE PROCEDURE NBUR_P_F73X (
                                         p_kod_filii  varchar2
                                         , p_report_date      date
                                         , p_form_id          number
                                         , p_scheme           varchar2 default 'C'
                                         , p_balance_type     varchar2 default 'S'
                                         , p_file_code        varchar2 default '73X'
                                      )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования 73X в формате XML для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.18.004    13/09/2018 (26/07/2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_               char(30)  := 'v.18.004  13/09/2018';

  c_title            constant varchar2(200 char) := $$PLSQL_UNIT;

  l_nbuc             varchar2(20 char);
  l_type             number;
  l_datez            date := p_report_date + 1;
  l_file_code        varchar2(2 char) := substr(p_file_code, 2, 2);
  
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
                || ' date = ' || to_char(p_report_date, 'dd.mm.yyyy')
                || ' kod_filii=' || p_kod_filii
                || ' form_id=' || p_form_id
                || ' p_scheme= ' || p_scheme
              );

  -- определение начальных параметров (код области или МФО или подразделение)
  nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 0, l_file_code, l_nbuc, l_type);
  
  --Очистка партиции для хранения детального протокола
  begin
    execute immediate 'alter table NBUR_LOG_F73X truncate subpartition for ( to_date('''
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
  
  --Теперь сохрянем полученные данные в детальном протоколе
  
  -- детальний протокол
  insert into nbur_log_f73X
        (REPORT_DATE, KF, VERSION_ID, NBUC, KU, EKP, R030, T100, 
         ACC_ID, ACC_NUM, KV, CUST_ID, REF, BRANCH)
    select p.report_date, p.kf, l_version_id, p.kf, 
        f_get_ku_by_nbuc(nbuc) as KU, 
        (CASE p.seg_01 
               when '210' then 'A73001'
               when '221' then 'A73002'
               when '222' then 'A73003'
               when '223' then 'A73004'
               when '224' then 'A73005'
               when '220' then 'A73006'
               when '231' then 'A73007'
               when '232' then 'A73008'
               when '233' then 'A73009'
               when '234' then 'A73010'
               when '246' then 'A73011'
               when '247' then 'A73012'
               when '261' then 'A73013'
               when '262' then 'A73014'
               when '263' then 'A73015'
               when '270' then 'A73016'
               when '310' then 'A73017'
               when '321' then 'A73018'
               when '322' then 'A73019'
               when '323' then 'A73020'
               when '324' then 'A73021'
               when '325' then 'A73022'
               when '341' then 'A73023'
               when '342' then 'A73024'
               when '344' then 'A73025'
               when '343' then 'A73026'
               when '346' then 'A73027'
               when '347' then 'A73028'
               when '361' then 'A73029'
               when '362' then 'A73030'
               when '363' then 'A73031'
               when '370' then 'A73032'
               when '510' then 'A73033'
               when '520' then 'A73034'
               when '610' then 'A73035'
               when '620' then 'A73036'
               when '248' then 'A73037'
               when '348' then 'A73038'
               when '000' then 'A73000'
             else
               'XXXXXX'
             end) as EKP, 
        p.seg_02 as R030, 
        p.field_value, 
        a.acc as acc_id, p.acc_num, p.kv, 
        a.rnk as cust_id, p.ref, a.branch
    from v_nbur_#73_dtl p
    join accounts a
    on (a.kf = p_kod_filii and
        p.acc_num = a.nls and
        p.kv = a.kv)
    where p.report_date = p_report_date and
        p.kf = p_kod_filii;

  logger.info ('NBUR_P_F73X end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
END NBUR_P_F73X;
/
