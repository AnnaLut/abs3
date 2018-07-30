CREATE OR REPLACE PROCEDURE NBUR_P_F48X (
                                          p_kod_filii        varchar2
                                          , p_report_date    date
                                          , p_form_id        number
                                          , p_scheme           varchar2 default 'C'
                                          , p_file_code        varchar2 default '48X'
                                        )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования 48X для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.1.000  26/06/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_            char(30)  := 'v.1.000  26/06/2018';
  c_title         constant varchar2(100 char) := $$PLSQL_UNIT || '.';
  c_ekp           constant varchar2(6 char) := 'A48001';  

  l_nbuc          varchar2(20);
  l_type          number;
  l_datez         date := p_report_date + 1;
  l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
  l_version_id    nbur_lst_files.version_id%type;

  --Exception
  e_ptsn_not_exsts exception;

  pragma exception_init( e_ptsn_not_exsts, -02149 );
BEGIN
  logger.info (c_title || ' begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

  -- определение начальных параметров (код области или МФО или подразделение)
  nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 1, l_file_code, l_nbuc, l_type);

  --Очистка партиции для хранения детального протокола
  begin
    execute immediate 'alter table NBUR_LOG_F48X truncate subpartition for ( to_date('''
                      || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
  exception
    when e_ptsn_not_exsts then
      null;
  end;

  --Определяем версию файла для хранения детальеного протокола
  l_version_id := coalesce(
                            f_nbur_get_run_version(
                                                    p_file_code => p_file_code
                                                    , p_kf => p_kod_filii
                                                    , p_report_date => p_report_date
                                                  )
                            , -1
                          );

  logger.trace(c_title || ' Version_id is ' || l_version_id);

  insert into nbur_log_f48x(report_date, kf, nbuc, version_id, ekp, q003, q001, q002, q008, q029, k020, k021, k040, k110, t070, t080, t090_1, t090_2, t090_3, description, acc_id, acc_num, kv, maturity_date, cust_id, ref, nd, branch)         
    select 
           p_report_date /*report_date*/
           , p_kod_filii /*kf*/
           , p_kod_filii /*nbuc*/
           , l_version_id /*version_id*/
           , c_ekp /*ekp*/
           , lpad(id, 2, '0') /*q003*/
           , trim(VAR_10) /*q001*/
           , trim(VAR_20) /*q002*/
           , trim(VAR_30) /*q008*/
           , case when length(trim(VAR_15)) > 10 then trim(VAR_15) end /*q029*/
           , trim(VAR_15) /*k020*/
           , trim(VAR_14) /*k021*/
           , coalesce(trim(VAR_16), '#') /*k040*/
           , coalesce(trim(VAR_17), '00000') /*k110*/
           , round(coalesce(VAR_51, 0), 0) /*t070*/
           , round(coalesce(VAR_40, 0), 0) /*t080*/
           , round(coalesce(VAR_60, 0), 2) /*t090_1*/
           , round(coalesce(VAR_70, 0), 0) /*t090_2*/
           , round(coalesce(VAR_60, 0) + coalesce(VAR_70, 0), 0) /*t090_3*/
           , null/*description*/
           , null/*acc_id*/
           , null/*acc_num*/
           , null/*kv*/
           , null/*maturity_date*/
           , null/*cust_id*/
           , null/*ref*/
           , null/*nd*/
           , null/*branch*/
    from   NBUR_KOR_DATA_F48
    where  kf = p_kod_filii;

  logger.info(c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
END;
/
