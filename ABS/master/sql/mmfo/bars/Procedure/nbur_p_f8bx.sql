PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F8BX.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  procedure NBUR_P_F8BX ***

CREATE OR REPLACE PROCEDURE NBUR_P_F8BX (
                                           p_kod_filii  varchar2
                                           , p_report_date      date
                                           , p_form_id          number
                                           , p_scheme           varchar2 default 'C'
                                           , p_file_code        varchar2 default '8BX'
                                      )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования 8BX в формате XML для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.18.002    24/01/2019
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_                     char(30)  := 'v.18.002    24/01/2019';

  c_title                  constant varchar2(200 char) := $$PLSQL_UNIT;
  c_date_fmt               constant varchar2(10 char) := 'dd.mm.yyyy'; --Формат преобразования даты в строку
  c_amt_fmt                constant varchar2(50 char) := 'FM9999999999990D0000';  --Формат преобразования числа в строку
  
  c_EKPOK1                 constant varchar2(6 char) := 'A8B001'; 
  c_EKPOK2                 constant varchar2(6 char) := 'A8B002'; 

  l_datez                  date := p_report_date + 1;
  l_nbuc                   varchar2(20 char);
  l_file_code              varchar2(2 char) := substr(p_file_code, 2, 2);
  l_type                   number;
  
  c_old_file_code          constant varchar2(3 char) := '#8B';

  l_file_id       nbur_ref_files.id%type := nbur_files.GET_FILE_ID(p_file_code => p_file_code);
  l_version_id    nbur_lst_files.version_id%type;  
  
  --Exception
  e_ptsn_not_exsts exception;

  pragma exception_init( e_ptsn_not_exsts, -02149 );  
BEGIN
  logger.info (
                c_title
                || ' begin for'
                || ' date = ' || to_char(p_report_date, c_date_fmt)
                || ' kod_filii=' || p_kod_filii
                || ' form_id=' || p_form_id
                || ' p_scheme= ' || p_scheme
              );

  -- определение начальных параметров (код области или МФО или подразделение)
  nbur_files.P_PROC_SET(
                         p_kod_filii
                         , p_file_code
                         , p_scheme
                         , l_datez
                         , 0
                         , l_file_code
                         , l_nbuc
                         , l_type
                       );

  --Очистка партиции для хранения детального протокола
  begin
    execute immediate 'alter table NBUR_LOG_F8BX truncate subpartition for ( to_date('''
                      || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
  exception
    when e_ptsn_not_exsts then
      null;
  end;

  --Определяем версию файла для хранения детальеного протокола
  l_version_id := f_nbur_get_run_version(p_file_code => p_file_code
                                          , p_kf => p_kod_filii
                                          , p_report_date => p_report_date
                                        );

  logger.trace(c_title || ' Version_id is ' || l_version_id);

  -- очікуємо формування старого файлу
  nbur_waiting_form(p_kod_filii, p_report_date, c_old_file_code, c_title);
  
  -- детальний протокол
  insert into nbur_log_f8BX
      (REPORT_DATE, KF, VERSION_ID, NBUC, EKP, F103, Q003_4, T070, DESCRIPTION, ACC_ID, ACC_NUM, KV, 
       CUST_ID, CUST_CODE, CUST_NAME, ND, AGRM_NUM, BEG_DT, END_DT, REF, BRANCH)
select p_report_date, p_kod_filii, version_id, nvl(trim(nbuc), l_nbuc), EKP, F103, Q003_4, T070, DESCRIPTION, 
	ACC_ID, ACC_NUM, KV, CUST_ID, CUST_CODE, CUST_NAME, ND, AGRM_NUM, BEG_DT, END_DT, REF, BRANCH
  from ( select  agg.nbuc
	      , agg.version_id
	      , (case 
	            when agg.seg_01 in ('01', '72', '92')             then 'A8B001'
	            when agg.seg_01 in ('02', '97', 'A7', 'B1', 'B2') then 'A8B002'
	            else 'A8B001'
	         end)  as EKP
	      , agg.seg_01 as F103
	      , (case 
	            when agg.seg_01 in ('01', '72', '92')             then agg.seg_02
	            when agg.seg_01 in ('02', '97', 'A7', 'B1', 'B2') then '0000'
	            else '0000'
	         end)  as Q003_4
	      , agg.field_value as T070
	      , v.DESCRIPTION
	      , v.ACC_ID
	      , v.ACC_NUM
	      , v.KV
	      , v.CUST_ID
	      , v.CUST_CODE
	      , v.CUST_NAME
	      , v.ND
	      , v.AGRM_NUM
	      , v.BEG_DT
	      , v.END_DT
	      , v.REF
	      , v.BRANCH
	   from v_nbur_#8B agg -- дані з агрегованої вьюхи, деталізація з dtl-вьюхи (не по всіх показниках дані потрапляють в детальний протокол)
	        left join V_NBUR_#8B_dtl v 
	               on (v.REPORT_DATE=agg.REPORT_DATE
	                     and v.KF=agg.KF
	                     and v.VERSION_ID=agg.VERSION_ID
	                     and v.FIELD_CODE=agg.FIELD_CODE
	                   ) 
            where agg.report_date = p_report_date 
              and agg.kf = p_kod_filii 
         ); 


  logger.info (c_title || ' end for date = '||to_char(p_report_date, c_date_fmt));
END NBUR_P_F8BX;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_F8BX.sql =========*** End *** =
PROMPT ===================================================================================== 