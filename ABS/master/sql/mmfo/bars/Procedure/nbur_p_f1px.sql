CREATE OR REPLACE PROCEDURE NBUR_P_F1PX (
                                          p_kod_filii        varchar2
                                          , p_report_date    date
                                          , p_form_id        number
                                          , p_scheme         varchar2 default 'C'
                                          , p_file_code      varchar2 default '1PX'
                                        )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования 1PX для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.16.010 28/09/2018 (20/09/2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.16.009  28/09/2018';
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  c_title                constant varchar2(100 char) := $$PLSQL_UNIT || '.';
  cEKP                   constant varchar2(100 char) := 'A1P001';
  c_old_file_code        constant varchar2(3 char) := '#1P';
  c_sleep_time           constant number := 30;

  l_nbuc                 varchar2(20);
  l_type                 number;
  l_datez                date := p_report_date + 1;
  l_file_code            varchar2(2) := substr(p_file_code, 2, 2);

  l_version_id           number; --Номер версии файла
  l_old_file_code        varchar2(3) := '#1P';
  l_cnt                  number := 0;

  e_ptsn_not_exsts       exception;

  pragma exception_init( e_ptsn_not_exsts, -02149 );
BEGIN
  logger.info (c_title || ' begin for date = '||to_char(p_report_date, 'dd.mm.yyyy'));

  -- определение начальных параметров (код области или МФО или подразделение)
  nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 0, l_file_code, l_nbuc, l_type);

  --Подготавливаем партицию для вставки данных
  begin
    execute immediate 'alter table NBUR_LOG_F1PX truncate subpartition for ( to_date('''
                      || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
  exception
    when e_ptsn_not_exsts then
      null;
  end;

  --Определяем версию файла для хранения детальеного протокола (сели рабочей нет, то ставим -1)
  l_version_id := coalesce(f_nbur_get_run_version(
                                                   p_file_code => p_file_code
                                                   , p_kf => p_kod_filii
                                                   , p_report_date => p_report_date
                                                 )
                           , -1);

  logger.trace(c_title || ' Version_id is ' || l_version_id);

  -- очікуємо формування старого файлу
  nbur_waiting_form(p_kod_filii, p_report_date, l_old_file_code, c_title);    
  
