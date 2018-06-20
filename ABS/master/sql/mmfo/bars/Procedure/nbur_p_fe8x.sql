PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_FE8X.sql =========*** Run *** =
PROMPT ===================================================================================== 

PROMPT *** Create  procedure NBUR_P_FE8X ***

CREATE OR REPLACE PROCEDURE NBUR_P_FE8X (
                                           p_kod_filii  varchar2
                                           , p_report_date      date
                                           , p_form_id          number
                                           , p_scheme           varchar2 default 'C'
                                           , p_file_code        varchar2 default 'E8X'
                                      )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формирования E8X в формате XML для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.18.001  27.03.2018
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_                     char(30)  := 'v.18.001  04.04.2018';

  c_title                  constant varchar2(200 char) := $$PLSQL_UNIT;
  c_date_fmt               constant varchar2(10 char) := 'dd.mm.yyyy'; --Формат преобразования даты в строку
  c_amt_fmt                constant varchar2(50 char) := 'FM9999999999990D0000';  --Формат преобразования числа в строку

  l_datez                  date := p_report_date + 1;
  l_nbuc                   varchar2(20 char);
  l_file_code              varchar2(2 char) := substr(p_file_code, 2, 2);
  l_type                   number;
  

  l_sum_share_capital      number; --сумма "Статутний капітал"
  l_sum_max_contragent_amt number; --Максимальная сумма на одного контрагента
  l_accounting_deal        number; --Признак где ведется учет сделок ЮЛ
  l_branch_tobo            varchar2(255 char); --Идентификатор филиала
  l_branch_region_code     varchar2(10 char); --Код региона филиала
