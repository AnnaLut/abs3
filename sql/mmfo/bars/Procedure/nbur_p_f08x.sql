CREATE OR REPLACE PROCEDURE NBUR_P_F08X (
                                          p_kod_filii        varchar2
                                          , p_report_date    date
                                          , p_form_id        number
                                          , p_scheme           varchar2 default 'C'
                                          , p_balance_type     varchar2 default 'S'
                                          , p_file_code        varchar2 default '08X'
                                        )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования 08X для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.1.001  29/08/2018 (08/06/2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_              char(30)  := 'v.1.001  29/08/2018';
  c_title           constant varchar2(100 char) := $$PLSQL_UNIT || '.';

  c_old_file_code   constant varchar2(3 char) := '#08';

  c_XXXXXX               constant varchar2(6 char) := 'XXXXXX';

  l_nbuc          varchar2(20);
  l_type          number;
  l_datez         date := p_report_date + 1;
  l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
  l_file_id       nbur_ref_files.id%type := nbur_files.GET_FILE_ID(p_file_code => p_file_code);
  l_version_id    nbur_lst_files.version_id%type;
  l_ret           number;  

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
    execute immediate 'alter table NBUR_LOG_F08X truncate subpartition for ( to_date('''
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
  
  -- наповнення довідника для визначення кодів показників
  l_ret := f_nbur_get_ekp_08x(l_datez);       

  --Теперь сохрянем полученные данные в детальном протоколе
  insert into nbur_log_f08x(
                             report_date
                             , kf
                             , nbuc
                             , version_id
                             , EKP
                             , KU
                             , T020
                             , R020
                             , R011
                             , R030
                             , K040
                             , K072
                             , S130
                             , S183
                             , T070
                             , description
                             , acc_id
                             , acc_num
                             , kv
                             , maturity_date
                             , cust_id
                             , ref
                             , nd
                             , branch
                           )
      select 
             p_report_date as report_date
             , p_kod_filii as kf
             , p_kod_filii as nbuc
             , l_version_id
             , nvl(ekp, c_XXXXXX) as ekp
             , f_get_ku_by_nbuc(nbuc) as KU
             , seg_d as T020
             , seg_b as R020
             , seg_z as R011
             , seg_v as R030
             , seg_m as K040
             , seg_y as K072
             , seg_p as S130
             , seg_c as S183
             , abs(to_number(znap)) as T070          
             , comm as description
             , acc as ACC_ID
             , nls as ACC_NUM
             , kv as KV
             , mdate as MATURITY_DATE
             , rnk as CUST_ID
             , ref as REF
             , nd as ND
             , tobo as BRANCH 
      from   (select * from(
                select 
                    t.seg_01 as seg_d,
                    t.seg_02 as seg_b,
                    t.seg_03 as seg_z,
                    t.seg_04 as seg_y,
                    t.seg_05 as seg_r,
                    t.seg_06 as seg_v,
                    t.seg_07 as seg_c,
                    t.seg_08 as seg_p,
                    t.seg_09 as seg_m,
                    acc_num as nls, 
                    kv,
                    FIELD_CODE as kodp, 
                    nbuc, 
                    cust_id as rnk, 
                    acc_id as acc, 
                    FIELD_VALUE as znap,
                    ref,
                    DESCRIPTION as comm,
                    nd,
                    branch as tobo,
                    MATURITY_DATE as mdate
                from v_nbur_#08_dtl t
                where t.report_date = p_report_date and
                     t.kf = p_kod_filii
                ) t  
                left join
                    (select T.R020, max(t.i010) as i010 
                     from kl_r020 t 
                     where T.D_OPEN < sysdate and (T.D_CLOSE is null or t.d_close > sysdate)
                     group by T.R020) t2 
                on (t.seg_b = t2.R020)
                left join nbur_tmp_desc_ekp p
                on (p.I010 = t2.I010 and
                    p.t020 = t.seg_d and
                    p.r020 = t.seg_b)                
             );

  logger.info(c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
END;
/
