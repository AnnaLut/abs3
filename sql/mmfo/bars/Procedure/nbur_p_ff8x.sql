
PROMPT ===================================================================================== 
PROMPT *** Run *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_FF8X.sql =========*** Run ***
PROMPT ===================================================================================== 

CREATE OR REPLACE PROCEDURE BARS.NBUR_P_FF8X (p_kod_filii  varchar2
                                            , p_report_date      date
                                            , p_form_id          number
                                            , p_scheme           varchar2 default 'C'
                                            , p_file_code        varchar2 default 'F8X')
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 DESCRIPTION :    Процедура формирования F8X
 COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.

 VERSION     :    v.18.001    30.10.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: p_report_date - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_              char(30)  := 'v.18.001  30.10.2018';

  c_title           constant varchar2(100 char) := $$PLSQL_UNIT || '.';

  l_nbuc          varchar2(20);
  l_type          number;
  l_datez         date := p_report_date + 1;
  l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
  l_old_file_code varchar2(3) := '#F8';
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
    execute immediate 'alter table NBUR_LOG_FF8X truncate subpartition for ( to_date('''
                      || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
  exception
    when e_ptsn_not_exsts then
      null;
  end;
  
  -- очікуємо формування старого файлу
  nbur_waiting_form(p_kod_filii, p_report_date, l_old_file_code, c_title);
  
  select max(version_id)
  into l_version
  from v_nbur_#f8
  where report_date = p_report_date
    and kf = p_kod_filii;

  -- вставляємо з протоколу старого файлу
  insert
    into NBUR_LOG_FF8X
        ( REPORT_DATE, KF, NBUC, VERSION_ID,
           EKP, F034, F035, R030, S080, K111, S260, S032, S245, T100,      
            DESCRIPTION, ACC_ID, ACC_NUM, KV, CUST_ID, CUST_CODE, CUST_NAME, 
             ND, AGRM_NUM, BEG_DT, END_DT, BRANCH )
  select p_report_date, p_kod_filii, nvl(trim(v.nbuc), l_nbuc), l_version
         , 'AF8001'             as EKP
         ,  v.SEG_01              as F034
         ,  v.SEG_02              as F035
         ,  v.SEG_08              as R030
         ,  v.SEG_06              as S080
         ,  v.SEG_03              as K111
         ,  v.SEG_04              as S260
         ,  v.SEG_05              as S032
         ,  v.SEG_09              as S245
         ,  v.FIELD_VALUE         as T100
         ,  v.DESCRIPTION
         ,  (case
                when v.acc_id is null  and  v.acc_num is not null
                  then  nvl((select acc from accounts where nls=v.acc_num and kv =v.kv),'')
                else v.acc_id
              end)             as ACC_ID
         ,  v.ACC_NUM, v.KV, v.CUST_ID, v.CUST_CODE, v.CUST_NAME, 
            v.ND, v.AGRM_NUM, v.BEG_DT, v.END_DT, v.BRANCH
    from  v_nbur_#f8_dtl v
   where report_date = p_report_date
     and kf = p_kod_filii;

    commit;

   logger.info(c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_FF8X.sql =========*** End ***
PROMPT ===================================================================================== 

