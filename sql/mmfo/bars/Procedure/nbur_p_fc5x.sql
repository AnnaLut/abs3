CREATE OR REPLACE PROCEDURE NBUR_P_FC5X (
                                          p_kod_filii        varchar2
                                          , p_report_date    date
                                          , p_form_id        number
                                          , p_scheme           varchar2 default 'C'
                                          , p_balance_type     varchar2 default 'S'
                                          , p_file_code        varchar2 default 'C5X'
                                        )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования 5СX для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.1.009  29/05/2019 (16/11/2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_              char(30)  := ' v.1.009  29/05/2019';
  c_title           constant varchar2(100 char) := $$PLSQL_UNIT || '.';
  c_old_file_code   constant varchar2(3 char) := '#C5';
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
    execute immediate 'alter table NBUR_LOG_FC5X truncate subpartition for ( to_date('''
                      || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
  exception
    when e_ptsn_not_exsts then
      null;
  end;

  --Определяем версию файла для хранения детальеного протокола
  l_version_id := coalesce(
                            f_nbur_get_run_version(p_file_code => p_file_code, 
                                                   p_kf => p_kod_filii, 
                                                   p_report_date => p_report_date
                                                  )
                            , -1
                          );

  logger.trace(c_title || ' Version_id is ' || l_version_id);

  --Проверяем есть ли старая версия в очереди на формировании
  --Если нет, то запускаем старую процедуру и ожидаем когда наполнится витрина
  --Если да, то будем ждать, пока она закончится и мы сможем забрать сформированные ею данные
  if f_nbur_check_file_in_queue(p_file_code => c_old_file_code
                              , p_kf => p_kod_filii
                              , p_report_date => p_report_date
                               )
  then
    logger.trace(c_title || ' The file ' || c_old_file_code || ' in queue. Waiting procedure and use it''s data');

    loop
      --Ждем пока закончится старая процедура наполнения данных
      dbms_lock.sleep(seconds => c_sleep_time);

      --Выйдем когда файла в очереди уже нет
      if f_nbur_check_file_in_queue(p_file_code => c_old_file_code,
                                    p_kf => p_kod_filii,
                                    p_report_date => p_report_date
                                    )
      then
        logger.trace(c_title || ' File ' || c_old_file_code || ' in queue. Waiting more...');
      else
        logger.trace(c_title || ' File ' || c_old_file_code || ' not in queue. Stop waiting and process it data');
        exit;
      end if ;
    end loop;
  end if;
   
  --Теперь сохрянем полученные данные в детальном протоколе
  insert into nbur_log_fc5x(report_date, kf, nbuc, version_id, ekp, a012, t020, r020, r011, r013, r030_1, r030_2, 
           r017, k077, s245, s580, t070, description, acc_id, acc_num, kv, maturity_date, cust_id, ref, nd, branch)
      select       
            p_report_date /*report_date*/
            , p_kod_filii /*kf*/
            , p_kod_filii /*nbuc*/
            , l_version_id /*version_id*/
            , case
                when t.seg_d in ('1', '2') and (kl.i010 = 'F2') then 'AC5F20'
                when t.seg_d in ('1', '2') and (kl.i010 = 'F3') then 'AC5F30'
                when t.seg_d in ('1', '2') and (kl.i010 = 'F4') then 'AC5F40'
                when t.seg_d in ('1', '2') and (kl.i010 = 'F5') then 'AC5F50'
                when t.seg_d in ('1', '2') and (kl.i010 = 'F7') then 'AC5F70'
                when t.seg_d in ('1', '2') and (kl.i010 = 'F8') then 'AC5F80'
                when t.seg_d in ('1', '2') and (kl.i010 = 'N1') then 'AC5N10'
                when t.seg_d in ('1', '2') and (kl.i010 = 'N9') then 'AC5N90'  
              end /*ekp*/
            , '1' /*a012*/
            , t.seg_d /*t020*/
            , t.seg_bbbb /*r020*/
            , t.seg_z /*r011*/
            , t.seg_p /*r013*/
            , t.seg_vvv /*r030_1*/
            , t.seg_www /*r030_2*/
            , t.seg_q /*r017*/
            , t.seg_k /*k077*/
            , (case when t.seg_bbbb in ('1200', '1203', '3500', '4400', '4409', 
                                        '4410', '4419', '4430', '4431', '4500', 
                                        '4509', '4530', '4600', '4609') 
                     then '#' 
                     else replace(t.seg_e, '0', '#') 
               end)/*s245*/
            , t.seg_y /*s580*/
            , t.znap /*t070*/
            , null /*description*/
            , t.acc/*acc_id*/
            , t.nls/*acc_num*/
            , t.kv /*kv*/
            , null /*maturity_date*/
            , t.rnk /*cust_id*/
            , null /*ref*/
            , t.nd /*nd*/
            , t.branch /*branch*/
      from  (select    p.cust_id rnk
                     , p.nd
                     , p.acc_id acc
                     , p.acc_num nls
                     , p.kv
                     , to_number(p.field_value) znap
                     , p.seg_01 as seg_d
                     , p.seg_02 as seg_bbbb
                     , p.seg_03 as seg_z
                     , p.seg_04 as seg_p
                     , p.seg_05 as seg_vvv
                     , p.seg_06 as seg_y
                     , p.seg_07 as seg_q
                     , p.seg_08 as seg_www
                     , p.seg_09 as seg_e
                     , p.seg_10 as seg_k
                     , p.field_code kodp
                     , p.branch
              from v_nbur_#c5_dtl p 
              where p.report_date = p_report_date and
                    p.kf = p_kod_filii                        
             ) t
             join (select r020, max(I010) I010
                    from   kl_r020
                    where  p_report_date between d_open and coalesce(d_close, date '4000-01-01')
                    group by r020
                  ) kl 
             on (t.seg_bbbb = kl.r020);
                             
  logger.info(c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
END;
/
