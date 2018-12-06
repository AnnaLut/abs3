
PROMPT ===================================================================================== 
PROMPT *** Run *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_F95X.sql =========*** Run ***
PROMPT ===================================================================================== 

CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F95X (p_kod_filii  varchar2
                                            , p_report_date      date
                                            , p_form_id          number
                                            , p_scheme           varchar2 default 'C'
                                            , p_file_code        varchar2 default '95X')
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 DESCRIPTION :    Процедура формирования 95X
 COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.

 VERSION     :    v.18.001    06.11.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: p_report_date - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_              char(30)  := 'v.18.001  26.10.2018';

  c_title           constant varchar2(100 char) := $$PLSQL_UNIT || '.';

  l_nbuc          varchar2(20);
  l_type          number;
  l_datez         date := p_report_date + 1;
  l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
  l_old_file_code varchar2(3) := '#95';
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
    execute immediate 'alter table NBUR_LOG_F95X truncate subpartition for ( to_date('''
                      || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
  exception
    when e_ptsn_not_exsts then
      null;
  end;
  
  -- очікуємо формування старого файлу
  nbur_waiting_form(p_kod_filii, p_report_date, l_old_file_code, c_title);
  
  select max(version_id)
  into l_version
  from v_nbur_#95
  where report_date = p_report_date and
        kf = p_kod_filii;

  -- вставляємо з протоколу старого файлу
  insert
    into NBUR_LOG_F95X
       (REPORT_DATE, KF, nbuc, version_id, EKP,K030,F051,K020,
       Q001,Q002,Q003,Q007,T070,T090_1,T090_2,T090_3,T090_4, 
       description, branch)
        select p_report_date, p_kod_filii, nvl(trim(nbuc), l_nbuc)
             , version_id
             , 'A95001'                      as  EKP
             , DD04                          as  K030
             , DD06                          as  F051
             , to_char(DD03,'fm0000000000')  as  K020
             , nvl(DD01,'не визначено')      as  Q001
             , DD02                          as  Q002
             , nvl(seg_02,'не визначено')    as  Q003
             , to_date(DD05,'ddmmyyyy')      as  Q007
             , nvl(DD07,0)                   as  T070
             , nvl(DD08,0)                   as  T090_1
             , nvl(DD09,0)                   as  T090_2
             , nvl(DD10,0)                   as  T090_3
             , nvl(DD11,0)                   as  T090_4
             , branch
             , description
          from (select  nbuc
                      , version_id
                      , seg_01
                      , seg_02
                      , field_value
                      , null as branch
                      , null as description
                   from v_nbur_#95 v
	               where report_date = p_report_date
                         and kf = p_kod_filii 
                )
          pivot (
                    max(field_value) 
                    for seg_01 in ('01' as DD01, '02' as DD02, '03' as DD03, '04' as DD04,
                                   '05' as DD05, '06' as DD06, '07' as DD07, '08' as DD08,
                                   '09' as DD09, '10' as DD10, '11' as DD11)
                );
    commit;

   logger.info(c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_F95X.sql =========*** End ***
PROMPT ===================================================================================== 

