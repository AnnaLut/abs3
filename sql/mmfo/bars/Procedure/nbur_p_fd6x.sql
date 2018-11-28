CREATE OR REPLACE PROCEDURE NBUR_P_FD6X (
                                          p_kod_filii        varchar2
                                          , p_report_date    date
                                          , p_form_id        number
                                          , p_scheme           varchar2 default 'C'
                                          , p_balance_type     varchar2 default 'S'
                                          , p_file_code        varchar2 default 'D6X'
                                        )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования D6X для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.1.004  21/11/2018 (16/11/2018) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_              char(30)  := 'v.1.004  21/11/2018';
  c_title           constant varchar2(100 char) := $$PLSQL_UNIT || '.';

  c_old_file_code   constant varchar2(3 char) := '#D6';

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
    execute immediate 'alter table NBUR_LOG_FD6X truncate subpartition for ( to_date('''
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

  --Теперь сохрянем полученные данные в детальном протоколе
  
  -- сумма залишків
  insert into nbur_log_fD6X(report_date, kf, nbuc, version_id, ekp, ku, t020, 
     r020, r011, r030, k040, k072, k111, s183, s241, f048, t070, description, 
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
             , K040
             , K072
             , K111
             , S183
             , S241
             , F048
             , T070
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
                     , case
                         when a.mdate is null then '1'
                         when a.mdate - p_report_date < 365 and a.mdate > p_report_date then '1'
                         when a.mdate - p_report_date > 365 and a.mdate > p_report_date then '2'
                         when a.mdate < p_report_date then 'Z' 
                         else '1'                     
                       end as S241 
                     , '3' as F048
              from (
                select 
                    t.seg_02 as T020,
                    t.seg_03 as R020,
                    t.seg_04 as R011,
                    t.seg_05 as K111,
                    t.seg_06 as K072,
                    t.seg_08 as S183,
                    t.seg_11 as R030,
                    t.seg_12 as K040,
                    to_number(trim(t.field_value)) as T070,
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
                from v_nbur_#d6_dtl t
                where t.report_date = p_report_date and
                     t.kf = p_kod_filii and
                     t.field_code like '1%2' -- залишки
                ) t  
                left outer join accounts a
                on (t.acc_id = a.acc)   
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
             );
             
  logger.info(c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
END;
/
