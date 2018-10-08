
PROMPT ===================================================================================== 
PROMPT *** Run *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_F6BX.sql =========*** Run ***
PROMPT ===================================================================================== 

CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F6BX (p_kod_filii  varchar2
                                            , p_report_date      date
                                            , p_form_id          number
                                            , p_scheme           varchar2 default 'C'
                                            , p_file_code        varchar2 default '6BX')
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 DESCRIPTION :    Процедура формирования 6BX
 COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.

 VERSION     :    v.18.001    02.10.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: p_report_date - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_              char(30)  := 'v.18.001  02.10.2018';

  c_title           constant varchar2(100 char) := $$PLSQL_UNIT || '.';

  l_nbuc          varchar2(20);
  l_type          number;
  l_datez         date := p_report_date + 1;
  l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
  l_old_file_code varchar2(3) := '#6B';
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
    execute immediate 'alter table NBUR_LOG_F6BX truncate subpartition for ( to_date('''
                      || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
  exception
    when e_ptsn_not_exsts then
      null;
  end;
  
  -- очікуємо формування старого файлу
  nbur_waiting_form(p_kod_filii, p_report_date, l_old_file_code, c_title);
  
  select max(version_id)
  into l_version
  from v_nbur_#6b
  where report_date = p_report_date and
        kf = p_kod_filii;

  -- вставляємо з протоколу старого файлу
  insert
    into NBUR_LOG_F6BX
       (REPORT_DATE, KF, NBUC, VERSION_ID, EKP, 
        F083, F082, S083, S080, S031, K030, R030, T070,
        DESCRIPTION, ACC_ID, ACC_NUM, KV, CUST_ID, REF, BRANCH)
  select p_report_date, p_kod_filii, nvl(trim(nbuc), l_nbuc), version_id, 
                (case 
                     when seg_01 ='111'          then 'A6B001'
                     when seg_01 ='120'          then 'A6B002'
                     when seg_01 ='121'          then 'A6B003'
                     when seg_01 ='122'          then 'A6B004'
                     when seg_01 ='130'          then 'A6B005'
                     when seg_01 ='131'          then 'A6B006'
                     when seg_01 ='132'          then 'A6B007'
                     when seg_01 ='133'          then 'A6B008'
                     when seg_01 ='135'          then 'A6B009'
                     when seg_01 ='136'          then 'A6B010'
                     when seg_01 ='137'          then 'A6B011'
                     when seg_01 ='138'          then 'A6B012'
                     when seg_01 ='150'          then 'A6B013'
                     when seg_01 ='151'          then 'A6B014'
                     when seg_01 ='152'          then 'A6B015'
                     when seg_01 ='153'          then 'A6B016'
                     when seg_01 ='161'          then 'A6B017'
                     when seg_01 ='210'          then 'A6B018'
                     when seg_01 ='211'          then 'A6B019'
                     when seg_01 ='212'          then 'A6B020'
                     when seg_01 ='213'          then 'A6B021'
                     when seg_01 ='214'          then 'A6B022'
                     when seg_01 ='215'          then 'A6B023'
                     when seg_01 ='219'          then 'A6B024'
                     else     'A6B000'
                 end)              as EKP
         , seg_02                  as F083
         , seg_03                  as F082
         , seg_04                  as S083
         , seg_05                  as S080
         , seg_06                  as S031
         , seg_07                  as K030
         , seg_08                  as R030
         , field_value             as T070
         , description, acc_id, acc_num, kv, cust_id, ref, branch
      from (      select nbuc
                       , version_id
                       , seg_01
                       , seg_02
                       , seg_03
                       , seg_04
                       , seg_05
                       , seg_06
                       , seg_07
                       , seg_08
                       , field_value
                       , description 
                       , acc_id
                       , acc_num
                       , kv
                       , cust_id
                       , ref
                       , branch
                  from v_nbur_#6b_dtl
                  where report_date = p_report_date and
                        kf = p_kod_filii
            );

    commit;

   logger.info(c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_F6BX.sql =========*** End ***
PROMPT ===================================================================================== 

