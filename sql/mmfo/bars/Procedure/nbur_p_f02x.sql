CREATE OR REPLACE PROCEDURE NBUR_P_F02X (p_kod_filii        varchar2
                                          , p_report_date    date
                                          , p_form_id        number
                                          , p_scheme           varchar2 default 'C'
                                          , p_balance_type     varchar2 default 'S'
                                          , p_file_code        varchar2 default '02X'
                                        )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования 02X для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.1.001  10/09/2018 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_              char(30)  := 'v.1.001  10/09/2018';
  c_title           constant varchar2(100 char) := $$PLSQL_UNIT || '.';

  c_old_file_code   constant varchar2(3 char) := '#02';

  c_XXXXXX               constant varchar2(6 char) := 'XXXXXX';

  l_nbuc          varchar2(20);
  l_type          number;
  l_datez         date := p_report_date + 1;
  l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
  l_file_id       nbur_ref_files.id%type := nbur_files.GET_FILE_ID(p_file_code => p_file_code);
  l_version_id    nbur_lst_files.version_id%type;

  --Exception
  e_ptsn_not_exsts exception;

  pragma exception_init( e_ptsn_not_exsts, -02149 );
BEGIN
  logger.info (c_title || ' begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

  -- определение начальных параметров (код области или МФО или подразделение)
  nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 1, l_file_code, l_nbuc, l_type);
  
  execute immediate 'truncate table NBUR_TMP_DESC_EKP';  

  --Очистка партиции для хранения детального протокола
  begin
    execute immediate 'alter table NBUR_LOG_F02X truncate subpartition for ( to_date('''
                      || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
  exception
    when e_ptsn_not_exsts then
      null;
  end;

  --Определяем версию файла для хранения детальеного протокола
  l_version_id := f_nbur_get_run_version(
                                          p_file_code => p_file_code
                                          , p_kf => p_kod_filii
                                          , p_report_date => p_report_date
                                        );

  logger.trace(c_title || ' Version_id is ' || l_version_id);

  -- очікуємо формування старого файлу
  nbur_waiting_form(p_kod_filii, p_report_date, c_old_file_code, c_title);
  
  --Теперь сохрянем полученные данные в детальном протоколе
  
  -- сумма залишків
  insert into nbur_log_f02X
        (REPORT_DATE, KF, VERSION_ID, NBUC, EKP, KU, R020, T020, R030, K040, 
         T070, T071, ACC_ID, ACC_NUM, KV, CUST_ID, BRANCH)
    select report_date, kf, l_version_id, nbuc, ekp, ku, r020, t020, r030, k040, 
           abs(sum(T070)) as T070, 
           abs(sum((case when R030 = '980' then T070 else nvl(T071, 0) end))) as T071,
           acc_id, acc_num, kv, cust_id, branch
    from (
    select p.report_date, p.kf, 
        f_get_ku_by_nbuc(nbuc) as KU, 
        'A02'||k.I010||'0' as EKP, substr(p.seg_01, 1, 1) as t020, 
        substr(p.seg_01, 2, 1) as dd, p.seg_02 as R020, 
        p.seg_03 as R030, 
        lpad(trim(c.country), 3, '0') as K040, 
        p.field_value, p.acc_id, p.cust_id, p.nbuc, p.acc_num, p.kv, p.branch
    from v_nbur_#02_dtl p
    join customer c
    on (c.kf = p_kod_filii and
        p.cust_id = c.rnk)
    join (select R020, I010
            from KL_R020
           where PREM = 'КБ'
             and D_OPEN <= l_datez
             and lnnvl(D_CLOSE <= l_datez )
        ) k
    on (p.seg_02 = k.r020)       
    where p.report_date = p_report_date and
        p.kf = p_kod_filii)
    pivot (max(field_value) for dd in ('0' as T070, '1' as T071))
    group by report_date, kf, ekp, ku, r020, t020, r030, k040, 
        acc_id, cust_id, nbuc, acc_num, kv, branch;
             
  logger.info(c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
END;
/
