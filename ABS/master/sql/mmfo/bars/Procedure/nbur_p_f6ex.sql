CREATE OR REPLACE PROCEDURE BARS.NBUR_P_F6EX (
                                          p_kod_filii        varchar2
                                          , p_report_date    date
                                          , p_form_id        number
                                          , p_scheme         varchar2 default 'C'
                                          , p_file_code      varchar2 default '#6E'
                                        )
is
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% DESCRIPTION : Процедура формування 6EX для Ощадного банку
% COPYRIGHT   : Copyright UNITY-BARS Limited, 1999.  All Rights Reserved.
%
% VERSION     :  v.1.008  12/01/2018 (08/01/2019)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  ver_          char(30)  := 'v.1.008  12/01/2019';
/*%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%*/
  c_title                   constant varchar2(100 char) := $$PLSQL_UNIT || '.';
  c_base_currency_id        constant varchar2(3 char) := '980';
  c_date_fmt                constant varchar2(10 char) := 'dd.mm.yyyy';

  l_nbuc                    varchar2(20);
  l_type                    number;
  l_datez                   date := p_report_date + 1;
  l_file_code               varchar2(2) := substr(p_file_code, 2, 2);
  l_mnth_last_work_dt       date; --Последний рабочий день этого месяца
  l_prior_mnth_last_work_dt date; --Последний рабочий день предыдущего месяца
  l_version_id              nbur_lst_files.version_id%type;
  
  l_date1                   date; 
  l_date2                   date; 
  
  l_mrez                    number;

  e_ptsn_not_exsts exception;

  pragma exception_init( e_ptsn_not_exsts, -02149 );
