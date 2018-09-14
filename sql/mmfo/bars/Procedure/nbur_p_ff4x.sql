CREATE OR REPLACE PROCEDURE NBUR_P_FF4X (
                                          p_kod_filii        varchar2
                                          , p_report_date    date
                                          , p_form_id        number
                                          , p_scheme           varchar2 default 'C'
                                          , p_balance_type     varchar2 default 'S'
                                          , p_file_code        varchar2 default 'F4X'
                                        )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования F4X для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.1.002 14/09/2018 (02/09/2018) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_              char(30)  := 'v.1.002  14/09/2018';
  c_title           constant varchar2(100 char) := $$PLSQL_UNIT || '.';

  c_old_file_code   constant varchar2(3 char) := '#F4';

  c_XXXXXX               constant varchar2(6 char) := 'XXXXXX';

  l_nbuc          varchar2(20);
  l_type          number;
  l_datez         date := p_report_date + 1;
  l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
  l_file_id       nbur_ref_files.id%type := nbur_files.GET_FILE_ID(p_file_code => p_file_code);
  l_version_id    nbur_lst_files.version_id%type;
  l_ret           number;  
  l_next_mnth_frst_dt    date;
  

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
    execute immediate 'alter table NBUR_LOG_FF4X truncate subpartition for ( to_date('''
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
  l_ret := f_nbur_get_ekp_XXX(p_file_code, l_datez);       
  
  l_next_mnth_frst_dt := last_day(trunc(p_report_date)) + 1;

  --Теперь сохрянем полученные данные в детальном протоколе
  
  -- сумма залишків
  insert into nbur_log_fF4X(report_date, kf, nbuc, version_id, ekp, ku, 
     t020, r020, r011, r030, k072, k111, k140, f074, s180, d020, 
     t070, t090, description, 
     acc_id, acc_num, kv, maturity_date, cust_id, ref, nd, branch)
  select 
             p_report_date as report_date
             , p_kod_filii as kf
             , p_kod_filii as nbuc
             , l_version_id
             , nvl(ekp, c_XXXXXX) as ekp
             , f_get_ku_by_nbuc(nbuc) as KU
             , T020
             , R020
             , R011
             , R030
             , K072
             , K111
             , K140
             , F074
             , S180
             , D020
             , T070
             , T090
             , description
             , ACC_ID
             , ACC_NUM
             , KV
             , mdate as MATURITY_DATE
             , CUST_ID
             , REF
             , ND
             , BRANCH 
      from   (select t.* 
                     , p.ekp 
                     , a.mdate
                     , decode(r.kol24, '101', '100', '010', '000', nvl(r.kol24, '000')) as F074
                     , nvl(k.k111, '00') as K111
              from (select t020, r020, r011, k072, s180, d020, r030, k140, 
                           acc_num, kv, nbuc, cust_id, acc_id, ref, description, 
                           nd, branch, maturity_date, sum(t070) as t070, sum(t090) as t090
                    from (
                      select 
                        t.seg_01 as DD,
                        t.seg_02 as T020,
                        t.seg_03 as R020,
                        t.seg_04 as R011,
                        t.seg_06 as K072,
                        t.seg_07 as S180,
                        t.seg_09 as D020,
                        t.seg_10 as R030,
                        t.seg_11 as K140,
                        to_number(trim(t.field_value)) as znap,
                        t.acc_num, 
                        t.kv,
                        t.field_code as kodp, 
                        t.nbuc, 
                        t.cust_id, 
                        t.acc_id, 
                        t.ref,
                        t.description,
                        t.nd,
                        t.branch,
                        t.maturity_date
                    from v_nbur_#f4_dtl t
                    where t.report_date = p_report_date and
                         t.kf = p_kod_filii)
                  pivot (max(znap) for dd in ('1' as T070, '2' as T090)) 
                  group by t020, r020, r011, k072, s180, d020, r030, k140, 
                           acc_num, kv, nbuc, cust_id, acc_id, ref, description, 
                           nd, branch, maturity_date
                ) t  
                left join accounts a
                on (t.acc_id = a.acc)  
                left join (select  t.acc
                                   , max(coalesce(trim(replace(replace(kol24, '[', ''), ']', '')), '000')) as kol24
                           from    rez_cr t
                           where   t.fdat = l_next_mnth_frst_dt
                           group by t.acc) r 
                on (t.acc_id = r.acc)                 
                left join
                    (select T.R020, max(t.i010) as i010 
                     from kl_r020 t 
                     where t.d_open < sysdate and (t.d_close is null or t.d_close > sysdate)
                     group by T.R020) t2 
                on (t.R020 = t2.R020)
                left join nbur_tmp_desc_ekp p
                on (p.I010 = t2.I010 and
                    p.t020 = t.t020 and
                    p.r020 = t.R020) 
                left join customer c
                on (t.cust_id = c.rnk)  
                left join kl_k110 k
                on (c.ved = k.k110 and
                    k.d_open <= l_datez and
                    (k.d_close is null or k.d_close>l_datez))
             );
             
  logger.info(c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
END;
/
