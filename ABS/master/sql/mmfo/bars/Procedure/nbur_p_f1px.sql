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
% VERSION     :  v.16.004  20/06/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.16.004  20/06/2018';
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

  --Проверяем есть ли старая версия в очереди на формировании
  --Если нет, то запускаем старую процедуру и ожидаем когда наполнится витрина
  --Если да, то будем ждать, пока она закончится и мы сможем забрать сформированные ею данные
  if f_nbur_check_file_in_queue(
                                 p_file_code => c_old_file_code
                                 , p_kf => p_kod_filii
                                 , p_report_date => p_report_date
                               )
  then
    logger.trace(c_title || ' The file ' || c_old_file_code || ' in queue. Waiting procedure and use it''s data');

    loop
      --Ждем пока закончится старая процедура наполнения данных
      dbms_lock.sleep(seconds => c_sleep_time);

      --Выйдем когда файла в очереди уже нет
      if f_nbur_check_file_in_queue(
                                      p_file_code => c_old_file_code
                                      , p_kf => p_kod_filii
                                      , p_report_date => p_report_date
                                    )
      then
        logger.trace(c_title || ' File ' || c_old_file_code || ' in queue. Waiting more...');
      else
        logger.trace(c_title || ' File ' || c_old_file_code || ' not in queue. Stop waiting and process it data');
        exit;
      end if ;
    end loop;
  end if;

  --Запуск старой процедуры для получения данных в rnbu_trace
  logger.trace(c_title || 'Start execute ' || c_old_file_code || ' file procedure and waiting data');
  p_f1p_nn(p_report_date, 'C', 'X'); --Вызываем с параметром X, чтобы не перетерался tmp_nbu
  logger.trace(c_title || ' Execution of procedure for file ' || c_old_file_code || ' finished');

  insert into nbur_log_f1px(report_date, kf, version_id, nbuc, ekp, k040_1, rcbnk_b010, rcbnk_name, k040_2, r030, r020, r040, t023, rcukru_glb_2, k018, k020, q001, rcukru_glb_1, q003_1, q004, t080, t071, description, acc_id, acc_num, kv, maturity_date, cust_id, ref, nd, branch)
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
           , lpad(dense_rank() over (order by k040_1, rcbnk_b010, rcbnk_name, k040_2, r030, r020, r040, t023, rcukru_glb_2, k018, k020, q001, rcukru_glb_1, q004), 5, '0') as q003_1
           , q004 /*q004*/
           , case when t023 = 3 then 0 else 1 end/*t080*/
           , t071 /*t071*/
           , description /*description*/
           , acc_id /*acc_id*/
           , acc_num /*acc_num*/
           , kv /*kv*/
           , maturity_date /*maturity_date*/
           , cust_id /*cust_id*/
           , ref /*ref*/
           , nd /*nd*/
           , branch /*branch*/
    from    (
              select
                     nbuc
                     , max(mmm) as K040_1
                     , max(hhhhhhhhhh) as RCBNK_B010
                     , max(case when dd = '10' then znap else null end) as  RCBNK_NAME
                     , max(www) as K040_2
                     , max(vvv) as R030
                     , max(bbbb) as R020
                     , max(xxxx) as R040
                     , max(e) as T023
                     , max(case when dd = '07' then znap else null end) as RCUKRU_GLB_2
                     , max(case when dd = '04' then znap else null end) as K018
                     , max(case when dd = '05' then znap else null end) as K020
                     , max(case when dd = '06' then znap else null end) as Q001
                     , max(case when dd = '03' then znap else null end) as  RCUKRU_GLB_1
                     , max(nnn) as Q003_1
                     , max(case when dd = '99' then znap else null end) as Q004
                     , max(case when dd = '71' then znap else null end) as T071

                     , o.comm as description
                     , o.acc_id as acc_id
                     , o.nls as acc_num
                     , o.kv as kv
                     , o.mdate as maturity_date
                     , o.rnk as cust_id
                     , o.ref as ref
                     , o.nd as nd
                     , o.branch
              from   (
                        select substr(kodp, 1, 2) as dd
                               , substr(kodp, 3, 1) as e
                               , substr(kodp, 4, 3 ) as mmm
                               , substr(kodp, 7, 10) as hhhhhhhhhh
                               , substr(kodp, 17, 4) as bbbb
                               , substr(kodp, 21, 3) as vvv
                               , substr(kodp, 24, 4) as xxxx
                               , substr(kodp, 28, 3) as www
                               , substr(kodp, 31, 4) as nnn
                               , t.kodp
                               , t.comm
                               , t.nls
                               , t.kv
                               , t.mdate
                               , t.rnk
                               , t.ref
                               , t.nd
                               , ac.branch
                               , t.znap
                               , ac.acc as acc_id
                               , t.nbuc
                        from   rnbu_trace t
                               --Так как нет идентификатора счета, то подтянем его из витрины счетов
                               left join accounts ac on (ac.kf = p_kod_filii)
                                                        and (ac.nls = t.nls)
                                                        and (ac.kv = t.kv)
                     ) o
              group by
                    substr(o.kodp, 3)
                     , o.comm
                     , o.acc_id
                     , o.nls
                     , o.kv
                     , o.mdate
                     , o.rnk
                     , o.ref
                     , o.nd
                     , o.branch
                     , o.nbuc
   );

  logger.info (c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
END;
/