BEGIN
  logger.info (
                c_title
                || ' Звітна дата - ' || to_char(p_report_date, c_date_fmt)
              );

  -- определение начальных параметров (код области или МФО или подразделение)
  nbur_files.P_PROC_SET(p_kod_filii, p_file_code, p_scheme, l_datez, 0, l_file_code, l_nbuc, l_type);

  l_mnth_last_work_dt := DAT_NEXT_U(last_day(trunc(p_report_date)) + 1, -1);   --Определяем дату последнего рабочего дня в этом месяце
  l_prior_mnth_last_work_dt := DAT_NEXT_U(trunc(p_report_date, 'MM'), -1); --Определяем дату последнего рабочего дня в предыдущем месяце
  
  l_date1 := DAT_NEXT_U(trunc(p_report_date, 'mm') - 1, 1); -- перший робочий день поточного місяця
  l_date2 := l_date1 + 29;  --30 календарних днів від l_date1
   
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
        
      logger.trace(c_title || ' Версія файлу' || p_file_code || ' що формується ' || l_version_id);

      --Очистка партиции для хранения временных параметров, необходимых для расчета витрины
      begin
        execute immediate 'truncate table NBUR_TMP_F6EX';
      exception
        when e_ptsn_not_exsts then
          null;
      end;
      
     --Очищаем субпартицию для хранения детального протокола по файлу
      begin
        execute immediate 'alter table NBUR_LOG_F6EX truncate subpartition for ( to_date('''
                          || to_char(p_report_date,'YYYYMMDD')||''',''YYYYMMDD''), ''' || p_kod_filii || ''' )';
      exception
        when e_ptsn_not_exsts then
          null;
      end;
      
      -- тип показників = 1-4
      for kk in (select ekp, aggr_ekp from NBUR_DCT_F6EX_EKP where CONSTANT_VALUE = 1) 
      loop
            insert into NBUR_LOG_F6EX(REPORT_DATE, KF, VERSION_ID, NBUC, EKP, RULE_ID, R030, 
                T100, T100_PCT, DESCRIPTION, ACC_ID, ACC_NUM, KV, MATURITY_DATE, CUST_ID, ND, BRANCH)
            select p_report_date, p_kod_filii, l_version_id, p_kod_filii, 
                d.ekp, c.rule_id, c.r030, c.value as t100, c.t100_pct, 
                'Type '||d.constant_value||' ('||
                (case 
                    when d.constant_value = '1' then 'сума фактичних контрактних надходжень'
                    when d.constant_value = '2' then 'фактична сума роловеру'
                    when d.constant_value = '3' then 'фактична сума лонгацій'   
                    when d.constant_value = '4' then 'сума фактичних понад контрактних надходжень'
                    else ''
                end) || ')' as description, 
                c.acc_id, c.acc_num, c.kv, c.maturity_date, c.cust_id, c.nd, c.branch
            from (select *
                from (select b.*,
                            least(b.sum_fact, b.sum_plan) as sum_1,
                            (case when b.sum_roll > 0 and b.sum_fact > 0 then least(b.sum_roll, b.sum_fact) else 0 end) sum_2,
                            (case when b.fl_prol > 0 and b.sum_fact <= b.sum_plan then b.sum_plan - b.sum_fact else 0 end) sum_3,
                            (case when b.sum_fact > b.sum_plan + b.sum_roll then b.sum_fact - (b.sum_plan + b.sum_roll) else 0 end) sum_4
                      from (with select_6kx as
                                (select a.*,
                                    (select count(*) from cc_prol c where c.nd = a.nd and c.prol_type = 0 and c.fdat between l_date1 and l_date2) fl_prol
                                 from 
                                    (select k.acc_id, k.acc_num, k.kv, k.cust_id, k.nd, k.branch, sum(k.t100) as t100               
                                      from NBUR_LOG_F6KX k
                                      where k.report_date = l_prior_mnth_last_work_dt and 
                                            k.kf = p_kod_filii and
                                            k.ekp = kk.aggr_ekp
                                      group  by k.acc_id, k.acc_num, k.kv, k.cust_id, k.nd, k.branch) a) 
                                select /*+ ordered*/
                                    -1 as RULE_ID, lpad(a.kv, 3, '0') as R030, 0 as T100_PCT, 
                                    o.acc as ACC_ID, a.nls as ACC_NUM, a.kv as KV, 
                                    a.mdate as MATURITY_DATE, a.rnk as CUST_ID, z.nd as ND, a.branch as BRANCH, 
                                    sum(gl.p_icurval(a.kv, (case when o.dk = 1 then o.s else 0 end), l_prior_mnth_last_work_dt)) as sum_fact, 
                                    sum(gl.p_icurval(a.kv, (case when o.dk = 0 then o.s else 0 end), l_prior_mnth_last_work_dt)) as sum_roll,
                                    z.t100 as sum_plan, z.fl_prol
                                from select_6kx z, opldok o, accounts a, opldok o1, accounts a1
                                where o.fdat = any (select fdat from fdat where fdat between l_date1 and l_date2) and
                                    o.acc = z.acc_id and
                                    o.kf = a.kf and                 
                                    o.acc = a.acc and
                                    o.kf = o1.kf and                 
                                    o.ref = o1.ref and
                                    o.stmt = o1.stmt and
                                    o.dk <> o1.dk and
                                    o1.kf = a1.kf and                 
                                    o1.acc = a1.acc and 
                                    o.tt <> '024' and   
                                    trim (a1.tip) not in ('SS', 'SN', 'REZ', 'SP', 'SPN', 'KSP', 'KPN') and
                                    substr(a.nls,1,3) <> substr(a1.nls,1,3) 
                                group by lpad(a.kv, 3, '0'),  o.acc, a.nls, a.kv, a.mdate, a.rnk, a.branch, z.nd, z.t100, z.fl_prol) b) 
                unpivot (value for ekp_type in (SUM_1, SUM_2, SUM_3, SUM_4))) c
            join NBUR_DCT_F6EX_EKP d
            on (c.ekp_type = 'SUM_'||d.constant_value and
                d.aggr_ekp = kk.aggr_ekp); 
      end loop;      
       
      -- тип показників = 5, 8
      insert into NBUR_LOG_F6EX(REPORT_DATE, KF, VERSION_ID, NBUC, EKP, RULE_ID, R030, 
            T100, T100_PCT, DESCRIPTION, ACC_ID, ACC_NUM, KV, MATURITY_DATE, CUST_ID, ND, BRANCH)
      select p_report_date, p_kod_filii, l_version_id, p_kod_filii, 
            n.ekp, n.rule_id, a.kv as r030, abs(a.t100) as t100, 0 as t100_pct, 
            (case when a.t100 > 0 
                then 'Type 5 (сума фактичних відпливів за кредитами овердрафт)'
                else 'Type 8 (сума фактичних надходжень за кредитами овердрафт)'
            end) as description, 
            a.acc_id, a.acc_num, a.kv, a.maturity_date, a.cust_id, a.nd, a.branch
      from (
        select nvl(a.acc, b.acc) as acc_id, nvl(a.nbs, b.nbs) as nbs, nvl(a.nls, b.nls) as acc_num, nvl(a.kv, b.kv) as kv, 
               nvl(a.mdate, b.mdate) as maturity_date, nvl(a.rnk, b.rnk) as cust_id, null as nd, nvl(a.branch, b.branch) as branch, 
               nvl(b.ost, 0) - nvl(a.ost, 0) as t100
        from (select s.acc, a.nbs, a.nls, a.kv, a.mdate, a.rnk, a.branch, abs(gl.p_icurval(a.kv, s.ost+s.dos-s.kos, l_prior_mnth_last_work_dt)) ost
              from snap_balances s, accounts a
              where s.fdat = l_date1 and
                    s.acc = a.acc and
                    a.kf = p_kod_filii and
                    regexp_like(a.nls, '^(1600|26(00|20))') and
                    s.ost+s.dos-s.kos < 0) a
            full outer join 
            (select s.acc, a.nbs, a.nls, a.kv,  a.mdate, a.rnk, a.branch, abs(gl.p_icurval(a.kv, s.ost, l_prior_mnth_last_work_dt)) ost
             from snap_balances s, accounts a
             where s.fdat = l_date2 and
                s.acc = a.acc and
                a.kf = p_kod_filii and
                regexp_like(a.nls, '^(1600|26(00|20))') and
                s.ost < 0) b 
             on (a.acc = b.acc) 
             where nvl(b.ost, 0) - nvl(a.ost, 0)<>0) a
        join nbur_dct_f6ex_ekp e
        on (sign(a.t100) = 1 and e.constant_value = 5 or
            sign(a.t100) = -1 and e.constant_value = 8)  
        join nbur_dct_f6ex_nbs n 
        on (n.ekp = e.ekp and
            a.nbs = n.r020); 
      
      -- тип показників = 6 (чисті кредитні лінії)
      insert into NBUR_LOG_F6EX(REPORT_DATE, KF, VERSION_ID, NBUC, EKP, RULE_ID, R030, 
            T100, T100_PCT, DESCRIPTION, ACC_ID, ACC_NUM, KV, MATURITY_DATE, CUST_ID, ND, BRANCH)
      select p_report_date, p_kod_filii, l_version_id, p_kod_filii, 
            n.ekp, n.rule_id, a.kv as r030, a.t100, 0 as t100_pct, 
            'Type 6 (сума фактичних відпливів за кредитними лініями (включаючи 9 клас))' as description, 
            a.acc_id, a.acc_num, a.kv, a.maturity_date, a.cust_id, a.nd, a.branch
      from (
        select nvl(a.acc, b.acc) as acc_id, nvl(a.nbs, b.nbs) as nbs, nvl(a.nls, b.nls) as acc_num, nvl(a.kv, b.kv) as kv, 
               nvl(a.mdate, b.mdate) as maturity_date, nvl(a.rnk, b.rnk) as cust_id, null as nd, nvl(a.branch, b.branch) as branch, 
               nvl(b.ost, 0) - nvl(a.ost, 0) as t100
        from (select s.acc, a.nbs, a.nls, a.kv, a.mdate, a.rnk, a.branch, abs(gl.p_icurval(a.kv, s.ost+s.dos-s.kos, l_prior_mnth_last_work_dt)) ost
              from cc_deal d, cc_add e, accounts a, snap_balances s
              where d.VIDD in ( 2, 3, 12, 13, 9, 19, 29, 39, 1623, 1624 ) and
                    d.kf = p_kod_filii and
                    d.nd = e.nd and
                    e.accs = a.acc and
                    regexp_like(a.nls, '^(1623|20|22|23|24)') and
                    e.accs = s.acc and
                    s.fdat = l_date1 and
                    s.ost+s.dos-s.kos < 0) a
            full outer join 
            (select s.acc, a.nbs, a.nls, a.kv,  a.mdate, a.rnk, a.branch, abs(gl.p_icurval(a.kv, s.ost, l_prior_mnth_last_work_dt)) ost
             from cc_deal d, cc_add e, accounts a, snap_balances s
             where d.VIDD in ( 2, 3, 12, 13, 9, 19, 29, 39, 1623, 1624 ) and
                   d.kf = p_kod_filii and
                   d.nd = e.nd and
                   e.accs = a.acc and
                   regexp_like(a.nls, '^(1623|20|22|23|24)') and
                   e.accs = s.acc and
                   s.fdat = l_date2 and
                   s.ost < 0) b 
             on (a.acc = b.acc) 
             where nvl(b.ost, 0) - nvl(a.ost, 0)>0) a
        join nbur_dct_f6ex_nbs n 
        on (n.ekp in (select ekp from nbur_dct_f6ex_ekp where constant_value = 6) and
            a.nbs like n.r020 || '%'); 

      -- тип показників = 6 (БПК)
      insert into NBUR_LOG_F6EX(REPORT_DATE, KF, VERSION_ID, NBUC, EKP, RULE_ID, R030, 
            T100, T100_PCT, DESCRIPTION, ACC_ID, ACC_NUM, KV, MATURITY_DATE, CUST_ID, ND, BRANCH)
      select p_report_date, p_kod_filii, l_version_id, p_kod_filii, 
            n.ekp, n.rule_id, a.kv as r030, a.t100, 0 as t100_pct, 
            'Type 6 (сума фактичних відпливів по БПК)' as description, 
            a.acc_id, a.acc_num, a.kv, a.maturity_date, a.cust_id, a.nd, a.branch
      from (
        select nvl(a.acc, b.acc) as acc_id, nvl(a.nbs, b.nbs) as nbs, nvl(a.nls, b.nls) as acc_num, nvl(a.kv, b.kv) as kv, 
               nvl(a.mdate, b.mdate) as maturity_date, nvl(a.rnk, b.rnk) as cust_id, null as nd, nvl(a.branch, b.branch) as branch, 
               nvl(b.ost, 0) - nvl(a.ost, 0) as t100
        from (select s.acc, a.nbs, a.nls, a.kv, a.mdate, a.rnk, a.branch, abs(gl.p_icurval(a.kv, s.ost+s.dos-s.kos, l_prior_mnth_last_work_dt)) ost
              from accounts a, snap_balances s
              where a.acc in (select ACC_ovr from w4_acc) and
                    regexp_like(a.nls, '^(20|22|23|24)') and
                    a.acc = s.acc and
                    s.fdat = l_date1 and
                    s.ost+s.dos-s.kos < 0) a
            full outer join 
            (select s.acc, a.nbs, a.nls, a.kv,  a.mdate, a.rnk, a.branch, abs(gl.p_icurval(a.kv, s.ost, l_prior_mnth_last_work_dt)) ost
             from accounts a, snap_balances s
             where a.acc in (select ACC_ovr from w4_acc) and
                   regexp_like(a.nls, '^(20|22|23|24)') and
                   a.acc = s.acc and
                   s.fdat = l_date2 and
                   s.ost < 0) b 
             on (a.acc = b.acc) 
             where nvl(b.ost, 0) - nvl(a.ost, 0)>0) a
        join nbur_dct_f6ex_nbs n 
        on (n.ekp in (select ekp from nbur_dct_f6ex_ekp where constant_value = 6) and
            a.nbs like n.r020 || '%'); 
            
      -- тип показників = 6 (інше)
      insert into NBUR_LOG_F6EX(REPORT_DATE, KF, VERSION_ID, NBUC, EKP, RULE_ID, R030, 
            T100, T100_PCT, DESCRIPTION, ACC_ID, ACC_NUM, KV, MATURITY_DATE, CUST_ID, ND, BRANCH)
      select p_report_date, p_kod_filii, l_version_id, p_kod_filii, 
            a.ekp, a.rule_id, a.kv as r030, a.t100, 0 as t100_pct, 
            'Type 6 (сума фактичних відпливів - інше)' as description, 
            a.acc_id, a.acc_num, a.kv, a.maturity_date, a.cust_id, a.nd, a.branch
      from (select *
            from (
            with select_6kx as
            (select e.ekp, k.acc_id, k.acc_num, k.maturity_date, k.kv, k.cust_id, k.nd, k.branch, sum(k.t100) as t100               
             from nbur_log_f6kx k, nbur_dct_f6ex_ekp e
              where k.report_date = l_prior_mnth_last_work_dt and 
                    k.kf = p_kod_filii and
                    k.ekp = e.aggr_ekp and
                    e.constant_value = 6 and 
                    e.aggr_ekp is not null
                group by e.ekp, k.acc_id, k.acc_num, k.maturity_date, k.kv, k.cust_id, k.nd, k.branch
            ) 
            select nvl(a.ekp, b.ekp) as ekp, nvl(a.acc_id, b.acc_id) as acc_id, nvl(a.acc_num, b.acc_num) as acc_num, nvl(a.kv, b.kv) as kv, 
                   nvl(a.maturity_date, b.maturity_date) as maturity_date, nvl(a.cust_id, b.cust_id) as cust_id, nvl(a.nd, b.nd) as nd, 
                   nvl(a.branch, b.branch) as branch, -1 as rule_id,
                   nvl(b.ost, 0) - nvl(a.ost, 0) as t100 
            from (    
            select a.ekp, a.acc_id, a.acc_num, a.kv, a.maturity_date, a.cust_id, a.nd, a.branch, 
                abs(gl.p_icurval(a.kv, s.ost+s.dos-s.kos, l_prior_mnth_last_work_dt)) ost
            from snap_balances s, select_6kx a
            where s.acc = a.acc_id and
                s.fdat = l_date1 and
                s.ost+s.dos-s.kos < 0) a
            full outer join 
            (select a.ekp, a.acc_id, a.acc_num, a.kv, a.maturity_date, a.cust_id, a.nd, a.branch, 
                abs(gl.p_icurval(a.kv, s.ost+s.dos-s.kos, l_prior_mnth_last_work_dt)) ost
            from snap_balances s, select_6kx a
            where s.acc = a.acc_id and
                s.fdat = l_date2 and
                s.ost < 0) b 
            on (a.acc_id = b.acc_id) 
            where nvl(b.ost, 0) - nvl(a.ost, 0)>0)             
        ) a;         
                         
      -- тип показників = 7 (рахунки-ескроу)
      insert into NBUR_LOG_F6EX(REPORT_DATE, KF, VERSION_ID, NBUC, EKP, RULE_ID, R030, 
            T100, T100_PCT, DESCRIPTION, ACC_ID, ACC_NUM, KV, MATURITY_DATE, CUST_ID, ND, BRANCH)
      select p_report_date, p_kod_filii, l_version_id, p_kod_filii, 
            a.ekp, a.rule_id, a.kv as r030, a.t100, 0 as t100_pct, 
            'Type 7 (сума фактичних відпливів за рахунками-ескроу)' as description, 
            a.acc_id, a.acc_num, a.kv, a.maturity_date, a.cust_id, a.nd, a.branch
      from (select *
            from (
            with select_6kx as
            (select e.ekp, k.acc_id, k.acc_num, k.maturity_date, k.kv, k.cust_id, k.nd, k.branch, sum(k.t100) as t100               
             from nbur_log_f6kx k, specparam s, nbur_dct_f6ex_ekp e, nbur_dct_f6ex_nbs n
              where k.report_date = l_prior_mnth_last_work_dt and 
                    k.kf = p_kod_filii and
                    k.acc_id = s.acc and
                    k.ekp = e.aggr_ekp and
                    e.constant_value = 7 and 
                    e.aggr_ekp is not null and
                    e.ekp = n.ekp and
                    k.acc_num like n.r020||'%' and
                    (trim(s.r013) = trim(n.r013) or trim(n.r013) is null) and
                    (trim(s.r011) = trim(n.r011) or trim(n.r011) is null) 
                group by e.ekp, k.acc_id, k.acc_num, k.maturity_date, k.kv, k.cust_id, k.nd, k.branch
            ) 
            select nvl(a.ekp, b.ekp) as ekp, nvl(a.acc_id, b.acc_id) as acc_id, nvl(a.acc_num, b.acc_num) as acc_num, nvl(a.kv, b.kv) as kv, 
                   nvl(a.maturity_date, b.maturity_date) as maturity_date, nvl(a.cust_id, b.cust_id) as cust_id, nvl(a.nd, b.nd) as nd, 
                   nvl(a.branch, b.branch) as branch, -1 as rule_id,
                   nvl(a.ost, 0) - nvl(b.ost, 0) as t100 
            from (    
            select a.ekp, a.acc_id, a.acc_num, a.kv, a.maturity_date, a.cust_id, a.nd, a.branch, 
                abs(gl.p_icurval(a.kv, s.ost+s.dos-s.kos, l_prior_mnth_last_work_dt)) ost
            from snap_balances s, select_6kx a
            where s.acc = a.acc_id and
                s.fdat = l_date1 and
                s.ost+s.dos-s.kos > 0) a
            full outer join 
            (select a.ekp, a.acc_id, a.acc_num, a.kv, a.maturity_date, a.cust_id, a.nd, a.branch, 
                abs(gl.p_icurval(a.kv, s.ost+s.dos-s.kos, l_prior_mnth_last_work_dt)) ost
            from snap_balances s, select_6kx a
            where s.acc = a.acc_id and
                s.fdat = l_date2 and
                s.ost > 0) b 
            on (a.acc_id = b.acc_id) 
            where nvl(a.ost, 0) - nvl(b.ost, 0)>0
            )             
        ) a;         
        
      -- тип показників = 9 
      insert into NBUR_LOG_F6EX(REPORT_DATE, KF, VERSION_ID, NBUC, EKP, RULE_ID, R030, 
            T100, T100_PCT, DESCRIPTION, ACC_ID, ACC_NUM, KV, MATURITY_DATE, CUST_ID, ND, BRANCH)
      select p_report_date, p_kod_filii, l_version_id, p_kod_filii, 
            a.ekp, a.rule_id, a.kv as r030, a.t100, 0 as t100_pct, 
            'Type 9 (сума фактичних відпливів за вкладами з повідомленням про повернення)' as description, 
            a.acc_id, a.acc_num, a.kv, a.maturity_date, a.cust_id, a.nd, a.branch
      from (select *
            from (
            with select_6kx as
            (select e.ekp, k.acc_id, k.acc_num, k.maturity_date, k.kv, k.cust_id, k.nd, k.branch, sum(k.t100) as t100               
             from nbur_log_f6kx k, nbur_dct_f6ex_ekp e
              where k.report_date = l_prior_mnth_last_work_dt and 
                    k.kf = p_kod_filii and
                    k.ekp = e.aggr_ekp and
                    e.constant_value = 9 and 
                    e.aggr_ekp is not null
                group by e.ekp, k.acc_id, k.acc_num, k.maturity_date, k.kv, k.cust_id, k.nd, k.branch
            ) 
            select nvl(a.ekp, b.ekp) as ekp, nvl(a.acc_id, b.acc_id) as acc_id, nvl(a.acc_num, b.acc_num) as acc_num, nvl(a.kv, b.kv) as kv, 
                   nvl(a.maturity_date, b.maturity_date) as maturity_date, nvl(a.cust_id, b.cust_id) as cust_id, nvl(a.nd, b.nd) as nd, 
                   nvl(a.branch, b.branch) as branch, -1 as rule_id,
                   nvl(a.ost, 0) - nvl(b.ost, 0) as t100 
            from (    
            select a.ekp, a.acc_id, a.acc_num, a.kv, a.maturity_date, a.cust_id, a.nd, a.branch, 
                abs(gl.p_icurval(a.kv, s.ost+s.dos-s.kos, l_prior_mnth_last_work_dt)) ost
            from snap_balances s, select_6kx a
            where s.acc = a.acc_id and
                s.fdat = l_date1 and
                s.ost+s.dos-s.kos > 0) a
            full outer join 
            (select a.ekp, a.acc_id, a.acc_num, a.kv, a.maturity_date, a.cust_id, a.nd, a.branch, 
                abs(gl.p_icurval(a.kv, s.ost+s.dos-s.kos, l_prior_mnth_last_work_dt)) ost
            from snap_balances s, select_6kx a
            where s.acc = a.acc_id and
                s.fdat = l_date2 and
                s.ost > 0) b 
            on (a.acc_id = b.acc_id) 
            where nvl(a.ost, 0) - nvl(b.ost, 0)>0)             
        ) a;
        
       -- тип показників = 10 
      insert into NBUR_LOG_F6EX(REPORT_DATE, KF, VERSION_ID, NBUC, EKP, RULE_ID, R030, 
            T100, T100_PCT, DESCRIPTION, ACC_ID, ACC_NUM, KV, MATURITY_DATE, CUST_ID, ND, BRANCH)
      select p_report_date, p_kod_filii, l_version_id, p_kod_filii, 
            a.ekp, a.rule_id, a.kv as r030, a.t100, 0 as t100_pct, 
           'Type 10 (сума фактичних відпливів по вкладах (за винятком з повідомленням про повернення) та по інших залученнях)' as description, 
            a.acc_id, a.acc_num, a.kv, a.maturity_date, a.cust_id, a.nd, a.branch
      from (select *
            from (
            with select_6kx as
            (select e.ekp, k.acc_id, k.acc_num, k.maturity_date, k.kv, k.cust_id, k.nd, k.branch, sum(k.t100) as t100               
             from nbur_log_f6kx k, nbur_dct_f6ex_ekp e
              where k.report_date = l_prior_mnth_last_work_dt and 
                    k.kf = p_kod_filii and
                    k.ekp = e.aggr_ekp and
                    e.constant_value = 10 and 
                    e.aggr_ekp is not null
                group by e.ekp, k.acc_id, k.acc_num, k.maturity_date, k.kv, k.cust_id, k.nd, k.branch
            ) 
            select nvl(a.ekp, b.ekp) as ekp, nvl(a.acc_id, b.acc_id) as acc_id, nvl(a.acc_num, b.acc_num) as acc_num, nvl(a.kv, b.kv) as kv, 
                   nvl(a.maturity_date, b.maturity_date) as maturity_date, nvl(a.cust_id, b.cust_id) as cust_id, nvl(a.nd, b.nd) as nd, 
                   nvl(a.branch, b.branch) as branch, -1 as rule_id,
                   nvl(a.ost, 0) - nvl(b.ost, 0) as t100 
            from (    
            select a.ekp, a.acc_id, a.acc_num, a.kv, a.maturity_date, a.cust_id, a.nd, a.branch, 
                abs(gl.p_icurval(a.kv, s.ost+s.dos-s.kos, l_prior_mnth_last_work_dt)) ost
            from snap_balances s, select_6kx a
            where s.acc = a.acc_id and
                s.fdat = l_date1 and
                s.ost+s.dos-s.kos > 0) a
            full outer join 
            (select a.ekp, a.acc_id, a.acc_num, a.kv, a.maturity_date, a.cust_id, a.nd, a.branch, 
                abs(gl.p_icurval(a.kv, s.ost+s.dos-s.kos, l_prior_mnth_last_work_dt)) ost
            from snap_balances s, select_6kx a
            where s.acc = a.acc_id and
                s.fdat = l_date2 and
                s.ost > 0) b 
            on (a.acc_id = b.acc_id) 
            where nvl(a.ost, 0) - nvl(b.ost, 0)>0)             
        ) a;
        
       -- тип показників = 11 
      insert into NBUR_LOG_F6EX(REPORT_DATE, KF, VERSION_ID, NBUC, EKP, RULE_ID, R030, 
            T100, T100_PCT, DESCRIPTION, ACC_ID, ACC_NUM, KV, MATURITY_DATE, CUST_ID, ND, BRANCH)
      select p_report_date, p_kod_filii, l_version_id, p_kod_filii, 
            a.ekp, a.rule_id, a.kv as r030, a.t100, 0 as t100_pct, 
           'Type 11 (сума пролонгованих та повторно укладених договорів по вкладах)' as description, 
            a.acc_id, a.acc_num, a.kv, a.maturity_date, a.cust_id, a.nd, a.branch
      from (select *
            from (
            with select_6kx as
            (select e.ekp, k.acc_id, k.acc_num, k.maturity_date, k.kv, k.cust_id, k.nd, k.branch, sum(k.t100) as t100               
             from nbur_log_f6kx k, nbur_dct_f6ex_ekp e
              where k.report_date = l_prior_mnth_last_work_dt and 
                    k.kf = p_kod_filii and
                    k.ekp = e.aggr_ekp and
                    e.constant_value = 11 and 
                    e.aggr_ekp is not null
                group by e.ekp, k.acc_id, k.acc_num, k.maturity_date, k.kv, k.cust_id, k.nd, k.branch
            ) 
            select nvl(a.ekp, b.ekp) as ekp, nvl(a.acc_id, b.acc_id) as acc_id, nvl(a.acc_num, b.acc_num) as acc_num, nvl(a.kv, b.kv) as kv, 
                   nvl(a.maturity_date, b.maturity_date) as maturity_date, nvl(a.cust_id, b.cust_id) as cust_id, nvl(a.nd, b.nd) as nd, 
                   nvl(a.branch, b.branch) as branch, -1 as rule_id,
                   nvl(a.ost, 0) - nvl(b.ost, 0) as t100_old, 
                   gl.p_icurval(a.kv, (select sum(s) from opldok o where o.acc = a.acc_id and o.dk = 1 and fdat between l_date1 and l_date2), l_prior_mnth_last_work_dt) t100 
            from (    
            select a.ekp, a.acc_id, a.acc_num, a.kv, a.maturity_date, a.cust_id, a.nd, a.branch, 
                abs(gl.p_icurval(a.kv, s.ost+s.dos-s.kos, l_prior_mnth_last_work_dt)) ost
            from snap_balances s, select_6kx a
            where s.acc = a.acc_id and
                s.fdat = l_date1 and
                s.ost+s.dos-s.kos > 0) a
            join 
            (select a.ekp, a.acc_id, a.acc_num, a.kv, a.maturity_date, a.cust_id, a.nd, a.branch, 
                abs(gl.p_icurval(a.kv, s.ost+s.dos-s.kos, l_prior_mnth_last_work_dt)) ost
            from snap_balances s, select_6kx a
            where s.acc = a.acc_id and
                s.fdat = l_date2 and
                s.ost > 0) b 
            on (a.acc_id = b.acc_id) 
            where nvl(a.ost, 0) - nvl(b.ost, 0)>0)             
        ) a
        where a.t100 <> 0;

       -- тип показників = 12
      insert into NBUR_LOG_F6EX(REPORT_DATE, KF, VERSION_ID, NBUC, EKP, RULE_ID, R030, 
            T100, T100_PCT, DESCRIPTION, ACC_ID, ACC_NUM, KV, MATURITY_DATE, CUST_ID, ND, BRANCH)
      select p_report_date, p_kod_filii, l_version_id, p_kod_filii, 
            a.ekp, a.rule_id, a.kv as r030, a.t100, 0 as t100_pct, 
           'Type 12 (Сума за новими договорами за вкладами та іншими залученнями)' as description, 
            a.acc_id, a.acc_num, a.kv, a.maturity_date, a.cust_id, a.nd, a.branch
      from (
        select a.*,
            gl.p_icurval(a.kv, (select sum(s) from opldok o where o.acc = a.acc_id and o.dk = 1 and fdat between l_date1 and l_date2), l_prior_mnth_last_work_dt) t100 
        from (
            select e.ekp, a.acc as acc_id, a.nls as acc_num, a.kv, a.mdate as maturity_date, a.rnk as cust_id, null as nd, a.branch, 
                abs(gl.p_icurval(a.kv, b.ost, l_prior_mnth_last_work_dt)) ost, n.rule_id
            from snap_balances b, accounts a, specparam s, nbur_dct_f6ex_ekp e, nbur_dct_f6ex_nbs n
            where b.fdat = l_date2 and 
                b.kf = p_kod_filii and
                b.acc = a.acc and
                b.acc = s.acc(+) and
                e.constant_value = 12 and 
                e.ekp = n.ekp and
                a.nls like n.r020||'%' and
                (case when b.ost<0 then '1' when b.ost>0 then '2' else '0' end) = n.t020 and
                (trim(s.r013) = trim(n.r013) or trim(n.r013) is null) and
                (trim(s.r011) = trim(n.r011) or trim(n.r011) is null) and
                a.daos > l_prior_mnth_last_work_dt and
                b.acc not in (select acc_id from nbur_log_f6kx k where k.report_date = l_prior_mnth_last_work_dt and k.kf = p_kod_filii)) a) a
      where t100 <> 0;
      
       -- тип показників = 13
      insert into NBUR_LOG_F6EX(REPORT_DATE, KF, VERSION_ID, NBUC, EKP, RULE_ID, R030, 
            T100, T100_PCT, DESCRIPTION, ACC_ID, ACC_NUM, KV, MATURITY_DATE, CUST_ID, ND, BRANCH)
      select p_report_date, p_kod_filii, l_version_id, p_kod_filii, 
            a.ekp, a.rule_id, a.kv as r030, a.t100, 0 as t100_pct, 
           'Type 13 (Сума зобов''язань банку за попередній звітний період)' as description, 
            a.acc_id, a.acc_num, a.kv, a.maturity_date, a.cust_id, a.nd, a.branch
      from (
        select a.*
        from (
            select e.ekp, a.acc as acc_id, a.nls as acc_num, a.kv, a.mdate as maturity_date, 
                a.rnk as cust_id, null as nd, a.branch, n.rule_id, 
                abs(gl.p_icurval(a.kv, b.ost, l_prior_mnth_last_work_dt)) t100,
                (case when instr(s.nkd, 'БПК')>0 or instr(s.nkd, 'БПК')=0 then 1 else 0 end) kred_l1,
                (select count(*) from nd_acc n, cc_deal c where n.acc = b.acc and n.nd = c.nd and vidd in ( 2, 3, 12, 13, 9, 19, 29, 39)) kred_l2,  
                n.credit_work_flg
            from snap_balances b, accounts a, specparam s, customer c, nbur_dct_f6ex_ekp e, nbur_dct_f6ex_nbs n
            where b.fdat = l_prior_mnth_last_work_dt and 
                b.kf = p_kod_filii and
                b.acc = a.acc and
                b.acc = s.acc and
                b.rnk = c.rnk and
                e.constant_value = 13 and 
                e.ekp = n.ekp and
                a.nls like n.r020||'%' and
                (case when b.ost<0 then '1' when b.ost>0 then '2' else '0' end) = n.t020 and
                (trim(s.r013) = trim(n.r013) or trim(n.r013) is null) and
                (trim(s.r011) = trim(n.r011) or trim(n.r011) is null) and
                (trim(c.custtype) = trim(n.cust_type) or trim(n.cust_type) is null) 
         ) a 
         where a.credit_work_flg is null or
               a.credit_work_flg = (case when kred_l1 <> 0 or kred_l2 <> 0 then '1' else '0' end)
      ) a;      

       -- тип показників = 14 
      insert into NBUR_LOG_F6EX(REPORT_DATE, KF, VERSION_ID, NBUC, EKP, RULE_ID, R030, 
            T100, T100_PCT, DESCRIPTION, ACC_ID, ACC_NUM, KV, MATURITY_DATE, CUST_ID, ND, BRANCH)
      select p_report_date, p_kod_filii, l_version_id, p_kod_filii, 
            a.ekp, a.rule_id, a.kv as r030, a.t100, 0 as t100_pct, 
           'Type 14 (сума пролонгованих та повторно укладених договорів по вкладах)' as description, 
            a.acc_id, a.acc_num, a.kv, a.maturity_date, a.cust_id, a.nd, a.branch
      from (select *
            from (
            with select_6kx as
            (select e.ekp, k.acc_id, k.acc_num, k.maturity_date, k.kv, k.cust_id, k.nd, k.branch, sum(k.t100) as t100               
             from nbur_log_f6kx k, nbur_dct_f6ex_ekp e
              where k.report_date = l_prior_mnth_last_work_dt and 
                    k.kf = p_kod_filii and
                    k.ekp = e.aggr_ekp and
                    e.constant_value = 14 and 
                    e.aggr_ekp is not null
                group by e.ekp, k.acc_id, k.acc_num, k.maturity_date, k.kv, k.cust_id, k.nd, k.branch
            ) 
            select nvl(a.ekp, b.ekp) as ekp, nvl(a.acc_id, b.acc_id) as acc_id, nvl(a.acc_num, b.acc_num) as acc_num, nvl(a.kv, b.kv) as kv, 
                   nvl(a.maturity_date, b.maturity_date) as maturity_date, nvl(a.cust_id, b.cust_id) as cust_id, nvl(a.nd, b.nd) as nd, 
                   nvl(a.branch, b.branch) as branch, -1 as rule_id,
                   nvl(a.ost, 0) - nvl(b.ost, 0) as t100
            from (    
            select a.ekp, a.acc_id, a.acc_num, a.kv, a.maturity_date, a.cust_id, a.nd, a.branch, 
                abs(gl.p_icurval(a.kv, s.ost+s.dos-s.kos, l_prior_mnth_last_work_dt)) ost
            from snap_balances s, select_6kx a
            where s.acc = a.acc_id and
                s.fdat = l_date1 and
                s.ost+s.dos-s.kos > 0) a
            join 
            (select a.ekp, a.acc_id, a.acc_num, a.kv, a.maturity_date, a.cust_id, a.nd, a.branch, 
                abs(gl.p_icurval(a.kv, s.ost+s.dos-s.kos, l_prior_mnth_last_work_dt)) ost
            from snap_balances s, select_6kx a
            where s.acc = a.acc_id and
                s.fdat = l_date2 and
                s.ost > 0) b 
            on (a.acc_id = b.acc_id) 
            where nvl(a.ost, 0) - nvl(b.ost, 0)>0)             
        ) a
        where a.t100 <> 0;
                                   
      logger.trace(c_title || ' Файл сформовано! ');
  else
      logger.info(c_title || ' Дата ' || to_char(p_report_date, c_date_fmt) || ' не є останнім рабочим днем місяця! Формування звіту неможливо!');
  end if;

  logger.info (c_title || ' end for date = '||to_char(p_report_date, 'dd.mm.yyyy'));
END NBUR_P_F6EX;
/