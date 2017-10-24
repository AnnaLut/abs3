PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Procedure/RPT_BRANCH_CUSTOMER_SEGMENT.sql ==
PROMPT ===================================================================================== 


PROMPT *** Create  procedure RPT_BRANCH_CUSTOMER_SEGMENT ***

  CREATE OR REPLACE PROCEDURE BARS.RPT_BRANCH_CUSTOMER_SEGMENT (
    p_branch in varchar2,
    p_activity_segment_id in varchar2,
    p_financial_segment_id in varchar2,
    p_behavior_segment_id in varchar2,
    p_social_vip_segment_id in varchar2)
is
--  version 2.1  01.10.2017;
    l_branch varchar2(30 char) default p_branch;

    l_activity_segment_id integer;
    l_financial_segment_id integer;
    l_behavior_segment_id integer;
    l_social_vip_segment_id integer;

    l_activity_segment_attr_id integer;
    l_financial_segment_attr_id integer;
    l_behavior_segment_attr_id integer;
    l_transactor_subseg_attr_id integer;
    l_general_prod_press_attr_id integer;
    l_deposit_attr_id integer;
    l_secured_loans_attr_id integer;
    l_card_loans_attr_id integer;
    l_cardless_loans_attr_id integer;
    l_energy_loans_attr_id integer;
    l_debit_cards_attr_id integer;
    l_current_accounts_attr_id integer;
begin
--    dbms_profiler.start_profiler('rpt_branch_customer_segment    ' || to_char(sysdate, 'yyyy-mm-dd hh24:mi'));

    bars_audit.trace('bars.rpt_customer_segment' || chr(10) ||
                     'p_branch                : ' || p_branch                || chr(10) ||
                     'p_activity_segment_id   : ' || p_activity_segment_id   || chr(10) ||
                     'p_financial_segment_id  : ' || p_financial_segment_id  || chr(10) ||
                     'p_behavior_segment_id   : ' || p_behavior_segment_id   || chr(10) ||
                     'p_social_vip_segment_id : ' || p_social_vip_segment_id);

    lock table tmp_customer_segment_report in exclusive mode;
    delete tmp_customer_segment_report;

    l_activity_segment_id := case when p_activity_segment_id = '%' then null else to_number(p_activity_segment_id) end;
    l_financial_segment_id := case when p_financial_segment_id = '%' then null else to_number(p_financial_segment_id) end;
    l_behavior_segment_id := case when p_behavior_segment_id = '%' then null else to_number(p_behavior_segment_id) end;
    l_social_vip_segment_id := case when p_social_vip_segment_id = '%' then null else to_number(p_social_vip_segment_id) end;

    if (l_branch is null or l_branch = '/') then
        select '/' || p.val || '/'
        into   l_branch
        from   params$base p
        where  p.par = 'MFO';
    end if;

    insert into tmp_customer_segment_report (record_level, branch, activity_segment, financial_segment, behavior_segment, social_vip_segment)
    select 1,
           b.branch,
           li.list_item_id,
           l_financial_segment_id,
           l_behavior_segment_id,
           l_social_vip_segment_id
    from   branch b
    join   list_type lt on lt.list_code = 'CUSTOMER_SEGMENT_ACTIVITY'
    join   list_item li on li.list_type_id = lt.id and
                           (l_activity_segment_id is null or li.list_item_id = l_activity_segment_id)
    where  b.branch = l_branch
    union
    select 0,
           b.branch,
           l_activity_segment_id,
           l_financial_segment_id,
           l_behavior_segment_id,
           l_social_vip_segment_id
    from   branch b
    where  b.branch = l_branch and
           l_activity_segment_id is null;

