PROMPT ===================================================================================== 
PROMPT *** Run *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_FE8X.sql ======== *** Run ***
PROMPT ===================================================================================== 

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
% VERSION     :  v.19.001   03.05.2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_                     char(30)  := 'v.19.001    03.05.2019';

  c_title                  constant varchar2(200 char) := $$PLSQL_UNIT;
  c_date_fmt               constant varchar2(10 char) := 'dd.mm.yyyy'; --Формат преобразования даты в строку
  c_amt_fmt                constant varchar2(50 char) := 'FM9999999999990D0000';  --Формат преобразования числа в строку

  l_datez                  date := p_report_date + 1;
  l_nbuc                   varchar2(20 char);
  l_file_code              varchar2(2 char) := substr(p_file_code, 2, 2);
  l_type                   number;
  
  c_old_file_code    constant varchar2(3 char) := '#E8';

  l_file_id       nbur_ref_files.id%type := nbur_files.GET_FILE_ID(p_file_code => p_file_code);
  l_version_id    nbur_lst_files.version_id%type;  
  
  l_last_q0_1     number          := 0;
  l_last_q0_12    number          := 0;

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

  logger.trace(c_title || ' version is ' || l_version_id);

  -- очікуємо формування старого файлу
  nbur_waiting_form(p_kod_filii, p_report_date, c_old_file_code, c_title);
  
  -- детальний протокол
  insert into nbur_log_fE8X
            (REPORT_DATE, KF, VERSION_ID, NBUC, KU, EKP, Q001, Q029, K074, K110, 
             K040, KU_1, Q020, K020, K014, R020, R030, Q003_1, Q003_2, Q007_1, Q007_2, 
             T070_1, T070_2, T070_3, T070_4, T090, Q003_12, K021, ACC_ID, ACC_NUM, KV, 
             CUST_ID, BRANCH)
    select REPORT_DATE, KF, VERSION_ID, NBUC, KU, EKP, Q001, Q029, K074, K110, 
           K040, KU_1, Q020, K020, 
           -- робимо перекодування, бо довідник відрізняєтьмя
           (case K014 when '1' then '3' when '2' then '1' when '3' then '2' else K014 end) as K014, 
           R020, R030, Q003_1, Q003_2, Q007_1, Q007_2, 
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
           d.r020, d.r030, c.q003_1, b.q003_2, b.q007_1, b.q007_2, 
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

    select to_number(nvl(max(Q003_1),'0'))
      into l_last_q0_1
      from nbur_log_fe8x
     where report_date = p_report_date
       and kf = p_kod_filii;

    select to_number(nvl(max(Q003_1),'0'))
      into l_last_q0_12
      from nbur_log_fe8x
     where report_date = p_report_date
       and kf = p_kod_filii;

--   депозиты ММСБ

  insert into nbur_log_fE8X
            (REPORT_DATE, KF, VERSION_ID, NBUC, KU,
             EKP, Q003_12, Q001, K020, K021, Q029, Q020, K040, KU_1, K014,
             K110, K074, Q003_1, Q003_2, Q007_1, Q007_2, R030, T090, R020, 
             T070_1, T070_2, T070_3, T070_4, ACC_ID, ACC_NUM, KV, CUST_ID, BRANCH)
select p_report_date, p_kod_filii, l_version_id, p_kod_filii, f_get_ku_by_nbuc(p_kod_filii) ku, 
       'AE8001'  as EKP,
       (row_number() over (order by k020_21, currency_id))+l_last_q0_12     as Q003_12, 
       nmk       as Q001,
       substr(k020_21,2,10)   as K020,
       substr(k020_21,1,1)    as K021,
       (case when length(substr(k020_21,2))>10  then substr(k020_21,2) 
             else null
         end)                 as Q029,
       lpad(to_char(prinsider),2,'0')              as Q020,
       lpad(to_char(country),3,'0')                as K040,
       lpad(to_char(obl),2,'0')                    as KU_1,
       (case custtype when 1 then '3'
                      when 2 then '1'
                      when 3 then '2' else to_char(custtype)
         end)                 as K014,
       ved                    as K110,
       K074,
       lpad(to_char(Q003_1),4,'0')    as Q003_1,
       to_char(contract_number)       as Q003_2,
       (case  when start_date  is null  then null
              else   to_char(start_date, c_date_fmt)
         end)                as Q007_1,
       (case  when end_date  is null  then null
              else   to_char(end_date, c_date_fmt)
         end)                as Q007_2,
       lpad(to_char(currency_id),3,'0')                as R030,
       to_char(T090,'99990.0000') as T090,  nbs   as R020,
       T070_1,   0   as T070_2,   0   as T070_3,   0   as T070_4,
       acc, nls, kv, rnk, 'депозит ММСБ'
from (
select c.nmk, f_nbur_get_k020_by_rnk(c.rnk) k020_21, c.prinsider, c.country,
       b.obl, c.custtype, c.ved, k.k074, a.contract_number, a.start_date,
       a.end_date, a.currency_id, round(int_rate, 4)  as T090,
       e.nbs, a.deposit_amount as T070_1,
       e.acc, e.nls, e.kv, c.rnk, c.branch,
       (row_number() over (order by a.contract_number, e.acc))+l_last_q0_1   as Q003_1
  from (
        select   account_id                     
               , account_number                 
               , currency_id                    
               , currency_name                  
               , contract_number                
               , start_date                     
               , end_date                       
               , deposit_amount                 
               , round(interest_rate, 4)   int_rate     
               , customer_id                    
               , report_date                    
          from table(smb_calculation_deposit.get_report_e8(p_date => p_report_date))
       ) a, customer c, branch b, kl_k070 k, accounts e
 where a.customer_id = c.rnk
   and c.branch = b.branch
   and c.ise = k.k070
   and a.account_id = e.acc
     );

  logger.info (c_title || ' end for date = '||to_char(p_report_date, c_date_fmt));
END NBUR_P_FE8X;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_FE8X.sql ======== *** End ***
PROMPT ===================================================================================== 