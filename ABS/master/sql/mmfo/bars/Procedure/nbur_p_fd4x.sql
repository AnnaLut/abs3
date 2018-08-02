CREATE OR REPLACE PROCEDURE NBUR_P_FD4X (p_kod_filii        varchar2
                                          , p_report_date    date
                                          , p_form_id        number
                                          , p_scheme           varchar2 default 'C'
                                          , p_file_code        varchar2 default 'D4X'
                                        )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования D4X для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.1.001  30/07/2018 (26/06/2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_              char(30)  := 'v.1.001  30/07/2018';
  c_title           constant varchar2(100 char) := $$PLSQL_UNIT || '.';  
  c_AD4001          constant varchar2(100 char) := 'AD4001';
  c_AD4002          constant varchar2(100 char) := 'AD4002';

  l_nbuc          varchar2(20);
  l_type          number;
  l_datez         date := p_report_date + 1;
  l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
  l_version_id    nbur_lst_files.version_id%type;
  l_start_date    date;--Дата начала охвата
  
  l_old_file_code varchar2(3) := '#D4';

  --Exception
  e_ptsn_not_exsts exception;

  pragma exception_init( e_ptsn_not_exsts, -02149 );
BEGIN
  logger.info (c_title || ' begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

  -- определение начальных параметров (код области или МФО или подразделение)
  nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 1, l_file_code, l_nbuc, l_type);

  l_start_date := trunc(p_report_date, 'MM');

  --Очистка партиции для хранения детального протокола
  begin
    execute immediate 'alter table NBUR_LOG_FD4X truncate subpartition for ( to_date('''
                      || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
  exception
    when e_ptsn_not_exsts then
      null;
  end;

  --Определяем версию файла для последующей связи детального и агрегированного протокола
  l_version_id := coalesce(
                            f_nbur_get_run_version(
                                                    p_file_code => p_file_code
                                                    , p_kf => p_kod_filii
                                                    , p_report_date => p_report_date
                                                  )
                            , -1
                          );

  logger.trace(c_title || ' Version_id is ' || l_version_id);
  
  -- очікуємо формування старого файлу
  nbur_waiting_form(p_kod_filii, p_report_date, l_old_file_code, c_title);    

  insert into nbur_log_fd4x(report_date, kf, nbuc, version_id, ekp, r030, f025, b010, q006, t071, description, acc_id, acc_num, kv, maturity_date, cust_id, ref, nd, branch)
     select p_report_date /*report_date*/
            , p_kod_filii /*kf*/
            , p_kod_filii /*nbuc*/
            , l_version_id /*version_id*/
            , case
                when dd in ('11', '12', '13', '14', '15', '16', '17', '18', '19', '20', '32', '34') then c_AD4001
                when dd in ('21', '22', '23', '24', '25', '26', '27', '28', '29', '30', '31', '33', '35') then c_AD4002
              else
                'XXXXXX'
              end /*ekp*/
            , lpad(kv, 3, '0') /*r030*/
            , dd /*f025*/
            , kb /*b010*/
            , comm /*q006*/
            , t071 /*t071*/ 
            , ' ' /*description*/
            , null /*acc_id*/
            , null /*acc_num*/
            , null /*kv*/
            , null /*maturity_date*/
            , null /*cust_id*/
            , null /*ref*/
            , null /*nd*/
            , null /*branch*/
      from (select v1.pp, v1.dd, v1.kb, v1.kv, v1.t071, v2.comm 
            from (select substr(field_code,2) kodp, seg_01 pp, seg_02 dd, seg_03 kb, seg_04 kv, field_value t071
                  from v_nbur_#d4 
                  where report_date = p_report_date and
                        kf = p_kod_filii and
                        seg_01 = '1'
                  ) v1
                  left outer join
                  (select substr(field_code,2) kodp, seg_01 pp, seg_02 dd, seg_03 kb, seg_04 kv, substr(field_value,1,160) comm
                  from v_nbur_#d4 
                  where report_date = p_report_date and
                        kf = p_kod_filii and
                        seg_01 = '9'
                  ) v2
                  on (v1.kodp = v2.kodp)
      );

  logger.info(c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
END;
/