/*
    l_activity_segment_attr_id   := attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_ACTIVITY');
    l_financial_segment_attr_id  := attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_FINANCIAL');
    l_behavior_segment_attr_id   := attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_BEHAVIOR');
    l_transactor_subseg_attr_id  := attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_TRANSACTIONS');
    l_general_prod_press_attr_id := attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_PRODUCTS_AMNT');
    l_deposit_attr_id            := attribute_utl.get_attribute_id('CUSTOMER_PRDCT_AMNT_DPT');
    l_secured_loans_attr_id      := attribute_utl.get_attribute_id('CUSTOMER_PRDCT_AMNT_CREDITS');
    l_card_loans_attr_id         := attribute_utl.get_attribute_id('CUSTOMER_PRDCT_AMNT_CRDCARDS');
    l_cardless_loans_attr_id     := attribute_utl.get_attribute_id('CUSTOMER_PRDCT_AMNT_CRD_GARANT');
    l_energy_loans_attr_id       := attribute_utl.get_attribute_id('CUSTOMER_PRDCT_AMNT_CRDENERGY');
    l_debit_cards_attr_id        := attribute_utl.get_attribute_id('CUSTOMER_PRDCT_AMNT_CARDS');
    l_current_accounts_attr_id   := attribute_utl.get_attribute_id('CUSTOMER_PRDCT_AMNT_ACC');

    insert into tmp_customer_segment_report
        (record_level, branch, client_name, activity_segment,
         transactor_subsegment, general_prod_pressure, deposit_factor, secured_loans_factor,
         card_loans_factor, cardless_loans_factor, energy_loans_factor, debit_cards_factor,
         current_accounts_factor, financial_segment, behavior_segment, social_vip_segment)
    select 100,
           c.branch,
           c.nmk || ' (' || c.rnk || ')',
           a1.number_value activity_segment,
           a10.number_value transactor_subsegment,
           a2.number_value general_prod_pressure,
           a3.number_value deposit_factor,
           a4.number_value secured_loans_factor,
           a5.number_value card_loans_factor,
           a6.number_value cardless_loans_factor,
           a7.number_value energy_loans_factor,
           a8.number_value debit_cards_factor,
           a9.number_value current_accounts_factor,
           a11.number_value financial_segment,
           a12.number_value behavior_segment,
           v.kvip social_vip_segment
    from    customer c
    join    attribute_value a1 on a1.object_id = c.rnk and
                                         a1.attribute_id = l_activity_segment_attr_id and
                                         (l_activity_segment_id is null or a1.number_value = l_activity_segment_id)
    left join attribute_value a2 on a2.object_id = c.rnk and a2.attribute_id = l_general_prod_press_attr_id
    left join attribute_value a3 on a3.object_id = c.rnk and a3.attribute_id = l_deposit_attr_id
    left join attribute_value a4 on a4.object_id = c.rnk and a4.attribute_id = l_secured_loans_attr_id
    left join attribute_value a5 on a5.object_id = c.rnk and a5.attribute_id = l_card_loans_attr_id
    left join attribute_value a6 on a6.object_id = c.rnk and a6.attribute_id = l_cardless_loans_attr_id
    left join attribute_value a7 on a7.object_id = c.rnk and a7.attribute_id = l_energy_loans_attr_id
    left join attribute_value a8 on a8.object_id = c.rnk and a8.attribute_id = l_debit_cards_attr_id
    left join attribute_value a9 on a9.object_id = c.rnk and a9.attribute_id = l_current_accounts_attr_id
    left join attribute_value a10 on a10.object_id = c.rnk and a10.attribute_id = l_transactor_subseg_attr_id
    left join attribute_value a11 on a11.object_id = c.rnk and a11.attribute_id = l_financial_segment_attr_id
    left join attribute_value a12 on a12.object_id = c.rnk and a12.attribute_id = l_behavior_segment_attr_id
    left join vip_flags v on v.rnk = c.rnk
    where c.custtype = 3 and
          c.date_off is null and
          c.branch = l_branch and
          (l_financial_segment_id is null or a11.number_value = l_financial_segment_id) and
          (l_behavior_segment_id is null or a12.number_value = l_behavior_segment_id) and
          (l_social_vip_segment_id is null or v.kvip = l_social_vip_segment_id);

*/


    insert into tmp_customer_segment_report
        (record_level, branch, client_name, activity_segment,
         transactor_subsegment, general_prod_pressure, deposit_factor, secured_loans_factor,
         card_loans_factor, cardless_loans_factor, energy_loans_factor, debit_cards_factor,
         current_accounts_factor, financial_segment, behavior_segment, social_vip_segment)

with const as
 (select /*+  materialize */
   dummy,
   attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_ACTIVITY') as CUSTOMER_SEGMENT_ACTIVITY,
   attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_FINANCIAL') as CUSTOMER_SEGMENT_FINANCIAL,
   attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_BEHAVIOR') as CUSTOMER_SEGMENT_BEHAVIOR,
   attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_TRANSACTIONS') as CUSTOMER_SEGMENT_TRANSACTIONS,
   attribute_utl.get_attribute_id('CUSTOMER_SEGMENT_PRODUCTS_AMNT') as CUSTOMER_SEGMENT_PRODUCTS_AMNT,
   attribute_utl.get_attribute_id('CUSTOMER_PRDCT_AMNT_DPT') as CUSTOMER_PRDCT_AMNT_DPT,
   attribute_utl.get_attribute_id('CUSTOMER_PRDCT_AMNT_CREDITS') as CUSTOMER_PRDCT_AMNT_CREDITS,
   attribute_utl.get_attribute_id('CUSTOMER_PRDCT_AMNT_CRDCARDS') as CUSTOMER_PRDCT_AMNT_CRDCARDS,
   attribute_utl.get_attribute_id('CUSTOMER_PRDCT_AMNT_CRD_GARANT') as CUSTOMER_PRDCT_AMNT_CRD_GARANT,
   attribute_utl.get_attribute_id('CUSTOMER_PRDCT_AMNT_CRDENERGY') as CUSTOMER_PRDCT_AMNT_CRDENERGY,
   attribute_utl.get_attribute_id('CUSTOMER_PRDCT_AMNT_CARDS') as CUSTOMER_PRDCT_AMNT_CARDS,
   attribute_utl.get_attribute_id('CUSTOMER_PRDCT_AMNT_ACC') as CUSTOMER_PRDCT_AMNT_ACC,
   bankdate() as bankdate    from dual)

