
PROMPT ===================================================================================== 
PROMPT *** Run *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_F6GX.sql =========*** Run ***
PROMPT ===================================================================================== 

CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F6GX (p_kod_filii  varchar2
                                            , p_report_date      date
                                            , p_form_id          number
                                            , p_scheme           varchar2 default 'C'
                                            , p_file_code        varchar2 default '#6G')
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 DESCRIPTION :    Процедура формирования 6GX
 COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.

 VERSION     :    v.18.003    14.02.2019 (05.12.2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: p_report_date - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
14.02.2019	виправлено помилку з населенням VERSION_ID, VERSION_D8
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_              char(30)  := 'v.18.003  14.02.2019';

  c_title           constant varchar2(100 char) := $$PLSQL_UNIT || '.';

  l_nbuc          varchar2(20);
  l_type          number;
  l_datez         date := p_report_date + 1;
  l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
  l_old_file_code varchar2(3) := '#D8';
  l_version       number;
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
    execute immediate 'alter table NBUR_LOG_F6GX truncate subpartition for ( to_date('''
                      || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
  exception
    when e_ptsn_not_exsts then
      null;
  end;
  
  -- очікуємо формування старого файлу
--  nbur_waiting_form(p_kod_filii, p_report_date, l_old_file_code, c_title);
  
  select max(version_id)
  into l_version
  from v_nbur_#D8
  where report_date = p_report_date and
        kf = p_kod_filii;

  --Определяем версию файла для хранения детального протокола
  l_version_id := f_nbur_get_run_version(p_file_code => p_file_code
                                          , p_kf => p_kod_filii
                                          , p_report_date => p_report_date
                                        );

  -- вставляємо з протоколу старого файлу
  insert
    into NBUR_LOG_F6GX
       (REPORT_DATE, KF, NBUC, VERSION_ID, VERSION_D8, EKP,K020,K021,Q003_2, Q003_3, Q007, B040, T070_1,
    DESCRIPTION,KV,CUST_ID,CUST_CODE,CUST_NAME,ND,AGRM_NUM,BEG_DT,END_DT,BRANCH)
  select p_report_date, p_kod_filii, nvl(trim(nbuc), l_nbuc), l_version_id, version_id 
        , 'A6G001'  as  EKP
        , LPAD(K020,10,'0')   as  K020 
        , K021
        , Q003_2
        , Q003_3
        , to_date(Q007,'ddmmyyyy')  as Q007
        , LPAD('00626804'||B040,20,'0')         as B040
        , NVL(T070_1,0)             as T070_1
        , DESCRIPTION
        , KV
        , CUST_ID
        , CUST_CODE
        , CUST_NAME
        , ND
        , AGRM_NUM
        , BEG_DT
        , END_DT
        , BRANCH
   from (select   nbuc
                , version_id
                , seg_01             -- DDD ('086'=T070_1, '090'=Q003_3, '091'=B040, '092'=Q007)
                , seg_02  as  K020   -- ZZZZZZZZZZ (K020)
                , seg_03  as  Q003_2 -- NNNN (Q003_2)
                , seg_07  as  K021   -- A (K021)
                , FIELD_VALUE
                , DESCRIPTION
                , KV
                , CUST_ID
                , CUST_CODE
                , CUST_NAME
                , ND
                , AGRM_NUM
                , BEG_DT
                , END_DT
                , BRANCH
           from V_NBUR_#D8_dtl v
          where report_date = p_report_date
            and kf = p_kod_filii
            and seg_01 in ('086','090','091','092')
        )
 pivot (
       max(field_value)
       for seg_01 in ('086' as T070_1, '090' as Q003_3, '091' as B040, '092' as Q007) 
       );

    commit;

   logger.info(c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_F6GX.sql =========*** End ***
PROMPT ===================================================================================== 

