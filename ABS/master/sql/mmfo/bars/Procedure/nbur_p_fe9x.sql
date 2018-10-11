CREATE OR REPLACE PROCEDURE BARS.NBUR_P_FE9X (p_kod_filii  varchar2
                                            , p_report_date      date
                                            , p_form_id          number
                                            , p_scheme           varchar2 default 'C'
                                            , p_file_code        varchar2 default 'E9X')
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    Процедура формирования #E9 для схема "C"
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :    07/09/2018 (27/07/2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: p_report_date - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_              char(30)  := 'v.1.003  07/09/2018';

  c_title           constant varchar2(100 char) := $$PLSQL_UNIT || '.';

  l_nbuc          varchar2(20);
  l_type          number;
  l_datez         date := p_report_date + 1;
  l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
  l_old_file_code varchar2(3) := '#E9';
  l_version_id    number;

  --Exception
  e_ptsn_not_exsts exception;

  pragma exception_init( e_ptsn_not_exsts, -02149 );
begin
  logger.info (c_title || ' begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

  -- визначення початкових параметрів для формування файлу
  nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 1, l_file_code, l_nbuc, l_type);
  
  --Очистка партиции для хранения детального протокола
  begin
    execute immediate 'alter table NBUR_LOG_FE9X truncate subpartition for ( to_date('''
                      || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
  exception
    when e_ptsn_not_exsts then
      null;
  end;
  
  l_version_id := f_nbur_get_run_version(
                                          p_file_code => p_file_code
                                          , p_kf => p_kod_filii
                                          , p_report_date => p_report_date
                                        );

  -- очікуємо формування старого файлу
  nbur_waiting_form(p_kod_filii, p_report_date, l_old_file_code, c_title);

  select max(version_id)
  into l_version
  from v_nbur_#e9
  where report_date = p_report_date and
        kf = p_kod_filii;

  -- вставляємо з протоколу старого файлу
  insert
    into NBUR_LOG_FE9X
       (REPORT_DATE, KF, NBUC, VERSION_ID, EKP, 
        D060_1, K020, K021, F001, F098, R030, K040_1, KU_1, 
        K040_2, KU_2, T071, T080, D060_2, Q001, DESCRIPTION, 
        ACC_ID, ACC_NUM, KV, CUST_ID, REF, BRANCH)
  select p_report_date, p_kod_filii, nvl(trim(nbuc), l_nbuc), version_id, 
                (case 
                 when ekp_3 = '42' or ekp_2='1' and ekp_9 ='804' and ekp_11 in ('804', '000') 
                      then 'AE9001'
                 when ekp_2='1' and ekp_9 <> '804' and ekp_11 in ('804', '000') 
                      then 'AE9002'
                 when ekp_2='1' and ekp_3 <> '42' and ekp_9 ='804' and ekp_11 <> '804' 
                      then 'AE9003'
                 when ekp_2='2' and ekp_9 <> '804' and ekp_11 ='804' and d060_2 is not null 
                      then 'AE9004'
                 when ekp_2='2' and ekp_9!='804' and ekp_11 ='804' 
                      then 'AE9005'
                 when ekp_2='2' and ekp_9 ='804' and ekp_11!='804' and d060_2 is not null 
                      then 'AE9006'
                 when ekp_2='2' and ekp_9 ='804' and ekp_11!='804'   
                      then 'AE9007'
                 when ekp_2='0'                                      
                      then 'AE9008'
                      else 'AE9000'
                 end) as ekp,
           ekp_3   as d060_1,
           ekp_6   as k020,
           ekp_5   as k021,
           ekp_4   as f001,
           '#'     as f098,
           decode(ekp_8,'000','#',ekp_8)             as r030,
           decode(ekp_9,'000','#',ekp_9)             as k040_1,
           decode(ekp_10,'000','#',ltrim(ekp_10,'0'))  as ku_1,
           decode(ekp_11,'000','#',ekp_11)             as k040_2,
           decode(ekp_12,'000','#',ltrim(ekp_12,'0'))  as ku_2,
           t071                as t071,
           t080                as t080,
           decode(d060_2, null,'#', d060_2)  d060_2,
           q001, description, acc_id, acc_num, kv, cust_id, ref, branch
      from (select substr(ekp_2,1,1) ekp_2
                 , substr(ekp_2,2,2) ekp_3  -- код системи переказів
                 , substr(ekp_2,4,1) ekp_4
                 , substr(ekp_2,5,1) ekp_5
                 , substr(ekp_2,6,10) ekp_6  -- ekp_7 немає в коді ekp_2
                 , substr(ekp_2,16,3) ekp_8  -- код валюти
                 , substr(ekp_2,19,3) ekp_9  -- код країни відправника
                 , substr(ekp_2,22,3) ekp_10 -- код регіону відправника
                 , substr(ekp_2,25,3) ekp_11 -- код країни отримувача
                 , substr(ekp_2,28,3) ekp_12 -- код регіону отримувача
                 , nvl(t071,0)   t071
                 , nvl(t080,0)   t080
                 , d060_2
                 , q001  
                 , nbuc
                 , version_id  
                 , description 
                 , acc_id
                 , acc_num
                 , kv
                 , cust_id
                 , ref
                 , branch
           from (select nbuc
                       , l_version_id as version_id
                       , substr(substr(field_code,1,16)||substr(field_code,19),1,1) ekp_1
                       , substr(substr(field_code,1,16)||substr(field_code,19),2) ekp_2
                       , field_value
                       , description 
                       , acc_id
                       , acc_num
                       , kv
                       , cust_id
                       , ref
                       , branch
                  from v_nbur_#e9_dtl
                  where report_date = p_report_date and
                        kf = p_kod_filii
                  union all
                  select nbuc
                       , l_version_id
                       , substr(field_code,1,1) ekp_1
                       , substr(field_code,2) ekp_2
                       , field_value
                       , description 
                       , null acc_id
                       , null acc_num
                       , null kv
                       , null cust_id
                       , null ref
                       , branch
                  from (with d060_not_work as (
                                     select d060k030, d060, txt
                                       from kl_d060
                                      where d060 in ( select d060
                                                        from kl_fe9
                                                       where nvl(pr_del, 1) <> 0
                                                         and kf =p_kod_filii
                                                       group by d060
                                                       minus
                                                       select substr(field_code,3,2) d060
                                                         from v_nbur_#e9_dtl
                                                         where report_date = p_report_date and
                                                               kf = p_kod_filii
                                                        group by substr(field_code,3,2)    )
                                        and d_close is null
                              )
                        select p_report_date, p_kod_filii, p_file_code,
                               (select obl from branch where branch='/'||p_kod_filii||'/') nbuc,
                               '1'||'0'||d060_not_work.d060||'1'||'3'||'0000000006'||
                                (case when d060_not_work.d060k030='1' then '980' else '000' end)||         -- r030
                               '804'||'000'||
                                (case when d060_not_work.d060k030='1' then '804' else '000' end)||'000' field_code, '0' field_value, 
                                'D060 '||d060_not_work.D060||' '||d060_not_work.TXT||' не приймали участь'  description, p_kod_filii branch
                          from d060_not_work
                        union
                        select p_report_date, p_kod_filii, p_file_code,
                               (select obl from branch where branch='/'||p_kod_filii||'/') nbuc,
                               '3'||'0'||d060_not_work.d060||'1'||'3'||'0000000006'||
                                (case when d060_not_work.d060k030='1' then '980' else '000' end)||         -- r030
                               '804'||'000'||
                                (case when d060_not_work.d060k030='1' then '804' else '000' end)||'000' field_code, '0' field_value, 
                                'D060 '||d060_not_work.D060||' '||d060_not_work.TXT||' не приймали участь' description, p_kod_filii branch
                          from d060_not_work)
       )
       pivot(max(trim(field_value))
             for ekp_1 in ( '1' as T071, '3' as T080,
                            '8' as D060_2, '9' as Q001 )
             )
       );
    commit;

   logger.info(c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
end;
/