select /*+  parallel(6) */ record_level, branch, client_name, activity_segment,
         transactor_subsegment, general_prod_pressure, deposit_factor, secured_loans_factor,
         card_loans_factor, cardless_loans_factor, energy_loans_factor, debit_cards_factor,
         current_accounts_factor, financial_segment, behavior_segment, social_vip_segment
  from (select c.rnk,
               c.branch,
               c.nmk, vf.kvip,
               av.attribute_id,
               av.number_value,
               av.value_date,
               max(av.value_date) over(partition by av.object_id, av.attribute_id) as max_value_date
          from customer c
         inner join const
            on c.rnk in (select object_id
                           from bars.attribute_value_by_date av_act
                          where c.rnk = av_act.object_id
                            and av_act.value_date <= const.bankdate
                            and attribute_id = const.CUSTOMER_SEGMENT_ACTIVITY
                            and number_value = nvl(l_activity_segment_id, number_value))
              left outer join (select attribute_id, object_id, number_value, value_date
                                from bars.attribute_value_by_date
                                join const on value_date <= const.bankdate
                                 and (attribute_id in
                                     (const.CUSTOMER_SEGMENT_ACTIVITY,
                                      const.CUSTOMER_SEGMENT_TRANSACTIONS,
                                      const.CUSTOMER_SEGMENT_PRODUCTS_AMNT)
                                      or (attribute_id = const.CUSTOMER_SEGMENT_FINANCIAL and number_value = nvl(l_financial_segment_id, number_value))
                                      or (attribute_id = const.CUSTOMER_SEGMENT_BEHAVIOR and number_value = nvl(l_behavior_segment_id, number_value)))
                              union all
                              select attribute_id, object_id, number_value, sysdate
                                from bars.attribute_value join const
                                  on attribute_id in (const.CUSTOMER_PRDCT_AMNT_DPT,
                                                      const.CUSTOMER_PRDCT_AMNT_CREDITS,
                                                      const.CUSTOMER_PRDCT_AMNT_CRDCARDS,
                                                      const.CUSTOMER_PRDCT_AMNT_CRD_GARANT,
                                                      const.CUSTOMER_PRDCT_AMNT_CRDENERGY,
                                                      const.CUSTOMER_PRDCT_AMNT_CARDS,
                                                      const.CUSTOMER_PRDCT_AMNT_ACC)) av
                on c.rnk = av.object_id
          left join vip_flags vf on vf.rnk = c.rnk and vf.kvip = nvl(l_social_vip_segment_id, vf.kvip)                           
         where 1 = 1
           and c.custtype = 3
           and c.date_off is null
--           and c.rnk = 37737011
           and c.branch = l_branch
        )
 where value_date = max_value_date

model
      -->cell_reference_options (optional)
      keep nav 
--      ignore nav

      unique dimension -- unique single reference         
      -->return_rows_clause (optional)
      return updated rows         
--      return all rows         

      -->reference_model (optional)
      reference const on ( select * from const )
      dimension by(dummy) measures(CUSTOMER_SEGMENT_ACTIVITY,
                                   CUSTOMER_SEGMENT_FINANCIAL,
                                   CUSTOMER_SEGMENT_BEHAVIOR,
                                   CUSTOMER_SEGMENT_TRANSACTIONS,
                                   CUSTOMER_SEGMENT_PRODUCTS_AMNT,
                                   CUSTOMER_PRDCT_AMNT_DPT,
                                   CUSTOMER_PRDCT_AMNT_CREDITS,
                                   CUSTOMER_PRDCT_AMNT_CRDCARDS,
                                   CUSTOMER_PRDCT_AMNT_CRD_GARANT,
                                   CUSTOMER_PRDCT_AMNT_CRDENERGY,
                                   CUSTOMER_PRDCT_AMNT_CARDS,
                                   CUSTOMER_PRDCT_AMNT_ACC)

      -->main_model
      main model_1
