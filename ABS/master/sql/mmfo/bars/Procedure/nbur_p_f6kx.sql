CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F6KX (
                                          p_kod_filii        varchar2
                                          , p_report_date    date
                                          , p_form_id        number
                                          , p_scheme         varchar2 default 'C'
                                          , p_file_code      varchar2 default '#6K'
                                        )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования 6KX для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.1.006       30/01/2019 (18/12/2018)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.1.006   30/01/2019';
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  c_title              constant varchar2(100 char) := $$PLSQL_UNIT || '.';
  c_base_currency_id   constant varchar2(3 char) := '980';
  c_ekp_A6K001         constant varchar2(6 char) := 'A6K001';
  c_ekp_A6K002         constant varchar2(6 char) := 'A6K002';
  c_ekp_A6K003         constant varchar2(6 char) := 'A6K003';
  c_ekp_A6K006         constant varchar2(6 char) := 'A6K006';
  c_ekp_A6K007         constant varchar2(6 char) := 'A6K007';
  c_ekp_A6K008         constant varchar2(6 char) := 'A6K008';
  c_ekp_A6K083         constant varchar2(6 char) := 'A6K083';
  c_ekp_A6K084         constant varchar2(6 char) := 'A6K084';
  c_ekp_A6K085         constant varchar2(6 char) := 'A6K085';  
  
  c_date_fmt           constant varchar2(10 char) := 'dd.mm.yyyy';

  l_nbuc                    varchar2(20);
  l_type                    number;
  l_datez                   date := p_report_date + 1;
  l_file_code               varchar2(2) := substr(p_file_code, 2, 2);
  l_mnth_last_work_dt       date; --Последний рабочий день этого месяца
  l_prior_mnth_last_work_dt date; --Последний рабочий день предыдущего месяца
  l_next_mnth_frst_dt       date;
  l_version_id              nbur_lst_files.version_id%type;
  l_max_dat_dct_ovdp        date;
  
  l_mrez                    number;
  l_flag                    number;

  e_ptsn_not_exsts exception;

  pragma exception_init( e_ptsn_not_exsts, -02149 );
