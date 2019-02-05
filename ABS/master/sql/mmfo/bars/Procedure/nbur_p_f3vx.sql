
PROMPT ===================================================================================== 
PROMPT *** Run *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_F3VX.sql =========*** Run ***
PROMPT ===================================================================================== 

CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F3VX (p_kod_filii  varchar2
                                            , p_report_date      date
                                            , p_form_id          number
                                            , p_scheme           varchar2 default 'C'
                                            , p_file_code        varchar2 default '3VX')
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 DESCRIPTION :    Процедура формирования 3VX
 COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.

 VERSION     :    v.18.002    30.01.2019(26.10.2018)
30.01.2019	параметр S190 з файлу #3v (раніше вираховувався в залежності від терміну)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: p_report_date - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_              char(30)  := 'v.18.001  26.10.2018';

  c_title           constant varchar2(100 char) := $$PLSQL_UNIT || '.';

  l_nbuc          varchar2(20);
  l_type          number;
  l_datez         date := p_report_date + 1;
  l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
  l_old_file_code varchar2(3) := '#3V';
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
    execute immediate 'alter table NBUR_LOG_F3VX truncate subpartition for ( to_date('''
                      || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
  exception
    when e_ptsn_not_exsts then
      null;
  end;
  
  -- очікуємо формування старого файлу
  nbur_waiting_form(p_kod_filii, p_report_date, l_old_file_code, c_title);
  
  select max(version_id)
  into l_version
  from v_nbur_#3V
  where report_date = p_report_date and
        kf = p_kod_filii;

  -- вставляємо з протоколу старого файлу
  insert
    into NBUR_LOG_F3VX
       (REPORT_DATE, KF, nbuc, version_id, EKP, F059,
       K111, K031, F063, F064, S190, F073, F003, Q001, 
       K020, Q026, T100, description, cust_id, branch)
    select     p_report_date, p_kod_filii, nvl(trim(nbuc), l_nbuc), version_id
             , 'A3V001'       as EKP
             , seg_02         as F059
             , NVL(LL02,'#')  as K111
             , NVL(LL05,'#')  as K031
             , NVL(LL04,'#')  as F063
             , NVL(LL06,'#')  as F064
/*             , case 
                    when LL03 = 0                 then '0'
                    when LL03 between 1   and 7   then 'A'
                    when LL03 between 8   and 30  then 'B'
                    when LL03 between 31  and 60  then 'C'
                    when LL03 between 61  and 90  then 'D'
                    when LL03 between 91  and 180 then 'E'
                    when LL03 between 181 and 360 then 'F'
                    when LL03 > 360               then 'G'
                    else '#'
               end  S190
*/	     
             , NVL(LL03,'#')  as S190
             , NVL(LL08,'#')  as F073
             , NVL(LL11,'#')  as F003
             , NVL(LL01,' ')  as Q001
             , seg_03         as K020
             , NVL(LL07,'0')  as Q026
             , NVL(LL09,0)    as T100
             , description , cust_id , branch
          from (      select nbuc
                           , version_id
                           , seg_01
                           , seg_02
                           , seg_03
                           , field_value
                           , description 
                           , cust_id
                           , branch
                        from v_nbur_#3v_dtl 
	               where report_date = p_report_date
                         and kf = p_kod_filii 
                )
         pivot (
                 max(field_value) 
                 for seg_01 in ('01' as LL01, '02' as LL02, '03' as LL03, '04' as LL04,
                                '05' as LL05, '06' as LL06, '07' as LL07, '08' as LL08,
                                '09' as LL09, '11' as LL11)
               );
    commit;

   logger.info(c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_F3VX.sql =========*** End ***
PROMPT ===================================================================================== 

