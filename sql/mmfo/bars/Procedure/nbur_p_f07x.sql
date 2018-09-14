CREATE OR REPLACE PROCEDURE NBUR_P_F07X (
                                          p_kod_filii        varchar2
                                          , p_report_date    date
                                          , p_form_id        number
                                          , p_scheme           varchar2 default 'C'
                                          , p_balance_type     varchar2 default 'S'
                                          , p_file_code        varchar2 default '07X'
                                        )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования 07X для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.1.002  14/09/2018 (30/08/2018) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_              char(30)  := 'v.1.002  14/09/2018';
  c_title           constant varchar2(100 char) := $$PLSQL_UNIT || '.';

  c_old_file_code   constant varchar2(3 char) := '#07';

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
    execute immediate 'alter table NBUR_LOG_F07X truncate subpartition for ( to_date('''
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
  insert into nbur_log_f07X(report_date, kf, nbuc, version_id, ekp, ku, t020
             , r020, r011, k072, r030, s183, s130, k040, s240, t100, q130, q003, description
             , acc_id, acc_num, kv, maturity_date, cust_id, ref, nd, branch)
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
             , K072
             , R030
             , (case when ekp = 'A07F52' then '#' else S183 end) as S183
             , S130
             , K040
             , (case when ekp = 'A07F52' then '#' else S240 end) as S240
             , T100
             , Q130         
             , Q003         
             , description
             , ACC_ID
             , ACC_NUM
             , KV
             , MATURITY_DATE
             , CUST_ID
             , REF
             , ND
             , BRANCH 
      from   (select t.*, p.ekp from (
                select 
                    t.seg_02 as T020,
                    t.seg_03 as R020,
                    t.seg_04 as R011,
                    t.seg_05 as K072,
                    t.seg_06 as R030,
                    t.seg_07 as S183,
                    t.seg_08 as S130,
                    t.seg_09 as K040,
                    t.seg_10 as S240,
                    t.seg_11 as Q003,
                    t.acc_num, 
                    t.kv,
                    t.field_code as kodp, 
                    t.nbuc, 
                    t.cust_id, 
                    t.acc_id, 
                    abs(to_number(trim(t.field_value))) as T100,
                    trim(t.description) as Q130,
                    t.ref,
                    t.description,
                    t.nd,
                    t.branch,
                    t.maturity_date
                from v_nbur_#07_dtl t
                where t.report_date = p_report_date and
                     t.kf = p_kod_filii and
                     t.seg_01 = '1' -- сума
                ) t  
                left join accounts a
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
                    p.r020 = t.R020 and
                    p.ekp like '%2') 
                where ekp <> 'A07F82' or
                      ekp = 'A07F82' and tip <> 'SNA'               
             );
             
   -- кількісні показники
   insert into nbur_log_f07X(report_date, kf, nbuc, version_id, ekp, ku, t020
             , r020, r011, k072, r030, s183, s130, k040, s240, t100, q130, q003, description
             , acc_id, acc_num, kv, maturity_date, cust_id, ref, nd, branch)
      select 
             p_report_date as report_date
             , p_kod_filii as kf
             , p_kod_filii as nbuc
             , l_version_id
             , nvl(ekp, c_XXXXXX) as ekp
             , f_get_ku_by_nbuc(nbuc) as KU
             , '#' as T020
             , '#' as R020
             , '#' as R011
             , K072
             , R030
             , (case when ekp = 'A07F51' then '#' else S183 end) as S183
             , S130
             , K040
             , '#' as S240
             , T100
             , Q130
             , Q003         
             , description
             , ACC_ID
             , ACC_NUM
             , KV
             , MATURITY_DATE
             , CUST_ID
             , REF
             , ND
             , BRANCH 
      from   (select t.*, p.ekp from (
                select 
                    t.seg_02 as T020,
                    t.seg_03 as R020,
                    '#' as R011,
                    t.seg_05 as K072,
                    t.seg_06 as R030,
                    t.seg_07 as S183,
                    t.seg_08 as S130,
                    t.seg_09 as K040,
                    '#' as S240,
                    t.seg_11 as Q003,
                    t.acc_num,
                    substr(t.acc_num, 1, 4) nbs,  
                    t.kv,
                    t.field_code as kodp, 
                    t.nbuc, 
                    t.cust_id, 
                    t.acc_id, 
                    to_number(trim(t.field_value)) as T100,
                    trim(t.description) as Q130,
                    t.ref,
                    t.description,
                    t.nd,
                    t.branch,
                    t.maturity_date
                from v_nbur_#07_dtl t
                where t.report_date = p_report_date and
                     t.kf = p_kod_filii  and
                     t.seg_01 = '3' -- кількість
                ) t  
                left join accounts a
                on (t.acc_id = a.acc)   
                left join
                    (select T.R020, max(t.i010) as i010 
                     from kl_r020 t 
                     where t.d_open < sysdate and (t.d_close is null or t.d_close > sysdate)
                     group by T.R020) t2 
                on (t.nbs = t2.R020)
                left join nbur_tmp_desc_ekp p
                on (p.I010 = t2.I010 and
                    p.t020 = t.t020 and
                    p.r020 = t.nbs  and
                    p.ekp like '%1')      
                where t.nbs not like '%9' or
                      t.r020 like '%9' and tip = 'SNA'           
             );
             
  logger.info(c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
END;
/