--  -- перевіряємо яи формувався з детальним протоколом чи з відкоригованих даних (без протоколу)
--  select count(*)
--  into l_cnt
--  from v_nbur_#1p_dtl t
--  where report_date = p_report_date and
--        kf = p_kod_filii;
--  
--  if l_cnt > 0 then -- з детального протоколу
--      insert into nbur_log_f1px(report_date, kf, version_id, nbuc, ekp, k040_1, rcbnk_b010, rcbnk_name, 
--            k040_2, r030, r020, r040, t023, rcukru_glb_2, k018, k020, q001, rcukru_glb_1, q003_1, q004, 
--            t080, t071, description, acc_id, acc_num, kv, maturity_date, cust_id, ref, nd, branch)
--        select p_report_date /*report_date*/
--               , p_kod_filii /*kf*/
--               , l_version_id /*version_id*/
--               , nbuc /*nbuc*/
--               , cEKP /*ekp*/
--               , k040_1 /*k040_1*/
--               , rcbnk_b010 /*rcbnk_b010*/
--               , rcbnk_name /*rcbnk_name*/
--               , k040_2 /*k040_2*/
--               , r030 /*r030*/
--               , r020 /*r020*/
--               , r040 /*r040*/
--               , t023 /*t023*/
--               , rcukru_glb_2 /*rcukru_glb_2*/
--               , k018 /*k018*/
--               , k020 /*k020*/
--               , q001 /*q001*/
--               , rcukru_glb_1 /*rcukru_glb_1*/
--               --Генерация номера для связки с агрегированного и детального протокола
--               , q003_1
--               , q004 /*q004*/
--               , case when t023 = 3 then 0 else to_number(t080) end/*t080*/
--               , t071 /*t071*/
--               , description /*description*/
--               , acc_id /*acc_id*/
--               , acc_num /*acc_num*/
--               , kv /*kv*/
--               , maturity_date /*maturity_date*/
--               , cust_id /*cust_id*/
--               , ref /*ref*/
--               , nd /*nd*/
--               , branch /*branch*/
--        from    (select *
--                    from   (select t.seg_01 as dd
--                               , t.seg_02 as T023
--                               , t.seg_03 as K040_1
--                               , t.seg_04 as RCBNK_B010
--                               , t.seg_05 as R020
--                               , t.seg_06 as R030
--                               , t.seg_07 as R040
--                               , t.seg_08 as K040_2
--                               , t.seg_09 as Q003_1
--                               , trim(t.field_value) znap
--                               , t.description
--                               , t.acc_num
--                               , t.kv
--                               , t.maturity_date
--                               , t.cust_id
--                               , t.ref
--                               , t.nd
--                               , t.branch
--                               , t.acc_id
--                               , t.nbuc
--                        from v_nbur_#1p_dtl t
--                        where report_date = p_report_date and
--                              kf = p_kod_filii) o
--                    pivot (max(znap) for dd in ('03' as RCUKRU_GLB_1, 
--                                                '04' as K018, 
--                                                '05' as K020, 
--                                                '06' as Q001, 
--                                                '07' as RCUKRU_GLB_2, 
--                                                '10' as RCBNK_NAME, 
--                                                '71' as T071, 
--                                                '80' as T080, 
--                                                '99' as Q004)
--                    )                      
--       );
--  else
      insert into nbur_log_f1px(report_date, kf, version_id, nbuc, ekp, k040_1, rcbnk_b010, rcbnk_name, 
            k040_2, r030, r020, r040, t023, rcukru_glb_2, k018, k020, q001, rcukru_glb_1, q003_1, q004, 
            t080, t071)
        select p_report_date /*report_date*/
               , p_kod_filii /*kf*/
               , l_version_id /*version_id*/
               , nbuc /*nbuc*/
               , cEKP /*ekp*/
               , k040_1 /*k040_1*/
               , rcbnk_b010 /*rcbnk_b010*/
               , rcbnk_name /*rcbnk_name*/
               , k040_2 /*k040_2*/
               , r030 /*r030*/
               , r020 /*r020*/
               , r040 /*r040*/
               , t023 /*t023*/
               , rcukru_glb_2 /*rcukru_glb_2*/
               , k018 /*k018*/
               , k020 /*k020*/
               , q001 /*q001*/
               , rcukru_glb_1 /*rcukru_glb_1*/
               --Генерация номера для связки с агрегированного и детального протокола
               , q003_1
               , q004 /*q004*/
               , case when t023 = 3 then 0 else to_number(t080) end/*t080*/
               , t071 /*t071*/
        from    (select *
                 from   (select t.seg_01 as dd
                           , t.seg_02 as T023
                           , t.seg_03 as K040_1
                           , t.seg_04 as RCBNK_B010
                           , t.seg_05 as R020
                           , t.seg_06 as R030
                           , t.seg_07 as R040
                           , t.seg_08 as K040_2
                           , t.seg_09 as Q003_1
                           , t.nbuc
                    from v_nbur_#1p t
                    where report_date = p_report_date and
                          kf = p_kod_filii) o
                pivot (max(znap) for dd in ('03' as RCUKRU_GLB_1, 
                                            '04' as K018, 
                                            '05' as K020, 
                                            '06' as Q001, 
                                            '07' as RCUKRU_GLB_2, 
                                            '10' as RCBNK_NAME, 
                                            '71' as T071, 
                                            '80' as T080, 
                                            '99' as Q004)
                        )
       );  
--  end if;

  logger.info (c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
END;
/