-->model_column_clauses
 partition by (rnk)
dimension by(attribute_id) measures( 100 as record_level, branch, nmk || ' (' || rnk || ')' as client_name, value_date, number_value,
  0 as activity_segment, 0 as financial_segment, 0 as behavior_segment, 0 as transactor_subsegment, 0 as general_prod_pressure
  , 0 as deposit_factor, 0 as secured_loans_factor, 0 as card_loans_factor, 0 as cardless_loans_factor, 0 as energy_loans_factor, 0 as debit_cards_factor
  , 0 as current_accounts_factor, kvip as social_vip_segment)
      -->cell_reference_options (optional)
-->model_rules_clause
rules
automatic order
(
  activity_segment [const.CUSTOMER_SEGMENT_ACTIVITY['X']] = number_value[cv(attribute_id)],
  financial_segment[const.CUSTOMER_SEGMENT_ACTIVITY['X']] = number_value[ const.CUSTOMER_SEGMENT_FINANCIAL['X']],
  behavior_segment[const.CUSTOMER_SEGMENT_ACTIVITY['X']] = number_value[ const.CUSTOMER_SEGMENT_BEHAVIOR['X']],
  transactor_subsegment[const.CUSTOMER_SEGMENT_ACTIVITY['X']] = number_value[ const.CUSTOMER_SEGMENT_TRANSACTIONS['X']],
  general_prod_pressure[const.CUSTOMER_SEGMENT_ACTIVITY['X']] = number_value[ const.CUSTOMER_SEGMENT_PRODUCTS_AMNT['X']],
  deposit_factor[const.CUSTOMER_SEGMENT_ACTIVITY['X']] = number_value[ const.CUSTOMER_PRDCT_AMNT_DPT['X']],
  secured_loans_factor[const.CUSTOMER_SEGMENT_ACTIVITY['X']] = number_value[ const.CUSTOMER_PRDCT_AMNT_CREDITS['X']],
  card_loans_factor[ const.CUSTOMER_SEGMENT_ACTIVITY['X']] = number_value[ const.CUSTOMER_PRDCT_AMNT_CRDCARDS['X']],
  cardless_loans_factor[ const.CUSTOMER_SEGMENT_ACTIVITY['X']] = number_value[ const.CUSTOMER_PRDCT_AMNT_CRD_GARANT['X']],
  energy_loans_factor[ const.CUSTOMER_SEGMENT_ACTIVITY['X']] = number_value[ const.CUSTOMER_PRDCT_AMNT_CRDENERGY['X']],
  debit_cards_factor[ const.CUSTOMER_SEGMENT_ACTIVITY['X']] = number_value[ const.CUSTOMER_PRDCT_AMNT_CARDS['X']],
  current_accounts_factor[ const.CUSTOMER_SEGMENT_ACTIVITY['X']] = number_value[ const.CUSTOMER_PRDCT_AMNT_ACC['X']]
) ;







    update tmp_customer_segment_report t
    set    (t.clients_count,
            t.general_prod_pressure,
            t.deposit_factor,
            t.secured_loans_factor,
            t.card_loans_factor,
            t.cardless_loans_factor,
            t.energy_loans_factor,
            t.debit_cards_factor,
            t.current_accounts_factor,
            t.transactor_subsegment) = (select count(*),
                                               sum(t2.general_prod_pressure) / count(*),
                                               sum(t2.deposit_factor),
                                               sum(t2.secured_loans_factor),
                                               sum(t2.card_loans_factor),
                                               sum(t2.cardless_loans_factor),
                                               sum(t2.energy_loans_factor),
                                               sum(t2.debit_cards_factor),
                                               sum(t2.current_accounts_factor),
                                               sum(t2.transactor_subsegment)
                                        from   tmp_customer_segment_report t2
                                        where  (t.record_level = 0 or (t.record_level = 1 and t2.activity_segment = t.activity_segment)) and
                                               t2.record_level = 100)
    where  t.clients_count is null and
           t.record_level in (0, 1);
--           commit work;
--           dbms_profiler.stop_profiler;
exception
    when others then
         rollback;
         bars_audit.error('bars.rpt_customer_segment' || chr(10) ||
                          sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
         raise;
end rpt_branch_customer_segment;
/
show errors

PROMPT *** Create  grants  RPT_BRANCH_CUSTOMER_SEGMENT ***
grant EXECUTE on RPT_BRANCH_CUSTOMER_SEGMENT to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/RPT_BRANCH_CUSTOMER_SEGMENT.sql ==
PROMPT ===================================================================================== 