BEGIN
  logger.info (
                c_title
                || ' begin for'
                || ' date = ' || to_char(p_report_date, c_date_fmt)
                || ' kod_filii=' || p_kod_filii
                || ' form_id=' || p_form_id
                || ' p_scheme= ' || p_scheme
              );

  -- определение начальных параметров (код области или МФО или подразделение)
  nbur_files.P_PROC_SET(
                         p_kod_filii
                         , p_file_code
                         , p_scheme
                         , l_datez
                         , 0
                         , l_file_code
                         , l_nbuc
                         , l_type
                       );

  --Определяем настройки из параметров бранча
  l_accounting_deal := nvl(BRANCH_ATTRIBUTE_UTL.GET_VALUE('DPULINE8'), -1);
  l_branch_tobo := LPAD(TRIM(BRANCH_ATTRIBUTE_UTL.GET_VALUE('OUR_TOBO')), 12, 0);

  --Определяем сумму "Статутного капитала" для отсечения клиентов с меньшими суммами
  BEGIN
    SELECT
            SUM (DECODE(SUBSTR (kodp, 1, 1), '1', -1, 1) * TO_NUMBER (znap))
       INTO
            l_sum_share_capital
    FROM    v_banks_report
      WHERE datf = p_report_date
            AND kodf = '01'
            AND SUBSTR (kodp, 2, 5) IN ('05000', '05001', '05002');
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      l_sum_share_capital := 0;
  END;
  IF NVL (l_sum_share_capital, 0) = 0
  THEN
    l_sum_share_capital := NVL (TRIM(BRANCH_ATTRIBUTE_UTL.GET_VALUE('NORM_SK')), 0);
  END IF;

  --Процедура определения максимальной суммы по одному контрагенту
  if p_report_date >= date '2014-05-30'
     and (p_kod_filii in (322669, 311647, 300465, 302076, 303398, 305482))
  then
    l_sum_max_contragent_amt := 5000000;
  elsif  nvl(l_sum_share_capital, 0) <> 0
         and (l_sum_share_capital * 0.01 < l_sum_max_contragent_amt)
  then
    l_sum_max_contragent_amt := l_sum_share_capital * 0.01;
  else
    l_sum_max_contragent_amt := 200000000;
  end if;

  -- код области, где расположен банк
  if substr(l_branch_tobo, 1, 1) in ('0', '1')
  then
    l_branch_region_code := TO_NUMBER (SUBSTR (l_branch_tobo, 2, 2));
  else
    l_branch_region_code := TO_NUMBER (SUBSTR (l_branch_tobo, 7, 2));
  end if;
  --Если 0, то ищем по справочнику банков
  if nvl(l_branch_region_code, '0') = '0'  
  then
    begin
      select to_char(ku)
        into 
             l_branch_region_code
      from   rcukru
      where mfo = p_kod_filii;
    exception
      when others  then   
        l_branch_region_code := '#';
    end;
  end if;
  
  logger.info(
               c_title
               || ' sum_share_capital=' || l_sum_share_capital
               || ' sum_max_contragent_amt=' || l_sum_max_contragent_amt
             );
  --Формируем детальный протокол данных
  insert into nbur_detail_protocols(
                                     report_date
                                     , kf
                                     , report_code
                                     , nbuc
                                     , field_code
                                     , field_value
                                     , description
                                     , acc_id
                                     , acc_num
                                     , kv
                                     , maturity_date
                                     , cust_id
                                     , ref
                                     , nd
                                     ,branch
                                   )  
            --Отбор счетов для формирования счетов
            with w_accounts
            as
            (
                 select /*+ MATERIALIZE */
                        report_date
                        , kf
                        , acc_id
                        , cust_id
                        , nbs
                        , kv
                        , open_date
                        , close_date
                        , acc_num
                        , bal
                        , adj_bal
                        , ddd
                        , p070
                        , r013
                        , ob22
                        --Расчитываем номер договора по порядку у клиента
                        , row_number() over (partition by cust_id order by acc_id) as Q003_1
                        , row_number() over (order by acc_id) as Q003_12
                 from   (
                           select t.*
                                  , DECODE (cust.cust_type, 1, 2, 2, 2, DECODE (cust.k051, '91', 3, 1)) as cust_type
                                  , sum(t.adj_bal) over (partition by t.cust_id) as sum_cust_bal
                           from   (
                                                       select /*+ PARALLEL */
                                                              ac.report_date
                                                              , ac.kf     
                                                              , ac.acc_id
                                                              , ac.cust_id
                                                              , ac.nbs
                                                              , lpad(ac.kv, 3, '0') as kv
                                                              , ac.open_date
                                                              , ac.close_date
                                                              , ac.acc_num
                                                              --Остаток без корректировки
                                                              , decode(ac.kv, 980, bal.ost, bal.ostq) as bal
                                                              --Остаток с корректировкой
                                                              , decode(ac.kv, 980, bal.adj_bal, bal.adj_bal_uah) as adj_bal
                                                              , k.ddd
                                                              , case
                                                                  when ac.nbs in ('2615', '8613') then '2610'
                                                                  when ac.nbs in ('2652', '8652') then '2651'
                                                                  when ac.nbs in ('8021') then '2620'
                                                                  when ac.nbs in ('8022') then '2625'
                                                                  when ac.nbs like '8%' then '2' || substr(ac.nbs, 2, 3)                                                                   
                                                                else
                                                                  ac.nbs
                                                                end as p070
                                                              , ac.r013   
                                                              , ac.ob22
                                                       from   nbur_dm_accounts ac
                                                              join nbur_dm_balances_monthly bal on  (ac.report_date = bal.report_date)
                                                                                                    and (ac.kf = bal.kf)
                                                                                                    and (ac.acc_id = bal.acc_id)  
                                                              join kl_f3_29 k on (replace(substr(ac.nbs, 1, 1), '8', '2') || substr(ac.nbs,2) = k.r020)
                                                                                 and (k.kf = 'E8')                                                            
                                                       where  ac.report_date = p_report_date
                                                              and ac.kf = p_kod_filii
--                                                              and (ac.cust_id= coalesce(&l_cust_id, ac.cust_id))
                                                              --Балансовый счет входит в список счетов для анализа
                                                              and ac.nbs in (SELECT r020 FROM kl_f3_29 WHERE kf = 'E8')
                                                              --Остаток на счета с учетом корректировки не равен 0
                                                              and (bal.adj_bal <> 0)            
                                                              --Счет не входит в список исключаемых
                                                              and not exists(select null from   kf91 q where  ac.acc_num = q.nls and ac.kv = q.kv)    
                                                              and ( 
                                                                    (NVL(k.ddd, '121') = '122' and ac.nbs like '___6%' and bal.ost < 0) 
                                                                    OR (NVL(k.ddd,'121') = '122' and ac.nbs not like '___6%' and bal.ost > 0) 
                                                                    OR (NVL(k.ddd,'121') <> '122' and bal.ost > 0)
                                                                  )                                     
                                                              --Условия отбора в зависимости от типа учета на данном филиале
                                                              and (
                                                                    (l_accounting_deal != 8)
                                                                    --Счет привязан к доп. договору
                                                                    or ac.acc_id in (
                                                                                      SELECT dep_acc
                                                                                      FROM v_dpu_rel_acc_all
                                                                                      WHERE gen_acc IS NOT NULL
                                                                                    )
                                                                    --счет не привязан к основному договору
                                                                    or ac.acc_id NOT IN (
                                                                                          select gen_acc
                                                                                          from   v_dpu_rel_acc_all
                                                                                          WHERE  gen_acc IS NOT NULL                                                                           
                                                                                       )                                                           
                                                                  )
                              ) t
                              join  nbur_dm_customers cust on (t.report_date = cust.report_date)
                                                              and (t.kf = cust.kf)
                                                              and (t.cust_id = cust.cust_id) 
                              left join kl_k070 f on (cust.k070 = f.k070) 
                           where coalesce(f.d_close, t.report_date + 1) > t.report_date   
                       ) ac
               where   ac.open_date >= date '2000-01-01' 
                       ----20,07,2017  по Криму виключаємо консолідовані рахунки фізосіб                      
                       and not (ac.kf = 324805 and ac.cust_id in (29992702, 35051702, 45427002)) 
                       --Сумма больше уставного капитала
                       and ac.sum_cust_bal > l_sum_max_contragent_amt 
                       -- для всех РУ Сбербанка сначала включаем всех клиентов
                       -- у которых сумма остатков больше равна 2000.00
                       -- а затем исключаем клиентов Физлицо у которых сумма < 200000000 (2 млн.)
                       and not (
                                 (ac.report_date >= date '2014-05-30')
                                 and (ac.sum_cust_bal < 200000000)
                                 and (ac.cust_type = 1)
                               )  
            )
            --Формируем информацию по клиентам
            , w_customers as
            (
              select /*+ MATERIALIZE */ 
                     g.cust_id
                     , case when g.cust_type in (1, 3) then 'Фізична особа' else coalesce(g.cust_bank_name, g.cust_name) end as Q001 --010 - назва кредитора
                     , case when g.k030 = 2 and length(trim(g.kod_okpo)) > 8 then g.kod_okpo end as Q029 --019 - код кредитора – нерезидента
                     , case when (p_report_date <= date '2013-08-31' or p_report_date > date '2014-09-29') then decode(g.k030, 1, g.k074, '2') end as K074 --021 - код інституційного сектору економіки                 
                     , nvl(decode(g.k030, 1, g.k110), '00000') as K110 --025 - код виду економічної діяльності кредитора                 
                     , g.K040 as K040 --050 - код країни кредитора
                     , case when g.k030 = '2' or g.cust_type in (1, 3) then '#' else nvl(to_char(g.region_code), '#') end as KU_1 --055 - код регіону кредитора
                     , lpad(to_char(g.k060), 2, '0') as Q020 --060 - код або перелік кодів типу пов’язаної з банком особи         
                     , g.kod_okpo as K020 --ZZZZZZZZZZ --код (номер) кредитора за параметром K020 (пункт 9 додатку 2 до Правил організації статистичної звітності, що подається до НБУ)
                     , to_char(decode(g.cust_type, 1, 3, 2, 1, 3, 2)) as K014 --206 - ознака кредитора 
                     , g.K021 as K021 --A --ознака ідентифікаційного коду/реєстраційного коду/номеру                                       
              from   (
                        select 
                               t.*
                               , case
                                   when t.cust_type = 1 and t.k030 = 1 then lpad(t.cust_bank_id, 10, '0')
                                   when t.cust_type = 1 and t.k030 = 2 then lpad(t.cust_bank_id, 10, '0')
                                   when t.cust_type = 2 and t.k030 = 1 then decode(t.valid_cust_code_flg, 1, t.cust_code, lpad(t.cust_id, 10, '0'))          
                                   when t.cust_type = 2 and t.k030 = 2 then decode(t.valid_cust_code_flg, 1, t.cust_code, 'I' || lpad(trim(t.cust_id), 9, '0'))
                                   when t.cust_type = 3 and t.k030 = 1 then decode(t.valid_cust_code_flg, 1, t.cust_code, decode(t.personal_exist_flg, 1, lpad(t.passport, 10, '0'), lpad(t.cust_id, 10, '0')))
                                   when t.cust_type = 3 and t.k030 = 2 then decode(t.valid_cust_code_flg, 1, t.cust_code, decode(t.personal_exist_flg, 1, 'I' || lpad(t.passport, 9, '0'), 'I' || lpad(to_char(t.cust_id), 9, '0')))
                                 end as kod_okpo                 
                               , case
                                   when t.cust_type = 1 and t.k030 = 1 then '3'
                                   when t.cust_type = 1 and t.k030 = 2 then '4'
                                   when t.cust_type = 2 and t.k030 = 1 then DECODE(t.valid_cust_code_flg, 1, DECODE(t.k070, '13110', 'G', '13120', 'G', '13131', 'G', '13132', 'G', '1' ), 'E') 
                                   when t.cust_type = 2 and t.k030 = 2 then DECODE(t.valid_cust_code_flg, 1, '1', '9') 
                                   when t.cust_type = 3 and t.k030 = 1 then DECODE(t.valid_cust_code_flg, 1, '2', DECODE(t.personal_exist_flg, 1, '6', '9'))
                                   when t.cust_type = 3 and t.k030 = 2 then DECODE(t.valid_cust_code_flg, 1, '2', DECODE(t.personal_exist_flg, 1, 'B', '9'))                                                                                                                                                                                
                                 end as K021 --A --ознака ідентифікаційного коду/реєстраційного коду/номеру                                           
                        from   (
                                  select 
                                         cust.cust_id
                                         , LPAD(trim(cust.cust_code), 10, '0') as cust_code  
                                         , cust.cust_name
                                         , cust.k030
                                         , cust.k070
                                         , cust.k074
                                         , cust.k110
                                         , cust.k040
                                         , cust.k060
                                         , p.ser as cust_doc_serial
                                         , p.numdoc as cust_doc_number
                                         , to_char(nvl(obl.ko, l_branch_region_code)) as region_code
                                         , coalesce(rc.nb, rcb.name) as cust_bank_name
                                         , coalesce(cb.alt_bic, to_char(rc.glb), '0') as cust_bank_id         
                                         , DECODE (cust.cust_type, 1, 2, 2, 2, DECODE (cust.k051, '91', 3, 1)) as cust_type
                                         , (case when trim(translate(cust.cust_code, '09', '  ')) is null then 0 else 1 end) as valid_cust_code_flg
                                         , (case when p.rnk is null then 0 else 1 end) as personal_exist_flg
                                         , substr(replace(trim(p.ser), ' ', '') || NVL(p.numdoc, '000000'), 1, 10) as passport    
                                  from   nbur_dm_customers cust
                                         --Отсекаем только нужных нам клиентов
                                         join (select distinct cust_id from  w_accounts) ac on cust.cust_id = ac.cust_id
                                         left join person p on (cust.cust_id = p.rnk)
                                         left join kodobl_reg obl on (cust.tax_reg_id = obl.c_reg)
                                         left join custbank cb on (cb.rnk = cust.cust_id)
                                         left join rcukru rc on (cb.mfo = rc.mfo)
                                         left join rc_bnk rcb on (trim(cb.alt_bic) = rcb.b010)                                            
                                  where  cust.report_date = p_report_date
                                         and cust.kf = p_kod_filii
                               ) t
                     ) g
            )
            --Отбор информации из договоров, которую енужно вставить в отчет
            , w_agreements as
            (
                select   /*+ MATERIALIZE */
                         r.acc_id
                         , r.agrm_id
                         , case
                             --Если счета процентов
                             when substr(r.nbs, 4, 1) in '8' then 
                                                                     case
                                                                       when (r.nbs like '260%' OR r.nbs = '2650' OR r.nbs = '2655') and (cust_rko_d.rnk is not null) 
                                                                     then 
                                                                       to_date(substr(replace(replace(trim(cust_rko_d.value), ',','/'),'.','/'),1,10), 'dd/mm/yyyy')
                                                                     else
                                                                       coalesce(r.agrm_open_date, r.acc_first_movement_dt)
                                                                     end
                           else    
                             case
                               --Для счетов межбанка берем дату открытия депозита, иначе дата первого движения
                               when r.nbs like '1%' then coalesce(r.agrm_open_date, r.acc_first_movement_dt)
                               
                               when r.nbs like '3%' then
                                                         case
                                                           when r.nbs like '366%' 
                                                         then 
                                                           coalesce(r.agrm_open_date, r.open_date)
                                                         else                                                      
                                                           r.open_date
                                                         end
                               
                               when agrm_type in ('ACC') and cust_rko_d.rnk is not null then coalesce(to_date(substr(replace(replace(trim(cust_rko_d.value), ',', '/'), '.', '/'),1,10), 'dd/mm/yyyy'), open_date)
                             else             
                               coalesce(r.agrm_open_date, r.open_date)
                             end      
                           end as agrm_value_dt          
                         , case 
                             when  r.nbs like '260%' 
                                   or (r.nbs like '2650%' and nvl(r.r013, '0') != '8')
                                   or (r.p070 in ('2625', '2628','2655'))                                
                                   or (r.agrm_type = 'ACC' and cust_rko_d.rnk is not null)
                                   or (r.nbs = '8021')
                                   or (r.p070 like '25%' and r.p070 not in ('2525','2546')) 
                                   or ((r.p070 = '2650' or r.p070 = '2658') and r.ob22 = '01') 
                                   or (r.p070 = '2620' and r.ob22 in ('05','07','17','20','21','22','28','29'))
                           then 
                             null
                           else
                             coalesce(r.agrm_maturity_date, r.close_date)
                           end as agrm_maturity_dt
                         , agrm_num
                         --Процентная ставка
                         , case
                             when r.nbs in ('2600','2605','2620','2625','2650','2655') 
                                  and r.adj_bal > 0 and r.bal < 0 
                           then 
                             rates.ir
                           else
                             acrn_otc.fproc (r.acc_id, r.report_date)
                           end  as rate_value
                from   (
                           select ac.*
                                  , agr.agrm_id    
                                  --Если нашли договор, то берем с типа договора, иначе ставим, что данные со счета
                                  , coalesce(agr.prtfl_tp, 'ACC') as agrm_type
                                  , agr.agrm_open_date
                                  , agr.agrm_maturity_date
                                  , case
                                      --Если договора нет, то бертем из параметров счета
                                      when agr.acc_id is null then coalesce(s.nkd, 'N дог.')
                                    else
                                      coalesce(agrm_num, 'N дог.')             
                                    end as agrm_num   
                                  , (select min(fdat) from saldoa sm where sm.acc = ac.acc_id) as acc_first_movement_dt
                           from   w_accounts ac                      
                                  left join (
                                              select  agr_acc.acc_id
                                                      , agr_acc.agrm_id
                                                      , agr_acc.prtfl_tp
                                                      , agr_acc.beg_dt as agrm_open_date
                                                      , agr_acc.end_dt as agrm_maturity_date
                                                      , agr_acc.agrm_num         
                                                      , row_number() over (partition by agr_acc.acc_id order by decode(agr_acc.prtfl_tp, 'CCK', 0, 1), agr_acc.beg_dt desc) rn
                                              from    nbur_dm_agrm_accounts agr_acc 
                                              where   agr_acc.report_date = p_report_date
                                                      and agr_acc.kf = p_kod_filii
                                                      and (agr_acc.prtfl_tp in ('DPU', 'DPT', 'CCK'))
                                            ) agr on (ac.acc_id = agr.acc_id)              
                                                     and (agr.rn = 1)                                                
                                   --Параметры со спец. счета
                                   left join specparam s on (ac.acc_id = s.acc)  
                       ) r                                
                       left join customerw cust_rko_n on (r.cust_id = cust_rko_n.rnk)
                                                         and (cust_rko_n.tag = 'RKO_N')
                       left join customerw cust_rko_d on (r.cust_id = cust_rko_d.rnk)
                                                         and (cust_rko_d.tag = 'RKO_D')  
                       --Берем процентные ставки для овердрафтов 
                       left join (
                                    select acc_id
                                           , ir
                                    from   (
                                              select e.acc_id
                                                     , i.ir
                                                     , row_number() over (partition by i.acc order by bdat desc) rn       
                                              from   w_accounts e
                                                     join int_ratn i on (e.acc_id = i.acc)
                                                                        and (i.id = 1)
                                              where  i.bdat <= p_report_date
                                           ) rn
                                    where  rn = 1    
                                  ) rates on (r.acc_id = rates.acc_id)                                             
            )
      select 
             report_date
             , kf
             , p_file_code as report_code
             , nbuc
             --Добавляем ид. строки для связки параметров между собой
             , AGR_ROW_NUM || field_code as FIELD_CODE 
             , field_value
             , null as description
             , acc_id
             , acc_num
             , kv
             , null as maturity_date
             , cust_id
             , null as ref
             , agrm_id as nd
             , null as branch 
      from   (                   
                  select 
                         ac.report_date
                         , ac.kf
                         , ac.acc_id
                         , ac.acc_num
                         , ac.cust_id
                         , agr.agrm_id
                         , ac.kv
                         , cust.KU_1 as NBUC
                         , lpad(to_char(ac.Q003_12), 10, '0') as AGR_ROW_NUM

                         , cust.Q001 --010
                         , cust.Q029 --019 - код кредитора – нерезидента
                         , cust.K074 --021 - код інституційного сектору економіки                 
                         , cust.K110 --025 - код виду економічної діяльності кредитора                 
                         , cust.K040 --050 - код країни кредитора
                         , cust.KU_1 --055 - код регіону кредитора
                         , cust.Q020 --060 - код або перелік кодів типу пов’язаної з банком особи         
                         , cust.K020 --ZZZZZZZZZZ --код (номер) кредитора за параметром K020 (пункт 9 додатку 2 до Правил організації статистичної звітності, що подається до НБУ)
                         , cust.K014 --206 - ознака кредитора
                         , cust.K021 --A --ознака ідентифікаційного коду/реєстраційного коду/номеру               

                         , ac.p070 as R020 --балансовий рахунок
                         , ac.kv as R030 --VVV - код валюти    
                         
                         , agr.agrm_num as Q003_2 --090 - унікальний номер (ідентифікатор) договору
                         , to_char(ac.Q003_1) as Q003_1 --nnnn --порядковий номер договору кредитора у звітному файлі                        
                         , to_char(agr.agrm_value_dt, c_date_fmt) as Q007_1 --111 - дата виникнення зобов’язань 
                         , to_char(agr.agrm_maturity_dt, c_date_fmt) as Q007_2 --112 - дата кінцевого погашення зобов’язань 
                         , to_char(nvl(case when ac.ddd = 121 then abs(ac.adj_bal) else 0 end, 0)) as T070_1 --121 - основна сума балансової вартості зобов'язання
                         , to_char(nvl(case when ac.ddd = 122 then ac.adj_bal else 0 end, 0)) as T070_2 --122 - сума неамортизованого дисконту/премії
                         , to_char(nvl(case when ac.ddd = 123 then abs(ac.adj_bal) else 0 end, 0)) as T070_3 --123 - сума нарахованих витрат
                         , to_char(nvl(case when ac.ddd = 124 then abs(ac.adj_bal) else 0 end, 0)) as T070_4 --124 - сума переоцінки (дооцінки/уцінки)
                         , to_char(coalesce(agr.rate_value, 0), c_amt_fmt) as T090 --130 - процентна ставка згідно з договором  
                         , to_char(ac.Q003_12) as Q003_12 --Код строки в формируемом файле                                    
                  from   w_accounts ac
                         join w_customers cust on (ac.cust_id = cust.cust_id)
                         join w_agreements agr on (ac.acc_id = agr.acc_id)
         )
         unpivot (field_value for field_code in (
                                                 Q001
                                                 , Q029
                                                 , K074
                                                 , K110
                                                 , K040
                                                 , KU_1
                                                 , Q020
                                                 , K020
                                                 , K014
                                                 , R020
                                                 , R030
                                                 , Q003_2
                                                 , Q003_1
                                                 , Q007_1
                                                 , Q007_2
                                                 , T070_1
                                                 , T070_2
                                                 , T070_3
                                                 , T070_4
                                                 , T090
                                                 , Q003_12
                                                 , K021
                                                )
                 );

  --Агрегированный нам не нужен, так как агрегированные данные будут поступать из XML-формата

  logger.info (c_title || ' end for date = '||to_char(p_report_date, c_date_fmt));
END NBUR_P_FE8X;
/
PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/NBUR_P_FE8X.sql =========*** End *** =
PROMPT ===================================================================================== 