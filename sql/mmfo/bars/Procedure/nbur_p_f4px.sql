CREATE OR REPLACE PROCEDURE BARS.nbur_p_f4px (
                                           p_kod_filii          varchar2
                                           , p_report_date      date
                                           , p_form_id          number
                                           , p_scheme           varchar2 default 'C'
                                           , p_file_code        varchar2 default '#4P'
                                        )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования 4PX для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.1.001  06/08/2018 (23/06/2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_               char(30)  := 'v.1.001  06/08/2018';
  c_title            constant varchar2(100 char) := $$PLSQL_UNIT || '. ';

  --Константы определяющие форматы данных
  c_date_fmt         constant varchar2(10 char) := 'dd.mm.yyyy';
  c_amount_fmt       constant varchar2(50 char) := 'FM99999999999990';

  --Типы данных
  type t_nbur_4px is
    table of nbur_log_f4px%rowtype index by binary_integer;

  --Эксепшн, когда нет партиции
  e_ptsn_not_exsts   exception;

  l_nbuc                  varchar2(20);
  l_cim_nbuc              varchar2(20);  --Параметр nbuc для файлов 35 и 6А
  l_type                  number;
  l_counter               number;
  l_version_id            number;
  l_rows_inserted         boolean;
  l_datez                 date := p_report_date + 1;
  l_file_code             varchar2(2) := substr(p_file_code, 2, 2);
  l_mnth_last_work_dt     date;

  l_2025                  number;
  l_2039                  number;
  l_2040                  number;
  l_2041                  number;
  l_2043                  number;
  l_2044                  number;
  l_2045                  number;

  l_indicators_503        cim_reports.t_indicators_f503;
  l_indicators_504        cim_reports.t_indicators_f504;

  l_row                   nbur_log_f4px%rowtype;
  l_#35_rows              t_nbur_4px;
  l_#6A_rows              t_nbur_4px;

  --Процедура добавления параметра в коллекцию
  procedure add_indicator(
                           p_ekp               in nbur_log_f4px.ekp%type
                           , p_rrrrw           in varchar2
                           , p_t071            in nbur_log_f4px.t071%type

                           , p_indicator       in out nbur_log_f4px%rowtype
                           , p_rows_inserted   in out boolean
                           , p_counter         in out number
                           , p_rows            in out nocopy t_nbur_4px
                         )
  is
  begin
    if (nvl(p_t071, 0) <> 0)
    then
      p_indicator.ekp := p_ekp;
      p_indicator.q010_1 := substr(p_rrrrw, 5, 4);
      p_indicator.q010_2 := substr(p_rrrrw, 1, 4);
      p_indicator.t071 := p_t071;

      p_rows_inserted := true;
      p_counter := p_counter + 1;
      p_rows(p_counter) := p_indicator;
    end if;
  end add_indicator;

  --Процедура добавления параметра в коллекцию
  procedure add_indicator(
                           p_ekp               in nbur_log_f4px.ekp%type
                           , p_t071            in nbur_log_f4px.t071%type
                           , p_s050            in nbur_log_f4px.s050%type
                           , p_f028            in nbur_log_f4px.f028%type

                           , p_indicator       in out nbur_log_f4px%rowtype
                           , p_rows_inserted   in out boolean
                           , p_counter         in out number
                           , p_rows            in out nocopy t_nbur_4px
                         )
  is
  begin
    --Условия вставки записи
    if (nvl(p_t071, 0) <> 0)
    then
      p_indicator.ekp := p_ekp;
      p_indicator.t071 := p_t071;
      p_indicator.s050 := p_s050;
      p_indicator.f028 := p_f028;

      p_rows_inserted := true;
      p_counter := p_counter + 1;
      p_rows(p_counter) := p_indicator;
    end if;
  end add_indicator;

  pragma exception_init( e_ptsn_not_exsts, -02149 );
BEGIN
  logger.info(
                c_title
                || ' begin for date = ' || to_char(p_report_date, 'dd.mm.yyyy')
                || ' kod_filii=' || p_kod_filii
                || ' form_id=' || p_form_id
                || ' scheme=' || p_scheme
             );

  -- Определение параметров построения отчета
  nbur_files.P_PROC_SET(
                           p_kf => p_kod_filii
                           , p_file_code => p_file_code
                           , p_scheme => p_scheme
                           , p_datz => l_datez
                           , p_type_spr => 0
                           , p_file_spr => l_file_code
                           , o_nbuc => l_nbuc
                           , o_type => l_type
                         );

  --Определяем версию под которую будем писать, чтобы связать агрегированный и детальный протокол
  l_version_id := coalesce(
                            f_nbur_get_run_version(
                                                    p_file_code => p_file_code
                                                    , p_kf => p_kod_filii
                                                    , p_report_date => p_report_date
                                                  )
                            , -1
                          );


  --Определяем полседнюю рабочую дату в этом месяце
  select max(fdat)
     into
         l_mnth_last_work_dt
  from   fdat
  where  fdat between trunc(fdat, 'MM') and last_day(p_report_date);

  --Запускаем построение отчета только в том случае, если дата является последним рабочий днем месяца
  if p_report_date = l_mnth_last_work_dt
  then
      --Параметр nbuc для файлов #35 и #6А
      select
             nvl(trim(b040), lpad('X', 20, 'X'))
        into
             l_cim_nbuc
      from   branch
      where  branch='/' || p_kod_filii || '/';

      --Подготавливаем партицию для вставки данных
      begin
        execute immediate 'alter table NBUR_LOG_F4PX truncate subpartition for ( to_date('''
                          || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
      exception
        when e_ptsn_not_exsts then
          null;
      end;

      logger.trace(c_title || 'Subpartition truncated');

      --Вставка данных из данных файла #1A
      BEGIN
        insert /*+ APPPEND */ into nbur_log_f4px(report_date, kf, nbuc, version_id, b040, ekp, r020, r030_1, r030_2, 
            k040, s050, s184, f028, f045, f046, f047, f048, f049, f050, f052, f053, f054, f055, f056, f057, f070, k020, 
            q001_1, q001_2, q003_1, q003_2, q003_3, q006, q007_1, q007_2, q007_3, q010_1, q010_2, q012, q013, q021, q022, 
            t071, description, acc_id, acc_num, kv, maturity_date, cust_id, ref, nd, branch)
          with w_accounts
          as
          (
                 select /*+ MATERIALIZE */
                        t.*
                        --Определение сегмента Z показателя
                        , (
                            case
                              when t.nbs like '___8' and t.nbs <> '3548' then '2'
                              when t.ddd in ('410', '421', '422', '430', '440', '450') then '0'
                            else
                              '1'
                            end
                          ) as segm_z
                        , (
                            case
                              when  t.maturity_date < t.report_date OR t.nbs like '___8' then to_char(calc_date_on, 'YYYY')
                            else
                              case
                                when  t.maturity_date is null then to_char(add_months(p_report_date, 1), 'YYYY')
                              else
                                to_char(t.maturity_date, 'YYYY')
                              end
                            end
                          ) as segm_god
                        , --Определение сегмента w
                        (
                          case
                            when  t.maturity_date < p_report_date OR t.nbs like '___8' then f_chr36(to_number(to_char(t.calc_date_on, 'MM')))
                          else
                            case
                              when maturity_date is null then f_chr36(to_number(to_char(add_months(p_report_date, 1),'MM')))
                            else
                              f_chr36(to_number(to_char(t.maturity_date, 'MM')))
                            end
                          end
                        ) as segm_w
                 from   (
                            select
                                   acc.*
                                   , lpad(to_char(acc.kv), 3, '0') as ccy_id
                                   , rates.rate_val
                                   --Определяемся от какой даты начинаем расчет следующей выплаты
                                   , case
                                     --  не задан или в конце срока
                                       when (acc.AGREEMENT_TYPE in ('DPU', 'DPT') and agrm.int_frq_tp is null) or agrm.int_frq_tp = 400 then acc.maturity_date
                                       --  не задан или ежедневно
                                       when coalesce(agrm.int_frq_tp, 0) in (0, 1) then last_day(TRUNC(add_months(acc.report_date, 1), 'MM'))
                                     else
                                       add_months(coalesce(agrm.beg_dt, acc.open_date), ceil(greatest(months_between(acc.report_date, coalesce(agrm.beg_dt, acc.open_date)), 0)))
                                     end as calc_date_on
                                   , agrm.agrm_id
                                   , agrm.int_frq_tp --Периодичность выплаты процентов
                                   --Получаем дату начала действия договора/счета
                                   , coalesce(agrm.beg_dt, acc.open_date) as agreement_date
                            from   (
                                      select acc.report_date
                                             , acc.kf
                                             , acc.acc_id
                                             , acc.nbs
                                             , acc.acc_num
                                             , acc.kv
                                             , acc.open_date
                                             , acc.close_date
                                             , acc.maturity_date
                                             , acc.cust_id
                                             --Определяем какой тип процентной ставки нам нужен
                                             , case
                                                 when bal.adj_bal < 0
                                                      OR bal.adj_bal = 0 AND p.pap = 1
                                                      OR bal.adj_bal = 0 AND p.pap = 3 AND acc.pap = 1  then 0
                                                 when bal.adj_bal > 0
                                                      OR  bal.adj_bal = 0 AND p.pap = 2
                                                      OR bal.adj_bal = 0 AND p.pap = 3 AND acc.pap = 2  then 1
                                               else
                                                 null
                                               end as rate_type
                                             --Определяем какой вид договора должен быть под наш балансовый счета
                                             , case
                                                 when acc.nbs like '262%'
                                                      or acc.nbs like '263%' then 'DPT' --Депозит физ. лиц
                                                 when acc.nbs like '161%'
                                                      or acc.nbs like '261%' then 'DPU' --Депозит. юр. лиц
                                               end as AGREEMENT_TYPE
                                             , nvl(k.ddd, '000') as DDD
                                             , cust.cust_type
                                             , cust.k030
                                             , cust.k040
                                             , bal.adj_bal
                                             , lpad(cust.cust_code, 10, '0') as cust_code
                                             , acc.branch
                                             , acc.b040
                                      from   nbur_dm_accounts acc
                                             --Отбор нужных балансовых счетов
                                             join kl_f3_29 k on (acc.nbs = k.r020)
                                                                and (k.kf = '1A')
                                             --Информация по клиентам
                                             join nbur_dm_customers cust on (acc.kf = cust.kf)
                                                                            and (acc.cust_id = cust.cust_id)
                                             --Месячные балансы
                                             join nbur_dm_balances_monthly bal on (acc.kf = bal.kf)
                                                                                  and (acc.acc_id = bal.acc_id)
                                             --План счетов для определения типа процентной ставки
                                             join ps p on (acc.nbs = p.nbs)
                                      where  acc.report_date = p_report_date
                                             and acc.kf = p_kod_filii
                                             and acc.kv <> 980
                                             --Берем только счета нерезидентов
                                             and (cust.k030 = '2')
                                             -- удаляем записи для бал.счета 2620 с R013<>'1'
                                             and not (acc.nbs in ('2620') and acc.r013 <> '1')
                                             -- для Крыма не включаем счета 2620, 2628
                                             and not (acc.kf = '324805' and acc.nbs like '262%')
                                             -- удаляем записи для бал.счета 2628 с R013<>'1' основного счета
                                             and not (
                                                       acc.nbs in ('2628')
                                                       and acc.acc_id not in (
                                                                               select n.acra
                                                                               from   int_accn n
                                                                                      join nbur_dm_accounts ac on (ac.kf = p_kod_filii)
                                                                                                                  and (ac.nbs = '2620')
                                                                                                                  and (n.acc = ac.acc_id)
                                                                               where  (ac.r013 = '1')
                                                                                      and (n.acra is not null)
                                                                             )
                                                     )
                                             --Отсечение счетов по балансам
                                             and (
                                                   (bal.ostq   <> 0) or (bal.ost <> 0) or (bal.kosq <> 0) or (bal.kos <> 0) or (bal.dosq <> 0) or (bal.dos <> 0)
                                                   or (bal.CRdosq + bal.CRkosq <> 0) or (bal.CRdos + bal.CRkos <> 0) or (bal.CUdosq + bal.CUkosq <> 0) or (bal.CUdos + bal.CUkos <> 0)
                                                 )
                                            and bal.adj_bal <> 0
                                  ) acc
                                  --Процентные ставки по счетам
                                  left join nbur_dm_acnt_rates rates on (acc.kf = rates.kf)
                                                                        and (acc.acc_id = rates.acc_id)
                                                                        and (acc.rate_type = rates.rate_tp)
                                 --Связка счетов и договоров
                                 left join nbur_dm_agrm_accounts agrm_acc on (acc.kf = agrm_acc.kf)
                                                                             and (acc.acc_id = agrm_acc.acc_id)
                                                                             and (acc.agreement_type = agrm_acc.prtfl_tp)
                                 --Берем наши договора
                                 left join nbur_dm_agreements agrm on (acc.kf = agrm.kf)
                                                                      and (agrm_acc.agrm_id = agrm.agrm_id)
                            where  (nvl(rates.rate_val, 0) <> 0 or acc.nbs like '___8')
                   ) t
           )
           select
                   p_report_date as report_date
                   , p_kod_filii as kf
                   , b040 as nbuc
                   , l_version_id
                   , b040
                   , ekp
                   , '#' as r020
                   , r030_1
                   , '#' as r030_2
                   , '#' as k040
                   , s050
                   , '#' as s184
                   , segm_z as f028
                   , '#' as f045
                   , '#' as f046
                   , '#' as f047
                   , '#' as f048
                   , '#' as f049
                   , '#' as f050
                   , '#' as f052
                   , '#' as f053
                   , '#' as f054
                   , '#' as f055
                   , '#' as f056
                   , ddd as f057
                   , '#' as f070
                   , '0000000000' as k020
                   , null as q001_1
                   , null as q001_2
                   , null as q003_1
                   , '00000' as q003_2
                   , '0' as q003_3
                   , null as q006
                   , null as q007_1
                   , null as q007_2
                   , null as q007_3
                   , q010_1
                   , q010_2
                   , null as q012
                   , null as q013
                   , null as q021
                   , null as q022
                   , t071
                   --Сохраним ниформацию откуда у нас появилась данная запись
                   , '#1A' as description
                   , acc_id
                   , acc_num
                   , kv
                   , maturity_date
                   , cust_id
                   , null as ref
                   , agrm_id as nd
                   , branch
           from    (
                     select
                            'A4P006' as EKP
                            , null as S050
                            , to_char(round(abs(acc.adj_bal / 100))) as T071
                            , ccy_id as R030_1
                            , '0' as Q010_1
                            , '0000' as Q010_2
                            , cust_code as K020
                            --Доп. параметры
                            , acc.*
                     from   w_accounts acc
                     where (acc.ddd not in ('410', '421', '422', '430', '440', '450'))
                     union all
                     select
                           case when maturity_date <= p_report_date then 'A4P006' else 'A4P007' end as EKP
                           , case when maturity_date <= p_report_date then null else '1' end as s050
                           , to_char(round(abs(acc.adj_bal / 100))) as T071
                           , ccy_id as R030_1
                           , case when maturity_date <= p_report_date then '0' else segm_w end as Q010_1
                           , case when maturity_date <= p_report_date then '0000' else segm_god end as Q010_2
                           , cust_code as K020
                           --Доп. параметры
                           , acc.*
                    from   w_accounts acc
                    where (acc.ddd not in ('410', '421', '422', '430', '440', '450'))
                    union all
                    --Блок прогнозных значений
                    select
                           'A4P007' as EKP
                           , '1' as s050
                           , TO_CHAR(ABS(round(f_int(acc.acc_id, null, greatest(sch.period_begin_dt, p_report_date), sch.period_end_dt) / 100, 0))) as T071
                           , ccy_id as R030_1
                           , case when sch.freq_mnth >=12 then '0' else f_chr36(to_number(to_char(sch.period_end_dt, 'MM'))) end as Q010_1
                           , to_char(sch.period_end_dt, 'YYYY') as Q010_2
                           , cust_code as K020
                           --Доп. параметры
                           , acc.*
                    from   w_accounts acc
                           join table(F_GET_DEPOSIT_SCHEDULE (acc.agreement_date, acc.maturity_date, acc.int_frq_tp, acc.cust_type)) sch on (sch.period_end_dt >= p_report_date)
                    where acc.ddd in ('230', '262', '270', '271', '272', '273')
                           and nvl(rate_val, 0) <> 0
                           and acc.nbs not like '___8'
                           and acc.maturity_date > p_report_date
                   ) t;

        logger.trace(c_title || 'From source #1A inserted ' || to_char(sql%rowcount) || ' records' );

        commit;
      EXCEPTION
        WHEN OTHERS  THEN
          logger.error(c_title || 'Error inserting rows from source #1A: ' || SQLERRM);
      END;

      --Вставка данных на основании файла #35
      l_counter := 0;
      begin
        for cContract in (
                            select
                               contr_id
                               , credit_type
                               , creditor_type
                               , '0000' as p020
                               , case when credit_type = 0 then '1' when creditor_type = 11 then '3' else '2' end as m
                               , close_date as maturity_date
                               , lpad(substr(okpo, 1, 10), 10, '0') as cust_code
                               , lpad(to_char(kv), 3, '0') as kv
                               , substr(c.num, 1, 16) as p050
                               , to_char(c.open_date, c_date_fmt) as p060
                               , to_char(c.s, c_amount_fmt) as p090
                               , to_char(c.close_date, c_date_fmt) as p310
                               , substr(nmkk, 1, 27) as p101
                               , case when credit_type = 0 then null else to_char(r_agree_date, c_date_fmt) end as p103
                               , substr(benef_name, 1, 54) as p107
                               , credit_type as p140
                               , credit_prepay as p141
                               , (
                                    select nvl(case when max(payment_period)=min(payment_period) then max(decode(payment_period, 14, 4,payment_period)) else 6 end, 6)
                                    from   cim_credgraph_period where contr_id=c.contr_id
                                 ) as p142
                               , f504_reason as p143
                               , f504_note as p999
                               , s
                               , c.branch
                               , c.rnk
                               , lpad(c.country_id,3,'0') as p030
                               , to_char(c.credit_term, 'fm9') as p184
                               , c.borrower_id as p010
                               , decode(c.f503_percent_type, 1, 3, c.f503_percent_type) as p040
                               , c.f503_purpose as p960
                               , decode(c.creditor_type, 11, 1, c.creditor_type) as p108
                               , case
                                   when credit_type = 0 or creditor_type = 11 then '00001'
                                 else
                                   lpad(r_agree_no, 5, '0')
                                 end as nnnnn
                               , c.f503_percent_margin as p070
                               , c.f503_percent as p950
                        from   v_cim_credit_contracts c
                        where  open_date <= p_report_date
                               and status_id not in (1, 9, 10)
                  )
         loop
           --Флаг, были ли добавлены записи по контракту
           l_rows_inserted := false;

           --Установка базовых свойств
           l_row.report_date := p_report_date;
           l_row.kf := p_kod_filii;
           l_row.nbuc := l_cim_nbuc;
           l_row.version_id := l_version_id;
           l_row.r020 := cContract.p020;
           l_row.r030_1 := cContract.kv;
           l_row.K040 := cContract.P030;
           l_row.S184 := cContract.P184;
           l_row.F045 := cContract.m;
           l_row.F047 := cContract.p010;
           l_row.F048 := cContract.p040;
           l_row.F050 := cContract.p960;
           l_row.F052 := cContract.p108;
           l_row.F053 := cContract.p141;
           l_row.F054 := cContract.p142;
           l_row.F055 := cContract.p140;
           l_row.F056 := cContract.p143;
           l_row.Q001_1 := cContract.p101;
           l_row.Q001_2 := cContract.p107;
           l_row.Q003_1 := cContract.p050;
           l_row.Q003_2 := cContract.nnnnn;
           l_row.Q006 := cContract.p999;
           l_row.Q007_1 := cContract.p060;
           l_row.Q007_2 := cContract.p103; ----
           l_row.Q007_3 := cContract.p310;
           l_row.Q013 := cContract.p070;
           l_row.Q021 := cContract.p090;
           l_row.Q022 := cContract.p950;
           l_row.kv := cContract.kv;
           l_row.maturity_date := cContract.maturity_date;
           l_row.CUST_ID := cContract.rnk;
           l_row.ND := cContract.contr_id;
           l_row.branch := cContract.branch;
           l_row.k020 := cContract.cust_code;
           l_row.DESCRIPTION := '#35';
           --Пустые компоненты
           l_row.B040 := l_cim_nbuc;
           l_row.EKP := null;
           l_row.R030_2 := null;
           l_row.S050 := null;
           l_row.F028 := null;
           l_row.F046 := null;
           l_row.F049 := null;
           l_row.F057 := null;
           l_row.F070 := null;
           l_row.Q003_3 := null;
           l_row.Q010_1 := null;
           l_row.Q010_2 := null;
           l_row.Q012 := null;
           l_row.T071 := null;
           l_row.ACC_ID := null;
           l_row.ACC_NUM := null;
           l_row.REF := null;

           --Вызываем процедуру для получения списка компонент
           cim_reports.get_indicators_f504(
                                            p_contract_n => cContract.Contr_Id
                                            , p_date_z_begin => last_day(add_months(p_report_date, -1)) + 1
                                            , p_date_to => last_day(p_report_date)
                                            , p_indicators_f504 => l_indicators_504
                                          );

           --Показатель 212
           if (l_indicators_504.p212.count > 0)
           then
             for i in l_indicators_504.p212.first .. l_indicators_504.p212.last
             loop
               add_indicator(
                               'A4P003'
                               , l_indicators_504.p212(i).rrrrw
                               , l_indicators_504.p212(i).val
                               , l_row
                               , l_rows_inserted
                               , l_counter
                               , l_#35_rows
                            );
             end loop;
           end if;

           --Показатель 213
           if (l_indicators_504.p213.count > 0)
           then
             for i in l_indicators_504.p213.first .. l_indicators_504.p213.last
             loop
               add_indicator(
                               'A4P003'
                               , l_indicators_504.p213(i).rrrrw
                               , l_indicators_504.p213(i).val
                               , l_row
                               , l_rows_inserted
                               , l_counter
                               , l_#35_rows
                            );
             end loop;
           end if;

           --Показатель 292
           if (l_indicators_504.p292.count > 0)
           then
             for i in l_indicators_504.p292.first .. l_indicators_504.p292.last
             loop
               add_indicator(
                              'A4P003'
                              , l_indicators_504.p292(i).rrrrw
                              , l_indicators_504.p292(i).val
                              , l_row
                              , l_rows_inserted
                              , l_counter
                              , l_#35_rows
                            );
             end loop;
           end if;

           --Показатель 293
           if (l_indicators_504.p293.count > 0)
           then
             for i in l_indicators_504.p293.first .. l_indicators_504.p293.last
             loop
               add_indicator(
                              'A4P003'
                              , l_indicators_504.p293(i).rrrrw
                              , l_indicators_504.p293(i).val
                              , l_row
                              , l_rows_inserted
                              , l_counter
                              , l_#35_rows
                            );
             end loop;
           end if;

           --Если записи по контракту не были вставлены, то добавляем информацию с контрактом
    /*       if not l_rows_inserted
           then
             l_counter := l_counter + 1;
             l_#35_rows(l_counter) := l_row;
           end if;*/
         end loop;

        --Массовая вставка записей в итоговую таблицу
        FORALL i in l_#35_rows.first .. l_#35_rows.last
          INSERT INTO nbur_log_f4px VALUES l_#35_rows(i);

        logger.trace(c_title || 'From source #35 inserted ' || l_counter || ' rows');

        commit;
      exception
        when others then
          logger.error(c_title || 'Error inserting rows from source #35: ' || sqlerrm );
      end;

      --Вставка данных на основе файла #6A
      l_counter := 0;
      begin
        for cContract in (
                           select c.contr_id
                                  , credit_type
                                  , creditor_type
                                  , '0000' as p0200
                                  , case
                                       when credit_type = 0 then 1
                                       when creditor_type = 11 then 3
                                    else
                                       2
                                    end as m
                                  , date_term_change
                                  , lpad(substr(okpo, 1, 10), 10, '0') as ZZZZZZZZZZ
                                  , case when credit_type = 0 or creditor_type = 11 then '00001' else lpad(r_agree_no, 5, '0') end as nnnnn
                                  , substr(nmkk, 1, 27) as p1000
                                  , case when credit_type = 0 then null else r_agree_date end as p1200
                                  , substr(benef_name, 1, 54) as p1300
                                  , decode(creditor_type, 11, 1, creditor_type) as p1400
                                  , borrower_id as p0100
                                  , credit_type as p1500
                                  , credit_prepay as p1600
                                  , (
                                      select
                                             nvl(
                                                 case
                                                   when max(payment_period) = min(payment_period) then max(decode(payment_period, 14, 4, payment_period))
                                                 else
                                                   6
                                                 end
                                                 , 6
                                                )
                                      from   cim_credgraph_period
                                      where  contr_id=c.contr_id
                                    ) as p1700
                                  , f503_reason as p1800
                                  , to_char(c.country_id,'fm000') as p0300
                                  , nvl2(c.f503_percent_type, decode(c.f503_percent_type, 1, 3, c.f503_percent_type), null) as p0400
                                  , substr(c.num, 1, 16) as p0500
                                  , c.open_date as p0600
                                  , nvl2(c.f503_percent_margin, to_char(c.f503_percent_margin, 'fm99990.0000'), '') as p0700
                                  , case when c.f503_percent_type=2 then c.f503_percent_base||' '||c.f503_percent_base_t||' '||c.f503_percent_base_val else '' end as p0800
                                  , nvl2(c.s, to_char(c.s, 'fm9999999999999990'), '') as p0900
                                  , credit_term as p1900
                                  , to_char(f503_state,'fm9') as p3000
                                  , nvl2(c.f503_percent, to_char(c.f503_percent, 'fm990.000'), '') as p9500
                                  , c.f503_purpose as p9600
                                  , c.close_date as p3100
                                  , c.f503_change_info as p9800
                                  , f503_note as p9900
                                  , lpad(kv, 3, '0') as kv
                                  , c.branch
                                  , c.rnk
                                  , c.close_date as maturity_date
                           from   v_cim_credit_contracts c
                           where open_date <= p_report_date
                                 and status_id not in (1, 9, 10)
                         )
        loop
           --Флаг, были ли добавлены записи по контракту
           l_rows_inserted := false;

           --Установка базовых свойств
           l_row.report_date := p_report_date;
           l_row.kf := p_kod_filii;
           l_row.nbuc := l_cim_nbuc;
           l_row.version_id := l_version_id;
           l_row.r020 := cContract.p0200;
           l_row.r030_1 := cContract.kv;
           l_row.K040 := cContract.p0300;
           l_row.S184 := cContract.p1900;
           l_row.F045 := cContract.m;
           l_row.F047 := cContract.p0100;
           l_row.F048 := cContract.p0400;
           l_row.F049 := cContract.p9800;
           l_row.F050 := cContract.p9600;
           l_row.F052 := cContract.p1400;
           l_row.F053 := cContract.p1600;
           l_row.F054 := cContract.p1700;
           l_row.F055 := cContract.p1500;
           l_row.F056 := cContract.p1800;
           l_row.k020 := cContract.zzzzzzzzzz;
           l_row.Q001_1 := cContract.p1000;
           l_row.Q001_2 := cContract.p1300;
           l_row.Q003_1 := cContract.p0500;
           l_row.Q003_2 := cContract.nnnnn;
           l_row.Q006 := cContract.p9900;
           l_row.Q007_1 := to_char(cContract.p0600, c_date_fmt);
           l_row.Q007_2 := to_char(cContract.p1200, c_date_fmt);--
           l_row.Q007_3 := to_char(cContract.p3100, c_date_fmt);
           l_row.Q013 := cContract.p0700;
           l_row.Q021 := cContract.p0900;
           l_row.Q022 := cContract.p9500;
           l_row.kv := cContract.kv;
           l_row.maturity_date := cContract.maturity_date;
           l_row.CUST_ID := cContract.rnk;
           l_row.ND := cContract.contr_id;
           l_row.branch := cContract.branch;
           l_row.DESCRIPTION := '#6A';
           --Пустые компоненты
           l_row.B040 := l_cim_nbuc;
           l_row.EKP := null;
           l_row.R030_2 := null;
           l_row.S050 := null;
           l_row.F028 := null;
           l_row.F046 := null;
           l_row.F057 := null;
           l_row.F070 := null;
           l_row.Q003_3 := null;
           l_row.Q010_1 := null;
           l_row.Q010_2 := null;
           l_row.Q012 := null;
           l_row.T071 := null;
           l_row.ACC_ID := null;
           l_row.ACC_NUM := null;
           l_row.REF := null;

           --Вызываем процедуру для получения списка компонент
           cim_reports.get_indicators_f503(
                                            p_contract_n => cContract.Contr_Id
                                            , p_date_z_begin => trunc(add_months(p_report_date, -1), 'YYYY')
                                            , p_date_z_end => last_day(p_report_date)
                                            , p_indicators_f503 => l_indicators_503
                                          );

           --2010
           add_indicator('A4P001', l_indicators_503.p2010, 1, 1, l_row, l_rows_inserted, l_counter, l_#6A_rows);
           --2011
           add_indicator('A4P001', l_indicators_503.p2011, 2, 1, l_row, l_rows_inserted, l_counter, l_#6A_rows);
           --2012
           add_indicator('A4P001', l_indicators_503.p2012, 2, 2, l_row, l_rows_inserted, l_counter, l_#6A_rows);
           --2013
           add_indicator('A4P001', l_indicators_503.p2013, 2, 3, l_row, l_rows_inserted, l_counter, l_#6A_rows);
           --2014
           add_indicator('A4P001', l_indicators_503.p2014, 2, 4, l_row, l_rows_inserted, l_counter, l_#6A_rows);
           --2039
           l_2039 := nvl(l_indicators_503.p2010, 0) + nvl(l_indicators_503.p2012, 0) + nvl(l_indicators_503.p2013, 0) + nvl(l_indicators_503.p2014, 0);
           add_indicator('A4P001', l_2039, null, null, l_row, l_rows_inserted, l_counter, l_#6A_rows);
           --2016
           add_indicator('A4P002', l_indicators_503.p2016, 1, 1, l_row, l_rows_inserted, l_counter, l_#6A_rows);
           --2017
           add_indicator('A4P003', l_indicators_503.p2017, 1, 1, l_row, l_rows_inserted, l_counter, l_#6A_rows);
           --2018
           add_indicator('A4P003', l_indicators_503.p2018, 1, 2, l_row, l_rows_inserted, l_counter, l_#6A_rows);
           --2020
           add_indicator('A4P003', l_indicators_503.p2020, 1, 3, l_row, l_rows_inserted, l_counter, l_#6A_rows);
           --2021
           add_indicator('A4P003', l_indicators_503.p2021, 2, 4, l_row, l_rows_inserted, l_counter, l_#6A_rows);
           --2022
           add_indicator('A4P004', l_indicators_503.p2022, 1, 1, l_row, l_rows_inserted, l_counter, l_#6A_rows);
           --2023
           add_indicator('A4P004', l_indicators_503.p2023, 1, 1, l_row, l_rows_inserted, l_counter, l_#6A_rows);
           --2024
           add_indicator('A4P004', l_indicators_503.p2024, 2, 1, l_row, l_rows_inserted, l_counter, l_#6A_rows);
           --2025
           l_2025 := nvl(l_indicators_503.p2026, 0) + nvl(l_indicators_503.p2027, 0) + nvl(l_indicators_503.p2028, 0);
           add_indicator('A4P005', l_2025, null, 1, l_row, l_rows_inserted, l_counter, l_#6A_rows);
           --2026
           add_indicator('A4P005', l_indicators_503.p2026, null, 1, l_row, l_rows_inserted, l_counter, l_#6A_rows);
           --2027
           add_indicator('A4P005', l_indicators_503.p2027, null, 1, l_row, l_rows_inserted, l_counter, l_#6A_rows);
           --2028
           add_indicator('A4P005', l_indicators_503.p2028, null, 1, l_row, l_rows_inserted, l_counter, l_#6A_rows);
           --2029
           add_indicator('A4P004', l_indicators_503.p2029, 1, 2, l_row, l_rows_inserted, l_counter, l_#6A_rows);
           --2030
           add_indicator('A4P004', l_indicators_503.p2030, 1, 2, l_row, l_rows_inserted, l_counter, l_#6A_rows);
           --2031
           add_indicator('A4P004', l_indicators_503.p2031, 2, 2, l_row, l_rows_inserted, l_counter, l_#6A_rows);
           --2032
           add_indicator('A4P005', l_indicators_503.p2032, null, 2, l_row, l_rows_inserted, l_counter, l_#6A_rows);
           --2033
           add_indicator('A4P005', l_indicators_503.p2033, null, 2, l_row, l_rows_inserted, l_counter, l_#6A_rows);
           --2034
           add_indicator('A4P005', l_indicators_503.p2034, null, 2, l_row, l_rows_inserted, l_counter, l_#6A_rows);
           --2035
           add_indicator('A4P005', l_indicators_503.p2035, null, 2, l_row, l_rows_inserted, l_counter, l_#6A_rows);
           --2036
           add_indicator('A4P004', l_indicators_503.p2036, 1, 3, l_row, l_rows_inserted, l_counter, l_#6A_rows);
           --2037
           add_indicator('A4P004', l_indicators_503.p2037, 2, 4, l_row, l_rows_inserted, l_counter, l_#6A_rows);
           --2040
           l_2040 := nvl(l_indicators_503.p2022, 0) + nvl(l_indicators_503.p2025,0) + nvl(l_indicators_503.p2029, 0)
                     + nvl(l_indicators_503.p2032, 0) + nvl(l_indicators_503.p2036, 0) + nvl(l_indicators_503.p2037,0);
           add_indicator('A4P004', l_2040, null, null, l_row, l_rows_inserted, l_counter, l_#6A_rows);
           --2041
           l_2041 := nvl(l_indicators_503.p2010, 0) + nvl(l_indicators_503.p2016, 0) - nvl(l_indicators_503.p2022, 0) - nvl(l_indicators_503.p2025, 0);
           add_indicator('A4P006', l_2041, 1, 1, l_row, l_rows_inserted, l_counter, l_#6A_rows);
           --2038
           add_indicator('A4P006', l_indicators_503.p2038, 2, 1, l_row, l_rows_inserted, l_counter, l_#6A_rows);
           --2042
           add_indicator('A4P006', l_indicators_503.p2042, 2, 2, l_row, l_rows_inserted, l_counter, l_#6A_rows);
           --2043
           l_2043 := nvl(l_indicators_503.p2013, 0) + nvl(l_indicators_503.p2020, 0) - nvl(l_indicators_503.p2036, 0);
           add_indicator('A4P006', l_2043, 2, 3, l_row, l_rows_inserted, l_counter, l_#6A_rows);
           --2044
           l_2044 := nvl(l_indicators_503.p2014, 0) + nvl(l_indicators_503.p2021, 0) - nvl(l_indicators_503.p2037, 0);
           add_indicator('A4P006', l_2044, 2, 4, l_row, l_rows_inserted, l_counter, l_#6A_rows);
           --2045
           l_2045 := l_2041 + nvl(l_indicators_503.p2042, 0) + l_2043 + l_2044;
           add_indicator('A4P006', l_2045, null, null, l_row, l_rows_inserted, l_counter, l_#6A_rows);

           --Если записи по контракту не были вставлены, то добавляем информацию с контрактом
    /*       if not l_rows_inserted
           then
             l_counter := l_counter + 1;
             l_#6A_rows(l_counter) := l_row;
           end if;*/
        end loop;

        --Массовая вставка записей в итоговую таблицу
        FORALL i in l_#6A_rows.first .. l_#6A_rows.last
          INSERT INTO nbur_log_f4px VALUES l_#6A_rows(i);

        logger.trace(c_title || 'From source #6A inserted ' || l_counter || ' rows');

        commit;
      exception
        when others then
          logger.error(c_title || 'Error inserting rows from source #6A: ' || sqlerrm);
      end;
  else
    logger.info(c_title || 'Указанная дата не является последним рабочий днем месяца, поэтому не осуществялем запуск отчета!');
  end if;

  logger.info(c_title ||' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
END;
/