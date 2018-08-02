CREATE OR REPLACE PROCEDURE BARS.NBUR_P_FE9X (p_kod_filii  varchar2
                                            , p_report_date      date
                                            , p_form_id          number
                                            , p_scheme           varchar2 default 'C'
                                            , p_file_code        varchar2 default 'E9X')
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION :    Процедура формирования #E9 для схема "C"
% COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
% VERSION     :   27/07/2018 (17.05.2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: p_report_date - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_              char(30)  := 'v.1.002  25/07/2018';
  
  c_title           constant varchar2(100 char) := $$PLSQL_UNIT || '.';
  
  l_nbuc          varchar2(20);
  l_type          number;
  l_datez         date := p_report_date + 1;
  l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
  l_old_file_code varchar2(3) := '#E9';

begin
  logger.info (c_title || ' begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

  -- визначення початкових параметрів для формування файлу
  nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 1, l_file_code, l_nbuc, l_type);

  -- очікуємо формування старого файлу
  nbur_waiting_form(p_kod_filii, p_report_date, l_old_file_code, c_title);    
  
  -- вставляємо з протоколу старого файлу
  insert
    into NBUR_DETAIL_PROTOCOLS
       ( REPORT_DATE, KF, REPORT_CODE, NBUC,
         FIELD_CODE,
         FIELD_VALUE, DESCRIPTION
       , ACC_ID, ACC_NUM, KV, MATURITY_DATE, CUST_ID, REF, ND, BRANCH )
  select p_report_date, p_kod_filii, p_file_code, nvl(trim(nbuc), l_nbuc),
         substr(field_code,1,16)||substr(field_code,19),
         nvl(field_value, ' '), description, acc_id, acc_num, kv, 
         maturity_date, cust_id, ref, nd, branch
    from v_nbur_#e9_dtl
    where report_date = p_report_date and
          kf = p_kod_filii;
    commit;
     
    insert
    into NBUR_DETAIL_PROTOCOLS
       ( REPORT_DATE, KF, REPORT_CODE, NBUC,
         FIELD_CODE,
         FIELD_VALUE, DESCRIPTION, branch )
      with d060_not_work as (
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
                (case when d060_not_work.d060k030='1' then '804' else '000' end)||'000',
               '0', 'D060 '||d060_not_work.D060||' '||d060_not_work.TXT||' не приймали участь', p_kod_filii 
          from d060_not_work 
        union
        select p_report_date, p_kod_filii, p_file_code,
               (select obl from branch where branch='/'||p_kod_filii||'/') nbuc,
               '3'||'0'||d060_not_work.d060||'1'||'3'||'0000000006'||
                (case when d060_not_work.d060k030='1' then '980' else '000' end)||         -- r030
               '804'||'000'||
                (case when d060_not_work.d060k030='1' then '804' else '000' end)||'000',
               '0', 'D060 '||d060_not_work.D060||' '||d060_not_work.TXT||' не приймали участь', p_kod_filii 
          from d060_not_work  ;
      commit;

      insert
        into NBUR_AGG_PROTOCOLS
           ( REPORT_DATE, KF, REPORT_CODE, NBUC, FIELD_CODE, FIELD_VALUE )
      select p_report_date, p_kod_filii, p_file_code,
             nbuc, FIELD_CODE,
             SUM(to_number(FIELD_VALUE))
       from NBUR_DETAIL_PROTOCOLS
      group by nbuc, FIELD_CODE;

      commit;

   logger.info(c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
end;
/
show err;