BEGIN
  logger.info (
                c_title
                || ' Отчетная дата - ' || to_char(p_report_date, c_date_fmt)
              );

  -- определение начальных параметров (код области или МФО или подразделение)
  nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 0, l_file_code, l_nbuc, l_type);

  l_next_mnth_frst_dt := last_day(trunc(p_report_date)) + 1; --Первый день следующего месяца (для даних з розрахунку рнзнрву)
  l_mnth_last_work_dt := DAT_NEXT_U(last_day(trunc(p_report_date)) + 1, -1);   --Определяем дату последнего рабочего дня в этом месяце
  l_prior_mnth_last_work_dt := DAT_NEXT_U(trunc(p_report_date, 'MM'), -1); --Определяем дату последнего рабочего дня в предыдущем месяце
   
  -- дата розрахунку резервiв
  select last_day(trunc(max(dat))) + 1
  into l_next_mnth_frst_dt
  from rez_protocol
  where dat <= l_next_mnth_frst_dt; 
  
  -- за яку дату завантажено довідник по ОВДП
  select max(date_fv) 
  into l_max_dat_dct_ovdp
  from nbur_ovdp_6ex
  where date_fv <= p_report_date; 
  
  logger.trace(
                c_title 
                || ' Первый день следующего месяца - ' || to_char(l_next_mnth_frst_dt, c_date_fmt)
                || ' Последний рабочий день месяца - ' || to_char(l_mnth_last_work_dt, c_date_fmt)
                || ' Последний рабочий день предыдущего месяца - ' || to_char(l_prior_mnth_last_work_dt, c_date_fmt)
              );
              
  PUL.put ('DAT_ZAL', to_char(p_report_date,'dd.mm.yyyy'));              

  --Запуск разрешаем только за дату последнего рабочего дня месяца
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
    execute immediate 'truncate table nbur_tmp_f6EX';
  exception
    when e_ptsn_not_exsts then
      null;
  end;
  
  -- підготовка даних, якщо це не ждекадна дата (коли беремо дані з файлу #А7)
  p_fz7_nn(pdat_ => p_report_date, flag_ => l_flag);
  
  --Сначало вставляем данные в промежуточную витрину для анализа
  if l_flag = 0 then 
      -- з протоколу формування файлу #A7
      insert into nbur_tmp_f6EX(report_date, kf, t020, nbs, r011, r013, s181, s240, k040, s190, amount, s080, kol, 
            kol26, restruct_date, k030, m030, k180, k190, blkd, blkk, msg_return_flg, default_flg, liquid_type, cust_type, 
            cust_rating, credit_work_flg, s130, description, acc_id, acc_num, kv, maturity_date, cust_id, nd, branch)
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
                   , t.blkk /*blkk*/
                   , t.msg_return_flg /*msg_return_flg*/
                   , t.default_flg /*default_flg*/
                   , t.liquid_type /*liquid_type*/
                   , t.cust_type /*cust_type*/
                   , t.cust_rating /*cust_rating*/
                   , case
                      when (t.S080 is null or t.S080 not in ('J', 'Q', 'L'))
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
            from   (select
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
                                       or t.MATURITY_DATE <= p_report_date + 29 
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
                              , --Анализируем наличия кода блокировки на счете
                                case
                                  when t.blc_code_cr <> 0 then '1'
                                else
                                  '0'
                                end as blkk
                              , case 
                                   when acc_type in ('DEP', 'DEN', 'DPF') 
                                   then 
                                      f_nbur_get_autoprolong(t.acc_id, p_report_date) 
                                   else '0'
                                end as msg_return_flg 
                              , null as default_flg
                              , null as liquid_type
                              , t.s130 as s130
                              , case
                                  when t.cust_type = 3 then 'T1'
                                  when (t.cust_type = 2 and t.k070 not in ('12602', '12603', '12702', '12703', '12799'))
                                       or (t.k070 in ('13110', '13120', '13131', '13132', '20002')) then 'T2'
                                  when t.k070 in ('12602', '12603', '12702','12703','12799') then 'T3'
                                end as cust_type
                              , case
                                    -- неінвестиційний клас
                                    when not (b.rating in ('BBB', 'BBB+', 'BBB-', 'Baa1', 'Baa2', 'Baa3')
                                              or substr(b.rating, 1, 1) in ('A', 'T', 'F')) 
                                         or trim(b.rating) is null
                                    then
                                      'R0'
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
                                      , t.k040
                                      , t.cust_type
                                      , t.k070
                                      , t.blc_code_db
                                      , t.blc_code_cr
                                      , t.acc_type
                                      , s.s130
                                from  v_nbur_#z7_dtl t
                                left join specparam s 
                                on (t.ACC_ID = s.acc)
                                where t.report_date = p_report_date
                                      and t.KF = p_kod_filii
                                      and t.SEG_02 in (
                                                        select distinct t.r020
                                                        from nbur_dct_f6KX_nbs t
                                                        where t.r020 is not null
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
                                      , nvl(spec.r011, '0') as r011
                                      , nvl(spec.r013, '0') as r013
                                      , null as s181
                                      , null as s240
                                      , NVL(to_char(2 - MOD(cust.CODCAGENT, 2)), '1') as k030
                                      , null as s190
                                      , d.ostq as amount
                                      , null as description
                                      , ac.acc as acc_id
                                      , ac.nls as acc_num
                                      , ac.kv
                                      , ac.mdate as maturity_date
                                      , ac.rnk as cust_id
                                      , null as nd
                                      , ac.branch
                                      , lpad(NVL(to_char(cust.country),'804'), 3, '0') as k040
                                      , nvl(cust.custtype, 0) as cust_type
                                      , nvl(cust.ise,'00000') as k070
                                      , ac.blkd as blc_code_db
                                      , ac.blkk as blc_code_cr
                                      , ac.tip as acc_type  
                                      , spec.s130   
                                from  accounts ac
                                      join snap_balances d 
                                      on (d.fdat = p_report_date and 
                                          ac.kf = d.kf and
                                          ac.acc = d.acc)
                                      join customer cust 
                                      on (ac.kf = cust.kf and 
                                          ac.rnk = cust.rnk)
                                      left outer join specparam spec
                                      on (ac.kf = spec.kf and 
                                          ac.acc = spec.acc)
                                where ac.kf = p_kod_filii
                                      and d.ost <> 0
                                      and ac.nbs = any
                                                    (
                                                       select distinct t.r020
                                                       from   nbur_dct_f6KX_nbs t
                                                       where t.r020 is not null
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
                              left join custbank b on (t.CUST_ID = b.rnk)
                   ) t;
      else
          -- з RNBU_TRACE після розрахунку Z7
          insert into nbur_tmp_f6EX(report_date, kf, t020, nbs, r011, r013, s181, s240, k040, s190, amount, s080, kol, 
                kol26, restruct_date, k030, m030, k180, k190, blkd, blkk, msg_return_flg, default_flg, liquid_type, cust_type, 
                cust_rating, credit_work_flg, s130, description, acc_id, acc_num, kv, maturity_date, cust_id, nd, branch)
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
                       , t.blkk /*blkk*/
                       , t.msg_return_flg /*msg_return_flg*/
                       , t.default_flg /*default_flg*/
                       , t.liquid_type /*liquid_type*/
                       , t.cust_type /*cust_type*/
                       , t.cust_rating /*cust_rating*/
                       , case
                          when (t.S080 is null or t.S080 not in ('J', 'Q', 'L'))
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
                                           or t.MATURITY_DATE <= p_report_date + 29
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
                                  , --Анализируем наличия кода блокировки на счете
                                    case
                                      when t.blc_code_cr <> 0 then '1'
                                    else
                                      '0'
                                    end as blkk
                                  , case 
                                       when acc_type in ('DEP', 'DEN', 'DPF') 
                                       then 
                                          f_nbur_get_autoprolong(t.acc_id, p_report_date) 
                                       else '0'
                                    end as msg_return_flg 
                                  , null as default_flg
                                  , null as liquid_type
                                  , t.s130 as s130
                                  , case
                                      when t.cust_type = 3 then 'T1'
                                      when (t.cust_type = 2 and t.k070 not in ('12602', '12603', '12702', '12703', '12799'))
                                           or (t.k070 in ('13110', '13120', '13131', '13132', '20002')) then 'T2'
                                      when t.k070 in ('12602', '12603', '12702','12703','12799') then 'T3'
                                    end as cust_type
                                  , case
                                        -- неінвестиційний клас
                                        when not (b.rating in ('BBB', 'BBB+', 'BBB-', 'Baa1', 'Baa2', 'Baa3')
                                                  or substr(b.rating, 1, 1) in ('A', 'T', 'F')) 
                                             or trim(b.rating) is null
                                        then
                                          'R0'
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
                                          , t.k040
                                          , t.cust_type
                                          , t.k070
                                          , t.blc_code_db
                                          , t.blc_code_cr
                                          , t.acc_type
                                          , s.s130
                                    from  v_nbur_#z7_tmp_dtl t 
                                    left join specparam s 
                                    on (t.acc_id = s.acc)
                                    where t.SEG_02 in (
                                                            select distinct t.r020
                                                            from nbur_dct_f6KX_nbs t
                                                            where t.r020 is not null
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
                                          , nvl(spec.r011, '0') as r011
                                          , nvl(spec.r013, '0') as r013
                                          , null as s181
                                          , null as s240
                                          , NVL(to_char(2 - MOD(cust.CODCAGENT, 2)), '1') as k030
                                          , null as s190
                                          , d.ostq as amount
                                          , null as description
                                          , ac.acc as acc_id
                                          , ac.nls as acc_num
                                          , ac.kv
                                          , ac.mdate as maturity_date
                                          , ac.rnk as cust_id
                                          , null as nd
                                          , ac.branch
                                          , lpad(NVL(to_char(cust.country),'804'), 3, '0') as k040
                                          , nvl(cust.custtype, 0) as cust_type
                                          , nvl(cust.ise,'00000') as k070
                                          , ac.blkd as blc_code_db
                                          , ac.blkk as blc_code_cr
                                          , ac.tip as acc_type  
                                          , spec.s130   
                                    from  accounts ac
                                          join snap_balances d 
                                          on (d.fdat = p_report_date and 
                                              ac.kf = d.kf and
                                              ac.acc = d.acc)
                                          join customer cust 
                                          on (ac.kf = cust.kf and 
                                              ac.rnk = cust.rnk)
                                          left outer join specparam spec
                                          on (ac.kf = spec.kf and 
                                              ac.acc = spec.acc)
                                    where ac.kf = p_kod_filii
                                          and d.ost <> 0
                                          and ac.nbs = any
                                                        (
                                                           select distinct t.r020
                                                           from   nbur_dct_f6KX_nbs t
                                                           where t.r020 is not null
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
                                  left join custbank b on (t.CUST_ID = b.rnk)
                       ) t;
      end if;

      logger.trace(c_title || ' В таблицу используемую для расчетов вставлено - ' || sql%rowcount || ' записей');

      --Очищаем субпартицию для хранения детального протокола по файлу
      begin
        execute immediate 'alter table NBUR_LOG_F6KX truncate subpartition for ( to_date('''
                          || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
      exception
        when e_ptsn_not_exsts then
          null;
      end;

      --Вставка данных в детальный протокол
      insert into nbur_log_f6KX(report_date, kf, version_id, nbuc, ekp, rule_id, r030, t100, t100_pct, description, acc_id, acc_num, kv, maturity_date, cust_id, nd, branch)
        select             /*+ PARALLEL(8) */
                           p_report_date /*report_date*/
                           , p_kod_filii /*kf*/
                           , l_version_id /*version_id*/
                           , p_kod_filii /*nbuc*/
                           , n.ekp /*ekp*/
                           , n.rule_id /*rule_id*/
                           , (case when nvl(e.R030_980, '0') = '1' then c_base_currency_id else lpad(to_char(t.KV), 3, '0') end)/*r030*/
                           , round((case when n.ekp in ('A6K011') and substr(acc_num, 1, 4) in ('1400', '1410', '1420') -- необтяжені ОВДП
                                   then nvl(f_nbur_get_sum_ovdp(acc_id, p_report_date, l_max_dat_dct_ovdp), t.amount * nvl(n.factor, 1)) 
                                   else t.amount * nvl(n.factor, 1) 
                             end), 0)/*t100*/
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
        from   nbur_tmp_f6EX t
               --Маппирование показателей
               join nbur_dct_f6KX_nbs n on ((t.nbs = nvl(n.r020, t.nbs)) or (t.nbs is null and n.r020 is null))
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
                                           and ((t.blkd = n.blkd and n.blkd is not null) or n.blkd is null) 
                                           and ((t.blkk = n.blkk and n.blkk is not null) or n.blkk is null)
                                           and ((t.msg_return_flg = nvl(n.msg_return_flg, t.msg_return_flg)) or (t.msg_return_flg is null and n.msg_return_flg is null))
                                           and ((t.default_flg = nvl(n.default_flg, t.default_flg)) or (t.default_flg is null and n.default_flg is null))
                                           and ((t.liquid_type = nvl(n.liquid_type, t.liquid_type)) or (t.liquid_type is null and n.liquid_type is null))
                                           and ((t.credit_work_flg = nvl(n.credit_work_flg, t.credit_work_flg)) or (t.credit_work_flg is null and n.credit_work_flg is null))
                                           and ((t.cust_type = nvl(n.cust_type, t.cust_type)) or (t.cust_type is null and n.cust_type is null))
                                           and ((t.cust_rating = nvl(n.cust_rating, t.cust_rating)) or (t.cust_rating is null and n.cust_rating is null))
               join nbur_dct_f6KX_ekp e on (n.ekp = e.ekp)
        where  t.report_date = p_report_date
               and t.kf = p_kod_filii;

    logger.trace(c_title || ' В детальный протокол файла вставлено ' || sql%rowcount || ' записей');
        
    -- сума обовязкових резервів
    begin
        select nvl(sum(sum_mrez), 0)
        into l_mrez
        from nbur_kor_6EX_mrez
        where p_report_date between date_begin and nvl(date_end, p_report_date)
          and kf = p_kod_filii;
    end;         

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
                              , sum((case when coalesce(t.ekp, e.ekp) = 'A6K011' and coalesce(t.r030, e.r030) <> '980' 
                                          then coalesce(t.t100_pct, e.t100) 
                                          else 0 end)) over () kor_A6K011 -- сума по покзнику A6K011 (крім гривні)
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
                                from   nbur_log_f6KX t
                                       join nbur_dct_f6KX_ekp e on (t.ekp = e.ekp)
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
                                           from   nbur_dct_f6KX_ekp
                                           where  constant_value is not null
                                         ) e on (t.ekp = e.ekp and t.r030 = e.r030)
                        order by ekp
            )
            select p_report_date /*report_date*/
                   , p_kod_filii /*kf*/
                   , p_file_code /*report_code*/
                   , p_kod_filii /*nbuc*/
                   , ekp || r030
                   , round(t100 - (case when ekp in (c_ekp_A6K001, c_ekp_A6K006) and r030 in ('#', '980') then l_mrez else 0 end) 
                                + (case when ekp in (c_ekp_A6K001) and r030 in ('980') then kor_A6K011 else 0 end)
                                - (case when ekp in (c_ekp_A6K083) and r030 in ('#', '980') then kor_A6K011 else 0 end)) as t100
            from   (
                      --Схлопнутые показатели согласно классификатора
                      select w.ekp
                             , w.r030
                             , w.t100
                             , w.kor_A6K011
                      from   w_source_data w
                      join nbur_dct_f6KX_ekp e on (w.ekp = e.ekp)
                      where e.incl_980 is null or -- всі валюти
                            e.incl_980 = '0' and w.r030 <> '980' or -- лише іноземна валюта
                            e.incl_980 = '1' and w.r030 = '980' or -- лише гривна
                            e.incl_980 = '2' and w.r030 not in ('959', '961', '962', '964') -- не включаємо банк. метали
                      union all
                      --Добавляем агрегирующие показатели
                      select (case when a.aggr_ekp = c_ekp_A6K001 and r030 = 980 then c_ekp_A6K001 
                                   when a.aggr_ekp = c_ekp_A6K001 and r030 <> 980 then c_ekp_A6K083
                                   when a.aggr_ekp = c_ekp_A6K002 and r030 = 980 then c_ekp_A6K002 
                                   when a.aggr_ekp = c_ekp_A6K002 and r030 <> 980 then c_ekp_A6K084
                                   when a.aggr_ekp = c_ekp_A6K003 and r030 = 980 then c_ekp_A6K003 
                                   when a.aggr_ekp = c_ekp_A6K003 and r030 <> 980 then c_ekp_A6K085
                                   else a.aggr_ekp end) as ekp
                             , (case when e.grp_r030 = 1 and not (a.aggr_ekp in (c_ekp_A6K001, c_ekp_A6K002, c_ekp_A6K003) and r030 <> 980) then d.r030 else '#' end) as r030
                             , sum(d.t100_pct) as t100    
                             , max(kor_A6K011) as kor_A6K011                     
                      from   (
                               --Построение иерархии параметров
                               SELECT aggr_ekp
                                      , ekp
                               FROM   (
                                        select   CONNECT_BY_ROOT t.ekp as aggr_ekp
                                                 , CONNECT_BY_ISLEAF as isLeaf
                                                 , t.ekp
                                        from     nbur_dct_f6KX_ekp t
                                        connect by prior t.ekp = t.aggr_ekp
                                      )
                               where  isLeaf = 1
                                      and aggr_ekp != ekp
                             ) a
                             join w_source_data d on (a.ekp = d.ekp)
                             join nbur_dct_f6KX_ekp e on (a.aggr_ekp = e.ekp)
                      group by
                             (case when a.aggr_ekp = c_ekp_A6K001 and r030 = 980 then c_ekp_A6K001 
                                   when a.aggr_ekp = c_ekp_A6K001 and r030 <> 980 then c_ekp_A6K083
                                   when a.aggr_ekp = c_ekp_A6K002 and r030 = 980 then c_ekp_A6K002 
                                   when a.aggr_ekp = c_ekp_A6K002 and r030 <> 980 then c_ekp_A6K084
                                   when a.aggr_ekp = c_ekp_A6K003 and r030 = 980 then c_ekp_A6K003 
                                   when a.aggr_ekp = c_ekp_A6K003 and r030 <> 980 then c_ekp_A6K085
                                   else a.aggr_ekp end)
                             , (case when e.grp_r030 = 1 and not (a.aggr_ekp in (c_ekp_A6K001, c_ekp_A6K002, c_ekp_A6K003) and r030 <> 980) then d.r030 else '#' end)
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
                         , to_char(A6K004) as A6K004
                         , trim(to_char((case when A6K004 <> 0 then ROUND(A6K001 / A6K004, 4) * 100 else 0 end))) as A6K005
                         , to_char(A6K009) as A6K009
                         , trim(to_char((case when A6K009 <> 0 then ROUND(A6K006 / A6K009, 4) * 100 else 0 end))) as A6K010
                         , to_char(A6K086) as A6K086
                         , trim(to_char((case when A6K086 <> 0 then ROUND(A6K083 / A6K086, 4) * 100 else 0 end))) as A6K087
                  from   (
                            select r030
                                   , A6K001
                                   , A6K006
                                   , A6K083
                                   , ROUND(A6K002 - LEAST(A6K003, 0.75 * A6K002)) as A6K004
                                   , ROUND(A6K007 -  LEAST(A6K008,  0.75 * A6K007)) as A6K009
                                   , ROUND(A6K084 -  LEAST(A6K085,  0.75 * A6K084)) as A6K086
                            from  (
                                    select r030
                                           , sum(case when ekp = c_ekp_A6K001 then to_number(field_value) else 0 end) as A6K001
                                           , sum(case when ekp = c_ekp_A6K002 then to_number(field_value) else 0 end) as A6K002
                                           , sum(case when ekp = c_ekp_A6K003 then to_number(field_value) else 0 end) as A6K003
                                           , sum(case when ekp = c_ekp_A6K006 then to_number(field_value) else 0 end) as A6K006
                                           , sum(case when ekp = c_ekp_A6K007 then to_number(field_value) else 0 end) as A6K007
                                           , sum(case when ekp = c_ekp_A6K008 then to_number(field_value) else 0 end) as A6K008
                                           , sum(case when ekp = c_ekp_A6K083 then to_number(field_value) else 0 end) as A6K083
                                           , sum(case when ekp = c_ekp_A6K084 then to_number(field_value) else 0 end) as A6K084
                                           , sum(case when ekp = c_ekp_A6K085 then to_number(field_value) else 0 end) as A6K085
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
      unpivot (field_value for ekp in (A6K004 as 'A6K004',
                                       A6K005 as 'A6K005', 
                                       A6K009 as 'A6K009', 
                                       A6K010 as 'A6K010', 
                                       A6K086 as 'A6K086', 
                                       A6K087 as 'A6K087')) t          
      join nbur_dct_f6KX_ekp e 
      on (t.ekp = e.ekp and 
          (e.grp_r030 = 0 and t.r030 = '#' or
           e.grp_r030 = 1 and t.r030 != '#')
          )
      where e.incl_980 is null or -- всі валюти
            e.incl_980 = '0' and t.r030 <> '980' or -- лише іноземна валюта
            e.incl_980 = '1' and t.r030 = '980' or -- лише гривна
            e.incl_980 = '2' and t.r030 not in ('959', '961', '962', '964'); -- не включаємо банк. метали

  logger.trace(c_title || ' На основании формул расчета суммарных показателей вставлено - ' || sql%rowcount || ' записей');

  logger.info (c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
END NBUR_P_F6KX;
/