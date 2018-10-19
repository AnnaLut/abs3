CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F6EX (
                                          p_kod_filii        varchar2
                                          , p_report_date    date
                                          , p_form_id        number
                                          , p_scheme         varchar2 default 'C'
                                          , p_file_code      varchar2 default '#6E'
                                        )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования 6EX для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.1.004  17/10/2018 (26/09/2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.1.004  17/10/2018';
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  c_title              constant varchar2(100 char) := $$PLSQL_UNIT || '.';
  c_base_currency_id   constant varchar2(3 char) := '980';
  c_ekp_A6E001         constant varchar2(6 char) := 'A6E001';
  c_ekp_A6E002         constant varchar2(6 char) := 'A6E002';
  c_ekp_A6E003         constant varchar2(6 char) := 'A6E003';
  c_ekp_A6E006         constant varchar2(6 char) := 'A6E006';
  c_ekp_A6E007         constant varchar2(6 char) := 'A6E007';
  c_ekp_A6E008         constant varchar2(6 char) := 'A6E008';
  c_date_fmt           constant varchar2(10 char) := 'dd.mm.yyyy';

  l_nbuc                    varchar2(20);
  l_type                    number;
  l_datez                   date := p_report_date + 1;
  l_file_code               varchar2(2) := substr(p_file_code, 2, 2);
  l_mnth_last_work_dt       date; --Последний рабочий день этого месяца
  l_prior_mnth_last_work_dt date; --Последний рабочий день предыдущего месяца
  l_next_mnth_frst_dt       date;
  l_version_id              nbur_lst_files.version_id%type;

  e_ptsn_not_exsts exception;

  pragma exception_init( e_ptsn_not_exsts, -02149 );
BEGIN
  logger.info (
                c_title
                || ' Отчетная дата - ' || to_char(p_report_date, c_date_fmt)
              );

  -- определение начальных параметров (код области или МФО или подразделение)
  nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 0, l_file_code, l_nbuc, l_type);

  l_next_mnth_frst_dt := last_day(trunc(p_report_date)) + 1; --Первый день следующего месяца
  l_mnth_last_work_dt := DAT_NEXT_U(last_day(trunc(p_report_date)) + 1, -1);   --Определяем дату последнего рабочего дня в этом месяце
  l_prior_mnth_last_work_dt := DAT_NEXT_U(trunc(p_report_date, 'MM'), -1); --Определяем дату последнего рабочего дня в предыдущем месяце
  logger.trace(
                c_title 
                || ' Первый день следующего месяца - ' || to_char(l_next_mnth_frst_dt, c_date_fmt)
                || ' Последний рабочий день месяца - ' || to_char(l_mnth_last_work_dt, c_date_fmt)
                || ' Последний рабочий день предыдущего месяца - ' || to_char(l_prior_mnth_last_work_dt, c_date_fmt)
              );

  --Запуск разрешаем только за дату последнего рабочего дня месяца
  if (p_report_date = l_mnth_last_work_dt)
  then 
      --Получим версию файла который сейчас формируется, для связки агрегированного и детального протокола
      l_version_id := coalesce(
                                f_nbur_get_run_version(
                                                        p_file_code => p_file_code
                                                        , p_kf => p_kod_filii
                                                        , p_report_date => p_report_date
                                                      )
                                , -1
                              );
        
        
      logger.trace(c_title || ' Версия файла ' || p_file_code || ' который сейчас формируется - ' || l_version_id);

      --Очистка партиции для хранения временных параметров, необходимых для расчета витрины
      begin
        execute immediate 'truncate table NBUR_TMP_F6EX';
      exception
        when e_ptsn_not_exsts then
          null;
      end;

      --Сначало вставляем данные в промежуточную витрину для анализа
      insert into nbur_tmp_f6ex(report_date, kf, t020, nbs, r011, r013, s181, s240, k040, s190, amount, s080, kol, kol26, restruct_date, k030, m030, k180, k190, blkd, msg_return_flg, default_flg, liquid_type, cust_type, cust_rating, credit_work_flg, s130, description, acc_id, acc_num, kv, maturity_date, cust_id, nd, branch)
            select p_report_date /*report_date*/
                   , p_kod_filii /*kf*/
                   , t.t020 /*t020*/
                   , t.nbs /*nbs*/
                   , t.r011 /*r011*/
                   , t.r013 /*r013*/
                   , t.s181 /*s181*/
                   , t.s240 /*s240*/
                   , t.k040 /*k040*/
                   , t.s190 /*s190*/
                   , t.amount /*amount*/
                   , t.s080 /*s080*/
                   , t.kol /*kol*/
                   , t.kol26 /*kol26*/
                   , t.restruct_date /*restruct_date*/
                   , t.k030 /*k030*/
                   , t.m030 /*m030*/
                   , t.k180 /*k180*/
                   , t.k190 /*k190*/
                   , t.blkd /*blkd*/
                   , t.msg_return_flg /*msg_return_flg*/
                   , t.default_flg /*default_flg*/
                   , t.liquid_type /*liquid_type*/
                   , t.cust_type /*cust_type*/
                   , t.cust_rating /*cust_rating*/
                   , case
                      when t.S080 not in ('J', 'Q', 'L')
                           and (coalesce(t.kol, 0) = 0)
                           and (t.kol26 is null or t.kol26 = '000000000')
                           and (t.restruct_date is null or t.restruct_date < (p_report_date - 180))
                     then
                       '1'
                     else
                       '0'
                     end /*credit_work_flg*/
                   , t.s130 /*s130*/
                   , t.description /*description*/
                   , t.acc_id /*acc_id*/
                   , t.acc_num /*acc_num*/
                   , t.kv /*kv*/
                   , t.maturity_date /*maturity_date*/
                   , t.cust_id /*cust_id*/
                   , t.nd /*nd*/
                   , t.branch /*branch*/
            from   (
                      select
                              t.T020
                              , t.nbs
                              , t.r011
                              , t.r013
                              , t.s181
                              , t.s240
                              , t.k040 as k040
                              , t.s190
                              , t.amount
                              , c.s080 as s080
                              , c.kol as kol
                              , c.kol26 as kol26
                              , case
                                 when t.nd is not null
                                then
                                  fin_nbu.ZN_P_ND_date('DRES', 51, p_report_date, t.ND, t.CUST_ID)
                                else
                                  null
                                end as restruct_date
                              , t.k030
                              , case
                                  when t.MATURITY_DATE is null
                                       or t.MATURITY_DATE <= p_report_date + 30 
                                       -- or t.s240 in ('0', '1', '2', 'I')
                                  then '1'
                                else
                                  '0'
                                end as m030
                              , null as k180
                              , null as k190
                              , --Анализируем наличия кода блокировки на счете
                                case
                                  when t.blc_code_db <> 0 then '1'
                                else
                                  '0'
                                end as blkd
                              , '0' as msg_return_flg --Пока нет информации где хранится данный показатель
                              , null as default_flg
                              , null as liquid_type
                              , s.s130 as s130
                              , case
                                  when t.cust_type = 3 then 'T1'
                                  when (t.cust_type = 2 and t.k070 not in ('12602', '12603', '12702', '12703', '12799'))
                                       or (t.k070 in ('13110', '13120', '13131', '13132', '20002')) then 'T2'
                                  when t.k070 in ('12602', '12603', '12702','12703','12799') then 'T3'
                                end as cust_type
                              , case
                                -- інвестиційний клас
                                 when b.rating in ('BBB', 'BBB+', 'BBB-', 'Baa1', 'Baa2', 'Baa3')
                                      or substr(b.rating, 1, 1) in ('A', 'T', 'F')
                                then
                                  'R1'
                                else
                                  null
                                end as cust_rating
                              , t.DESCRIPTION
                              , t.ACC_ID
                              , t.ACC_NUM
                              , t.kv
                              , t.MATURITY_DATE
                              , t.CUST_ID
                              , t.ND
                              , t.BRANCH
                      from    (
                                --Первичным источником будет данные из файла #A7
                                select
                                      t.SEG_01 as T020
                                      , t.SEG_02 as nbs
                                      , t.SEG_03 as r011
                                      , t.SEG_04 as r013
                                      , t.SEG_05 as s181
                                      , t.SEG_06 as s240
                                      , t.SEG_07 as k030
                                      , t.SEG_08 as s190
                                      , to_number(t.FIELD_VALUE) as amount
                                      , t.DESCRIPTION as description
                                      , t.ACC_ID as acc_id
                                      , t.ACC_NUM as acc_num
                                      , to_number(t.SEG_09) as kv
                                      , t.MATURITY_DATE as maturity_date
                                      , t.CUST_ID as cust_id
                                      , t.ND as nd
                                      , t.BRANCH as branch
                                      , cust.k040
                                      , cust.cust_type
                                      , cust.k070
                                      , ac.blc_code_db
                                from  v_nbur_#a7_dtl t
                                      left join nbur_dm_accounts ac on (ac.kf = p_kod_filii)
                                                                       and (t.ACC_ID = ac.acc_id)
                                      left join nbur_dm_customers cust on (cust.kf = p_kod_filii)
                                                                          and (t.CUST_ID = cust.cust_id)
                                where t.REPORT_DATE = l_mnth_last_work_dt
                                      and t.KF = p_kod_filii
                                      and t.SEG_02 in (
                                                        select distinct t.r020
                                                        from   nbur_dct_f6ex_nbs t
                                                        intersect
                                                        select distinct r020
                                                        from   kod_r020
                                                        where  a010 = 'A7'
                                                               and (d_close is null or d_close > p_report_date)
                                                      )
                                union all
                                --Берем суммы на счетах, если этих данных нет в А7 файле
                                select
                                      case when d.ost < 0 then '1' else '2' end as t020
                                      , ac.nbs
                                      , ac.r011
                                      , ac.r013
                                      , null as s181
                                      , null as s240
                                      , cust.k030
                                      , null as s190
                                      , d.ostq as amount
                                      , null as description
                                      , ac.acc_id
                                      , ac.acc_num
                                      , ac.kv
                                      , ac.maturity_date
                                      , ac.cust_id
                                      , null as nd
                                      , ac.branch
                                      , cust.k040
                                      , cust.cust_type
                                      , cust.k070
                                      , ac.blc_code_db
                                from  nbur_dm_accounts ac
                                      join nbur_dm_balances_daily d on (ac.kf = d.kf)
                                                                       and (ac.acc_id = d.acc_id)
                                      join nbur_dm_customers cust on (ac.kf = cust.kf)
                                                                     and (ac.cust_id = cust.cust_id)
                                where ac.report_date = p_report_date
                                      and ac.kf = p_kod_filii
                                      and d.ost <> 0
                                      and ac.nbs in (
                                                       select distinct t.r020
                                                       from   nbur_dct_f6ex_nbs t
                                                       minus
                                                       select distinct r020
                                                       from   kod_r020
                                                       where  a010 = 'A7'
                                                              and d_close is null or d_close > p_report_date
                                                    )
                              ) t
                              left join (
                                           select  acc, s080, kol, kol26
                                           from    (
                                                     select c.acc, c.s080, c.kol, c.kol26
                                                            , row_number() over (partition by c.acc order by c.nd desc) rn
                                                     from   rez_cr c
                                                     where  (c.fdat = l_next_mnth_frst_dt)
                                                    )
                                           where rn = 1
                                        ) c  on (t.ACC_ID = c.acc)
                              left join specparam s on (t.ACC_ID = s.acc)
                              left join custbank b on (t.CUST_ID = b.rnk)
                   ) t;

          logger.trace(c_title || ' В таблицу используемую для расчетов вставлено - ' || sql%rowcount || ' записей');

          --Очищаем субпартицию для хранения детального протокола по файлу
          begin
            execute immediate 'alter table NBUR_LOG_F6EX truncate subpartition for ( to_date('''
                              || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
          exception
            when e_ptsn_not_exsts then
              null;
          end;

          --Вставка данных в детальный протокол
          insert into nbur_log_f6ex(report_date, kf, version_id, nbuc, ekp, rule_id, r030, t100, t100_pct, description, acc_id, acc_num, kv, maturity_date, cust_id, nd, branch)
            select             /*+ PARALLEL(8) */
                               p_report_date /*report_date*/
                               , p_kod_filii /*kf*/
                               , l_version_id /*version_id*/
                               , p_kod_filii /*nbuc*/
                               , n.ekp /*ekp*/
                               , n.rule_id /*rule_id*/
                               , (case when nvl(e.R030_980, '0') = '1' then c_base_currency_id else lpad(to_char(t.KV), 3, '0') end)/*r030*/
                               , t.amount * nvl(n.factor, 1) /*t100*/
                               , case
                                   when t.kv = 980 then coalesce(n.lcy_pct, e.lcy_pct)
                                 else
                                   coalesce(n.fcy_pct, e.fcy_pct)
                                 end /*t100_pct*/--Коэфициент учета в агрегированном показателе
                               , t.DESCRIPTION /*description*/
                               , t.ACC_ID /*acc_id*/
                               , t.ACC_NUM /*acc_num*/
                               , t.KV /*kv*/
                               , t.MATURITY_DATE /*maturity_date*/
                               , t.CUST_ID /*cust_id*/
                               , t.ND /*nd*/
                               , t.BRANCH /*branch*/
            from   nbur_tmp_f6ex t
                   --Маппирование показателей
                   join nbur_dct_f6ex_nbs n on ((t.nbs = nvl(n.r020, t.nbs)) or (t.nbs is null and n.r020 is null))
                                               and ((t.t020 = nvl(n.t020, t.t020)) or (t.t020 is null and n.t020 is null))
                                               and ((t.r011 = nvl(n.r011, t.r011)) or (t.r011 is null and n.r011 is null))
                                               and ((t.r013 = nvl(n.r013, t.r013)) or (t.r013 is null and n.r013 is null))
                                               and ((t.s130 = nvl(n.s130, t.s130)) or (t.s130 is null and n.s130 is null))
                                               and ((t.k030 = nvl(n.k030, t.k030)) or (t.k030 is null and n.k030 is null))
                                               and ((t.m030 = nvl(n.m030, t.m030)) or (t.m030 is null and n.m030 is null))
                                               and ((t.k040 = nvl(n.k040, t.k040)) or (t.k040 is null and n.k040 is null))
                                               and ((t.k180 = nvl(n.k180, t.k180)) or (t.k180 is null and n.k180 is null))
                                               and ((t.k190 = nvl(n.k190, t.k190)) or (t.k190 is null and n.k190 is null))
                                               and ((t.s240 = nvl(n.s240, t.s240)) or (t.s240 is null and n.s240 is null))
                                               and ((t.blkd = nvl(n.blkd, t.blkd)) or (t.blkd is null and n.blkd is null))
                                               and ((t.msg_return_flg = nvl(n.msg_return_flg, t.msg_return_flg)) or (t.msg_return_flg is null and n.msg_return_flg is null))
                                               and ((t.default_flg = nvl(n.default_flg, t.default_flg)) or (t.default_flg is null and n.default_flg is null))
                                               and ((t.liquid_type = nvl(n.liquid_type, t.liquid_type)) or (t.liquid_type is null and n.liquid_type is null))
                                               and ((t.credit_work_flg = nvl(n.credit_work_flg, t.credit_work_flg)) or (t.credit_work_flg is null and n.credit_work_flg is null))
                                               and ((t.cust_type = nvl(n.cust_type, t.cust_type)) or (t.cust_type is null and n.cust_type is null))
                                               and ((t.cust_rating = nvl(n.cust_rating, t.cust_rating)) or (t.cust_rating is null and n.cust_rating is null))
                   join nbur_dct_f6ex_ekp e on (n.ekp = e.ekp)
            where  t.report_date = p_report_date
                   and t.kf = p_kod_filii;

        logger.trace(c_title || ' В детальный протокол файла вставлено ' || sql%rowcount || ' записей');

        --Теперь на основании детального протокола формируем агрегированные данные
        insert into nbur_agg_protocols(
                                        report_date
                                        , kf
                                        , report_code
                                        , nbuc
                                        , field_code
                                        , field_value
                                     )

                with w_source_data as
                (
                          select coalesce(t.ekp, e.ekp) as ekp
                                  , coalesce(t.r030, e.r030) as r030
                                  , coalesce(t.t100, e.t100) as t100
                                  , coalesce(t.t100_pct, e.t100) as t100_pct --Значение показателя в агрегации показателей
                           from   (
                                    select
                                           t.ekp
                                           , case when e.grp_r030 = 1 then t.r030 else '#' end as r030
                                           , case
                                               when e.constant_value is null then abs(sum(t.t100))
                                             else
                                               to_number(e.constant_value)
                                             end as t100
                                           , case
                                               when e.constant_value is null then abs(sum(t.t100 * coalesce(t.t100_pct / 100.0, 1)))
                                             else
                                               to_number(e.constant_value)
                                             end as t100_pct
                                    from   nbur_log_f6ex t
                                           join nbur_dct_f6ex_ekp e on (t.ekp = e.ekp)
                                    where  report_date = p_report_date
                                           and kf = p_kod_filii
                                    group by
                                           t.ekp
                                           , case when e.grp_r030 = 1 then t.r030 else '#' end
                                           , e.grp_r030
                                           , e.constant_value
                                   ) t
                                   full join (
                                               --Добавление константных параметров
                                               select ekp
                                                      , case when grp_r030 = 1 then c_base_currency_id else '#' end as r030
                                                      , to_number(constant_value) as t100
                                               from   nbur_dct_f6ex_ekp
                                               where  constant_value is not null
                                             ) e on (t.ekp = e.ekp and t.r030 = e.r030)
                            order by
                                   ekp
                )
                select p_report_date /*report_date*/
                       , p_kod_filii /*kf*/
                       , p_file_code /*report_code*/
                       , p_kod_filii /*nbuc*/
                       , ekp || r030
                       , t100
                from   (
                          --Схлопнутые показатели согласно классификатора
                          select ekp
                                 , r030
                                 , t100
                          from   w_source_data
                          union all
                          --Добавляем агрегирующие показатели
                          select a.aggr_ekp as ekp
                                 , case when e.grp_r030 = 1 then d.r030 else '#' end as r030
                                 , sum(d.t100_pct) as t100                         
                          from   (
                                   --Построение иерархии параметров
                                   SELECT aggr_ekp
                                          , ekp
                                   FROM   (
                                            select   CONNECT_BY_ROOT t.ekp as aggr_ekp
                                                     , CONNECT_BY_ISLEAF as isLeaf
                                                     , t.ekp
                                            from     nbur_dct_f6ex_ekp t
                                            connect by prior t.ekp = t.aggr_ekp
                                          )
                                   where  isLeaf = 1
                                          and aggr_ekp != ekp
                                 ) a
                                 join w_source_data d on (a.ekp = d.ekp)
                                 join nbur_dct_f6ex_ekp e on (a.aggr_ekp = e.ekp)
                          group by
                                 a.aggr_ekp
                                 , case when e.grp_r030 = 1 then d.r030 else '#' end
                      )
                order by
                      ekp
                      , r030;

        logger.trace(c_title || ' В агрегированный протокол добавлено - ' || sql%rowcount || ' записей');

        commit;

        --Расчет показателей, заданных как формула
        insert into nbur_agg_protocols(report_date, kf, report_code, nbuc, field_code, field_value)
          select  p_report_date /*report_date*/
                  , p_kod_filii /*kf*/
                  , p_file_code /*report_code*/
                  , p_kod_filii /*nbuc*/
                  , t.ekp || t.r030 /*field_code*/
                  , t.field_value /*field_value*/
          from      (
                      select r030
                             , to_char(A6E004) as A6E004
                             , to_char((case when A6E004 <> 0 then ROUND(A6E001 / A6E004, 4) / 100 else 0 end), '0.0000') as A6E005
                             , to_char(A6E009) as A6E009
                             , to_char((case when A6E009 <> 0 then ROUND(A6E006 / A6E009, 4) / 100 else 0 end), '0.0000') as A6E010
                      from   (
                                select r030
                                       , A6E001
                                       , A6E006
                                       , ROUND(A6E002 - LEAST(A6E003, 0.75 * A6E002)) as A6E004
                                       , ROUND(A6E007 -  LEAST(A6E008,  0.75 * A6E007)) as A6E009
                                from  (
                                        select r030
                                               , sum(case when ekp = c_ekp_A6E001 then to_number(field_value) else 0 end) as A6E001
                                               , sum(case when ekp = c_ekp_A6E002 then to_number(field_value) else 0 end) as A6E002
                                               , sum(case when ekp = c_ekp_A6E003 then to_number(field_value) else 0 end) as A6E003
                                               , sum(case when ekp = c_ekp_A6E006 then to_number(field_value) else 0 end) as A6E006
                                               , sum(case when ekp = c_ekp_A6E007 then to_number(field_value) else 0 end) as A6E007
                                               , sum(case when ekp = c_ekp_A6E008 then to_number(field_value) else 0 end) as A6E008
                                        from   (
                                                select substr(field_code, 1, 6) as ekp
                                                       , substr(field_code, 7, 3) as r030
                                                       , field_value
                                                from   nbur_agg_protocols
                                                where  report_date = p_report_date
                                                       and kf = p_kod_filii
                                                       and report_code = p_file_code
                                               )
                                        group by
                                              r030
                                      )
                                )
                     )
          unpivot (field_value for ekp in (A6E004 as 'A6E004', A6E005 as 'A6E005', A6E009 as 'A6E009', A6E010 as 'A6E010')) t
          join nbur_dct_f6ex_ekp e on (t.ekp = e.ekp)
                                              and (
                                                    ((e.grp_r030 = 0) and (t.r030 = '#'))
                                                    or
                                                    ((e.grp_r030 = 1) and (t.r030 != '#'))
                                                  );

      logger.trace(c_title || ' На основании формул расчета суммарных показателей вставлено - ' || sql%rowcount || ' записей');
  else
    logger.info(c_title || ' Дата ' || to_char(p_report_date, c_date_fmt) || ' не является последним рабочим днем месяца! Формирование отчета невозможно!');
  end if;

  logger.info (c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
END NBUR_P_F6EX;
/