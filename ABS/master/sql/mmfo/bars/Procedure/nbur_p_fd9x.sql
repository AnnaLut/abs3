
PROMPT ===================================================================================== 
PROMPT *** Run *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_FD9X.sql =========*** Run ***
PROMPT ===================================================================================== 

CREATE OR REPLACE PROCEDURE BARS.NBUR_P_FD9X (p_kod_filii  varchar2
                                            , p_report_date      date
                                            , p_form_id          number
                                            , p_scheme           varchar2 default 'C'
                                            , p_file_code        varchar2 default '6BX')
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 DESCRIPTION :    Процедура формирования D9X
 COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.

 VERSION     :    v.18.001    09.10.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: p_report_date - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_              char(30)  := 'v.18.001  09.10.2018';

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
  logger.info (c_title || ' begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

  -- визначення початкових параметрів для формування файлу
  nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 1, l_file_code, l_nbuc, l_type);
  
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
        K014, K040, KU_1, K110, T090_1, T090_2,
        DESCRIPTION, KV, CUST_ID, BRANCH)
  select p_report_date, p_kod_filii, nvl(trim(e2.nbuc), l_nbuc), l_version
         , 'AD9001'                as EKP
         ,          rownum            Q003_1
         ,          e2.k020_1         K020_1
         ,          e2.k021_1         K021_1
         ,          e2.q001_1         Q001_1
         ,          e2.q029_1         Q029_1
         ,          e1.k020_2         K020_2
         ,          e1.k021_2         K021_2
         ,          e1.q001_2         Q001_2
         ,          e1.q029_2         Q029_2
         ,          (case
                       when e1.k014 ='1' and e1.k110 !='00000' then '2'
                       when e1.k014 ='1'                       then '3'
                        else         '1'
                     end)             K014
         ,          e1.k040           K040
         ,         decode(ltrim(e1.ku_1,'0'),null,'#',ltrim(e1.ku_1,'0')) 
                                     KU_1
         ,         e1.k110           K110
         ,         nvl(e1.t090_1,0)         T090_1
         ,         nvl(e1.t090_2,0)         T090_2  
         ,         description, kv, cust_id, branch
               from (
                  select *
                    from ( select nbuc, seg_01 ekp_1,
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
                    ) e1, (
                  select *
                    from ( select nbuc, seg_01 ekp_1,
                                  seg_02 K020_1,  seg_04 K021_1,
                                  field_value znap,
                                  description, kv, cust_id, branch
                             from v_nbur_#d9_dtl
                            where report_date = p_report_date
                              and kf = p_kod_filii
                              and seg_01 in ('010','019')
                         )
                          pivot             
                         ( max(trim(znap))
                             for ekp_1 in ( '010' as Q001_1, '019' as Q029_1 )
                         )
                    ) e2
              where e1.k020_1 = e2.k020_1 and e1.k021_1 = e2.k021_1
                and e1.nbuc = e2.nbuc ;

    commit;

   logger.info(c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_FD9X.sql =========*** End ***
PROMPT ===================================================================================== 

