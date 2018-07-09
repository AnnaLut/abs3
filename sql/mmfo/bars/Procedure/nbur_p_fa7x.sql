CREATE OR REPLACE PROCEDURE NBUR_P_FA7X (
                                          p_kod_filii        varchar2
                                          , p_report_date    date
                                          , p_form_id        number
                                          , p_scheme           varchar2 default 'C'
                                          , p_balance_type     varchar2 default 'S'
                                          , p_file_code        varchar2 default 'A7X'
                                        )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования A7X для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.1.000  22/06/2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_              char(30)  := 'v.1.000  22/06/2018';
  c_title           constant varchar2(100 char) := $$PLSQL_UNIT || '.';
  c_old_file_code   constant varchar2(3 char) := '#A7';
  c_sleep_time      constant number := 30; --Время ожидания между тактами проверки

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
    execute immediate 'alter table NBUR_LOG_FA7X truncate subpartition for ( to_date('''
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

  logger.trace(c_title || ' We execute procedure for file ' || c_old_file_code || ' and waiting data');
  p_fa7_nn(pdat_ => p_report_date, p_emulate => true); --Запускаем старый отчет в режиме эмуляции, чтобы забрать данные из RNBU_TRACE
  logger.trace(c_title || ' Execution of procedure for file ' || c_old_file_code || ' finished');

  --Теперь сохрянем полученные данные в детальном протоколе
  insert into nbur_log_fa7x(report_date, kf, nbuc, version_id, ekp, t020, r020, r011, r013, r030, k030, s181, s190, s240, t070, description, acc_id, acc_num, kv, maturity_date, cust_id, ref, nd, branch)
     select
              p_report_date /*report_date*/
              , p_kod_filii /*kf*/
              , p_kod_filii /*nbuc*/
              , l_version_id /*version_id*/
              , case
                  when t.seg_d in ('1', '2') and kl.i010 in ('F2') then 'AA7F20'
                  when t.seg_d in ('1', '2') and kl.i010 in ('F3') then 'AA7F30'
                  when t.seg_d in ('1', '2') and kl.i010 in ('F4') then 'AA7F40'
                  when t.seg_d in ('1', '2') and kl.i010 in ('F5') then 'AA7F50'
                  when t.seg_d in ('1', '2') and kl.i010 in ('F7') then 'AA7F70'
                  when t.seg_d in ('1', '2') and kl.i010 in ('F8') then 'AA7F80'
                  when t.seg_d in ('1', '2') and kl.i010 in ('N1') then 'AA7N10'
                  when t.seg_d in ('1', '2') and kl.i010 in ('N9') then 'AA7N90'                                        
                end /*ekp*/
              , t.seg_d /*t020*/
              , t.seg_bbbb /*r020*/
              , t.seg_z /*r011*/
              , t.seg_p /*r013*/
              , t.seg_vvv /*r030*/
              , t.seg_r /*k030*/
              , case when t.seg_x in ('1', '2') then t.seg_x else '#' end  /*s181*/
              , case when t.seg_i in ('A', 'B', 'C', 'D', 'E', 'F', 'G', '0') then t.seg_i else '#' end /*s190*/
              , t.seg_l /*s240*/
              , t.znap /*t070*/
              , t.comm /*description*/
              , t.acc /*acc_id*/
              , t.nls /*acc_num*/
              , t.kv /*kv*/
              , t.mdate /*maturity_date*/
              , t.rnk /*cust_id*/
              , t.ref /*ref*/
              , t.nd /*nd*/
              , t.branch /*branch*/
     from     (
                select p.rnk
                       , p.nd
                       , p.acc
                       , p.nls
                       , p.kv
                       , p.znap
                       , p.kodp
                       , p.ref
                       , p.mdate
                       , ac.branch
                       , p.comm
                       , substr(p.kodp, 1, 1) as seg_d
                       , substr(p.kodp, 2, 4) as seg_bbbb
                       , substr(p.kodp, 6, 1) as seg_z
                       , substr(p.kodp, 7, 1) as seg_p
                       , substr(p.kodp, 8, 1) as seg_x
                       , substr(p.kodp, 9, 1) as seg_l
                       , substr(p.kodp, 10, 1) as seg_r
                       , substr(p.kodp, 11, 1) as seg_i
                       , substr(p.kodp, 12, 3) as seg_vvv                        
                from   rnbu_trace p
                       left join accounts ac on (ac.kf = p_kod_filii)
                                                and (p.acc = ac.acc)     
              ) t
              join (
                    select r020, max(I010) I010
                    from   kl_r020
                    where  p_report_date between d_open and coalesce(d_close, date '4000-01-01')
                    group by
                           r020
                  ) kl on (t.seg_bbbb = kl.r020); 

  logger.info(c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
END;
/
