CREATE OR REPLACE PROCEDURE NBUR_P_F3AX (
                                          p_kod_filii        varchar2
                                          , p_report_date    date
                                          , p_form_id        number
                                          , p_scheme           varchar2 default 'C'
                                          , p_balance_type     varchar2 default 'S'
                                          , p_file_code        varchar2 default '3AX'
                                        )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования 3AX для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.1.004  23/10/2018 (01/08/2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_              char(30)  := 'v.1.004   23/10/2018';
  
  c_title           constant varchar2(100 char) := $$PLSQL_UNIT || '.';
  c_A3A3F2          constant varchar2(6 char) := 'A3A3F2';
  c_A3A3F4          constant varchar2(6 char) := 'A3A3F4';
  c_A3A4F2          constant varchar2(6 char) := 'A3A4F2';
  c_A3A4F4          constant varchar2(6 char) := 'A3A4F4';
  c_XXXXXX          constant varchar2(6 char) := 'XXXXXX';
  
  c_old_file_code   constant varchar2(3 char) := '#3A';
  c_sleep_time      constant number := 30; --Время ожидания между тактами проверки

  l_nbuc          varchar2(20);
  l_type          number;
  l_datez         date := p_report_date + 1;
  l_file_code     varchar2(2) := substr(p_file_code, 2, 2);
  l_file_id       nbur_ref_files.id%type := nbur_files.GET_FILE_ID(p_file_code => p_file_code);
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
    execute immediate 'alter table NBUR_LOG_F3AX truncate subpartition for ( to_date('''
                      || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
  exception
    when e_ptsn_not_exsts then
      null;
  end;

  --Определяем версию файла для хранения детальеного протокола
  l_version_id := f_nbur_get_run_version(
                                          p_file_code => p_file_code
                                          , p_kf => p_kod_filii
                                          , p_report_date => p_report_date
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
  else
    logger.trace(c_title || ' The file ' || c_old_file_code || ' not in queue.');
  end if;

  --Теперь сохрянем полученные данные в детальном протоколе
  insert into nbur_log_f3ax(
                             report_date
                             , kf
                             , nbuc
                             , version_id
                             , ekp
                             , ku
                             , t020
                             , r020
                             , r011
                             , d020
                             , s180
                             , r030
                             , k030
                             , t070
                             , t090
                             , description
                             , acc_id
                             , acc_num
                             , kv
                             , maturity_date
                             , cust_id
                             , ref
                             , nd
                             , branch
                           )
      select
             report_date
             , kf
             , nbuc
             , l_version_id
             , case
                 when T020 = '5' and R020 in ('1520', '1521', '1522', '1524', '1532', '1533', '1542', '1543', 
                                              '2010', '2020', '2030', '2040', '2041', '2042', '2043', '2044', '2045', 
                                              '2063', '2071', '2083', '2103', '2113',' 2123', '2133', '2140', '2141', '2142', '2143', 
                                              '2203', '2211', '2220', '2233', '2240', '2241', '2242', '2243', '2301', '2303', '2310', '2311', 
                                              '2320', '2321', '2330', '2331', '2340', '2341', '2351', '2353', 
                                              '2360', '2361', '2362', '2363', '2370', '2371', '2372', '2373', '2380', '2381', '2382', '2383', 
                                              '2390', '2391', '2392', '2393', '2394', '2395', 
                                              '2401', '2403', '2410', '2411', '2420', '2421', '2431', '2433', '2450', '2451', '2452', '2453') then c_A3A3F4
                 when T020 = '5' and R020 in ('1502', '1510', '1513', '1600', '2600', '2605', '2620', '2625', '2650', '2655') then c_A3A3F2
                 when T020 = '6' and R020 in ('1500', '1621', '1622', '1623') then c_A3A4F4
                 when T020 = '6' and R020 in ('1602', '1610', '1613', '2525', '2546', '2600', '2605', '2610', '2611', '2620', '2625', '2630', '2650', '2651', '2655') then c_A3A4F2
                 else c_XXXXXX                 
               end
             , f_get_ku_by_nbuc(nbuc)
             , t020
             , r020
             , r011
             , d020
             , s180
             , r030
             , k030
             , sum(t070) as t070
             , max(t090) as t090
             , description
             , ACC_ID
             , ACC_NUM
             , KV
             , MATURITY_DATE
             , CUST_ID
             , REF
             , ND
             , BRANCH
      from   (
                select
                       report_date
                       , kf
                       , nbuc
                       , seg_02 as t020
                       , seg_03 as r020
                       , seg_04 as r011
                       , seg_08 as r030
                       , seg_06 as k030
                       , seg_05 as s180
                       , seg_07 as d020
                       , case when seg_01 = '1' then to_number(field_value) end as t070
                       , case when seg_01 = '2' then to_number(field_value) end as t090
                       , description
                       , acc_id
                       , acc_num
                       , kv
                       , maturity_date
                       , cust_id
                       , ref
                       , nd
                       , branch
                from   v_nbur_#3a_dtl
                where  report_date = p_report_date
                   and kf = p_kod_filii
                   and not (kf = '300465' and seg_03 = '1502' and cust_id = 90931101)
             )
      group by
                       report_date
                       , kf
                       , nbuc
                       , t020
                       , r020
                       , r011
                       , r030
                       , k030
                       , s180
                       , d020
                       , description
                       , ACC_ID
                       , ACC_NUM
                       , KV
                       , MATURITY_DATE
                       , CUST_ID
                       , REF
                       , ND
                       , BRANCH;

  logger.info(c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
END;
/

