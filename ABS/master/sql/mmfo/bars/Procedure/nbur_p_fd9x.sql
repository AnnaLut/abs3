
PROMPT ===================================================================================== 
PROMPT *** Run *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_FD9X.sql =========*** Run ***
PROMPT ===================================================================================== 

CREATE OR REPLACE PROCEDURE BARS.NBUR_P_FD9X (p_kod_filii  varchar2
                                            , p_report_date      date
                                            , p_form_id          number
                                            , p_scheme           varchar2 default 'C'
                                            , p_file_code        varchar2 default 'D9X')
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 DESCRIPTION :    Процедура формирования D9X
 COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.

 VERSION     :    v.19.001    12.02.2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: p_report_date - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_              char(30)  := ' v.19.001  12.02.2019';

  c_title           constant varchar2(100 char) := $$PLSQL_UNIT || '.';

  l_nbuc          varchar2(20);
  l_type          number;
  l_datez         date := p_report_date + 1;
  l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
  l_old_file_code varchar2(3) := '#D9';
  l_version       number;

  --Exception
  e_ptsn_not_exsts exception;

  pragma exception_init( e_ptsn_not_exsts, -02149 );
begin
  logger.info (c_title || ' begin for date = '||to_char(p_report_date, 'dd.mm.yyyy')||ver_);

  -- визначення початкових параметрів для формування файлу
  nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 0, l_file_code, l_nbuc, l_type);
  
  --Очистка партиции для хранения детального протокола
  begin
    execute immediate 'alter table NBUR_LOG_FD9X truncate subpartition for ( to_date('''
                      || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
  exception
    when e_ptsn_not_exsts then
      null;
  end; 

  -- очікуємо формування старого файлу
  nbur_waiting_form(p_kod_filii, p_report_date, l_old_file_code, c_title);
  
  select max(version_id)
  into l_version
  from v_nbur_#d9
  where report_date = p_report_date
    and kf = p_kod_filii;

  -- вставляємо з протоколу старого файлу
  insert
    into NBUR_LOG_FD9X
       (REPORT_DATE, KF, NBUC, VERSION_ID, EKP, Q003_1,
        K020_1, K021_1, Q001_1, Q029_1, K020_2, K021_2, Q001_2, Q029_2,
        K014, K040, KU_1, K110, T090_1A, T090_2A,
        CUST_ID, BRANCH)
  select p_report_date,  p_kod_filii,  p_kod_filii,  l_version
         , 'AD9001'                as EKP
         ,          rownum            Q003_1
         ,          u.k020_1          K020_1
         ,          u.k021_1          K021_1
         ,          u.nmk             Q001_1
         ,          null              Q029_1
         ,          u.k020_2          K020_2
         ,          u.k021_2          K021_2
         ,          c.q001_2          Q001_2
         ,          c.q029_2          Q029_2
         ,          (case
                       when c.k014 ='1' and c.k110 !='00000'  then '2'
                       when c.k014 ='1'                       then '3'
                        else           '1'
                     end)             K014
         ,          c.k040            K040
         ,          (case
                       when c.k040 !='804'              then '#'
                       when ltrim(c.ku_1,'0') is null   then '#'
                        else           ltrim(c.ku_1,'0')
                      end)            KU_1
         ,         c.k110             K110
         ,         nvl(c.t090_1,0)         T090_1a
         ,         nvl(c.t090_2,0)         T090_2a  
         ,         u.code_rnk+u.new_rnk    cust_id
         ,         u.branch                 branch
              from (
                   with cust_data as (
                          select cust_code, seg_02 K020_1, seg_04 K021_1,
                                 seg_03 K020_2, seg_05 K021_2, min(cust_id) code_rnk, count(*) code_cnt
                            from v_nbur_#d9_dtl
                           where report_date = p_report_date
                             and kf =p_kod_filii
                             and seg_01 ='205'
                           group by cust_code, seg_02, seg_03, seg_04, seg_05 
                                     )
                    select d.K020_1, d.K021_1, d.K020_2, d.K021_2, d.code_cnt,
                           d.code_rnk, 0 new_rnk, c.nmk, c.branch
                      from cust_data d, customer c
                     where code_cnt =1
                       and d.code_rnk = c.rnk
                       and c.kf =p_kod_filii
                    union
                    select d.K020_1, d.K021_1, d.K020_2, d.K021_2, code_cnt,
                           0 code_rnk, c.rnk new_rnk, c.nmk, c.branch
                      from cust_data d, customer c
                     where d.code_cnt >1
                       and c.rnk =( select min(rnk)
                                      from customer
                                     where okpo=d.cust_code and kf =p_kod_filii )
                   ) u,
                   (          select *
                                from ( select seg_01 ekp_1,
                                              seg_02 K020_1,  seg_03 K020_2,
                                              seg_04 K021_1,  seg_05 K021_2,
                                              field_value znap
                                         from v_nbur_#d9_dtl
                                        where report_date = p_report_date
                                          and kf = p_kod_filii
                                          and seg_01 not in ('010','019')
                                     )
                                      pivot
                                     ( max(trim(znap))
                                         for ekp_1 in ( '205' as Q001_2, '206' as K014,   '212' as T090_1, '213' as T090_2,
                                                        '219' as Q029_2, '225' as K110,   '250' as K040,   '255' as KU_1 )
                                      )
                   ) c
             where u.k020_1 = c.k020_1 and u.k020_2 = c.k020_2;

    commit;

   logger.info(c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_FD9X.sql =========*** End ***
PROMPT ===================================================================================== 

