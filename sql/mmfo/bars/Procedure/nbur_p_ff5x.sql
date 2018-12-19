
PROMPT ===================================================================================== 
PROMPT *** Run *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_FF5X.sql =========*** Run ***
PROMPT ===================================================================================== 

CREATE OR REPLACE PROCEDURE BARS.NBUR_P_FF5X (p_kod_filii  varchar2
                                            , p_report_date      date
                                            , p_form_id          number
                                            , p_scheme           varchar2 default 'C'
                                            , p_file_code        varchar2 default '#F5')
 IS
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 DESCRIPTION :    Процедура формирования F5X
 COPYRIGHT   :    Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.

 VERSION     :    v.18.001    29.10.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    параметры: p_report_date - отчетная дата
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_              char(30)  := 'v.18.001  29.10.2018';

  c_title           constant varchar2(100 char) := $$PLSQL_UNIT || '.';

  l_nbuc          varchar2(20);
  l_type          number;
  l_datez         date := p_report_date + 1;
  l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
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
    execute immediate 'alter table NBUR_LOG_FF5X truncate subpartition for ( to_date('''
                      || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
  exception
    when e_ptsn_not_exsts then
      null;
  end;
  
  --Определяем версию файла для хранения детального протокола (сели рабочей нет, то ставим -1)
  l_version := coalesce(f_nbur_get_run_version(
                                                p_file_code => p_file_code
                                                , p_kf => p_kod_filii
                                                , p_report_date => p_report_date
                                               )
                           , -1);
-------------------------------------------

  -- вставляємо з таблицi ручного вводу
  insert
    into NBUR_LOG_FF5X
       (REPORT_DATE, KF, NBUC, VERSION_ID, EKP, Z230, Z350,
                     K045, Z130, Z140, Z150, KU, T070, T080)
  select p_report_date, p_kod_filii, l_nbuc, l_version
         , EKP
         , decode(EKP, 'AF5002', '#', Z230)  as Z230
         , decode(EKP, 'AF5002', '#', Z350)  as Z350
         , decode(EKP, 'AF5002', '1', K045)  as K045
         , decode(EKP, 'AF5002', '#', Z130)  as Z130
         , decode(EKP, 'AF5002', '#', Z140)  as Z140
         , Z150
         , decode(EKP, 'AF5001', '#', ltrim(KU,'0'))  as KU
         , nvl(T070,0)         as T070
         , decode(EKP, 'AF5002', 0, T080)  as T080
    from nbur_kor_data_F5X 
   where report_date = p_report_date
     and kf =p_kod_filii;

    commit;

   logger.info(c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
end;
/


PROMPT ===================================================================================== 
PROMPT *** End *** ======== Scripts /Sql/BARS/Procedure/NBUR_P_FF5X.sql =========*** End ***
PROMPT ===================================================================================== 

