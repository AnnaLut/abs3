
PROMPT ===================================================================================== 
PROMPT *** Run *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_F3BX.sql =========*** Run ***
PROMPT ===================================================================================== 

CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F3BX (p_kod_filii  varchar2
                                            , p_report_date      date
                                            , p_form_id          number
                                            , p_scheme           varchar2 default 'C'
                                            , p_file_code        varchar2 default '3BX')
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 DESCRIPTION :    Процедура формирования 3BX
 COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.

 VERSION     :    v.18.001    13.11.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: p_report_date - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_              char(30)  := 'v.18.001  26.10.2018';

  c_title           constant varchar2(100 char) := $$PLSQL_UNIT || '.';

  l_nbuc          varchar2(20);
  l_type          number;
  l_datez         date := p_report_date + 1;
  l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
  l_old_file_code varchar2(3) := '#3B';
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
    execute immediate 'alter table NBUR_LOG_F3BX truncate subpartition for ( to_date('''
                      || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
  exception
    when e_ptsn_not_exsts then
      null;
  end;
  
  -- очікуємо формування старого файлу
  nbur_waiting_form(p_kod_filii, p_report_date, l_old_file_code, c_title);
  
  select max(version_id)
  into l_version
  from v_nbur_#3B
  where report_date = p_report_date and
        kf = p_kod_filii;

  -- вставляємо з протоколу старого файлу
  insert
    into NBUR_LOG_F3BX
       (REPORT_DATE, KF, nbuc, version_id, EKP, T100, F059, F060, F061, 
       K111, K031, F063, F064, S190, F073, F003, Q001, 
       K020, Q026, description, cust_id, branch)
  select p_report_date, p_kod_filii, nvl(trim(nbuc), l_nbuc), version_id, 
   EKP, round(T100,3) as T100, F059, F060, F061, K111, K031, F063, F064, S190, F073, 
   F003, Q001, K020, Q026, description, cust_id, branch
  from (
        with data_3bx as 
        (
           select nbuc
                , version_id
                , seg_01 --Q001(seg_01=01), K110(02), S190(03), F063(04), F064(06), K031(05), Q026(07),F073(08), F003(11)
                , seg_02 --F059(P)
                , seg_03 --F060(M)
                , nvl(n.f061,seg_04) as F061
                , n.ekpxml           as EKP
                , seg_06 --K020(ZZZZZZZZZZ)
                , field_value --T100
                , description 
                , cust_id
                , branch
             from v_nbur_#3b_dtl v
        left join NBUR_REF_EKP_3BX n
               on substr(v.seg_05,2,4)=n.zkp
              and v.seg_04=n.f061
            where report_date = p_report_date
              and kf = p_kod_filii
       ) --end with
        select nbuc
             , version_id
             , EKP
             , (case EKP       when 'A3B001'  then LL09   else LL10    end)    as T100    
             , seg_02                                                          as F059
             , (case EKP       when 'A3B001'  then '#'    else seg_03  end)    as F060
             , (case F061      when '0'       then '#'    else F061    end)    as F061
             , (case EKP       when 'A3B001'  then LL02   else '#'     end)    as K111
             , (case EKP       when 'A3B001'  then LL05   else '#'     end)    as K031
             , (case EKP       when 'A3B001'  then LL04   else '#'     end)    as F063
             , (case EKP       when 'A3B001'  then LL06   else '#'     end)    as F064
             , (case EKP       when 'A3B001'  then LL03   else '#'     end)    as S190
             , (case EKP       when 'A3B001'  then LL08   else '#'     end)    as F073
             , (case EKP       when 'A3B001'  then '0'    else '#'     end)    as F003
             , (case EKP       when 'A3B001'  then LL01   else null    end)    as Q001
             , LPAD(seg_06,10,'0')                                             as K020
             , (case EKP       when 'A3B001'  then LL07   else null    end)    as Q026
             , description 
             , cust_id
             , branch            
          from data_3bx
        pivot (
                 max(field_value)
                 for seg_01 in ('01' as LL01, '02' as LL02, '03' as LL03, '04' as LL04,
                                '05' as LL05, '06' as LL06, '07' as LL07, '08' as LL08,
                                '09' as LL09, '10' as LL10, '11' as LL11)
              )
        );

    commit;

   logger.info(c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_F3BX.sql =========*** End ***
PROMPT ===================================================================================== 

