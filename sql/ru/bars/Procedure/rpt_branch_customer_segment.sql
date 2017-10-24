

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
    bars_audit.trace('bars.rpt_customer_segment' || chr(10) ||
                     'p_branch                : ' || p_branch                || chr(10) ||
                     'p_activity_segment_id   : ' || p_activity_segment_id   || chr(10) ||
                     'p_financial_segment_id  : ' || p_financial_segment_id  || chr(10) ||
                     'p_behavior_segment_id   : ' || p_behavior_segment_id   || chr(10) ||
                     'p_social_vip_segment_id : ' || p_social_vip_segment_id);

    lock table tmp_customer_segment_report in exclusive mode;
    delete tmp_customer_segment_report;

    l_activity_segment_id := case when p_activity_segment_id = '%' then null else attribute_utl.get_attribute_id(p_activity_segment_id) end;
    l_financial_segment_id := case when p_financial_segment_id = '%' then null else attribute_utl.get_attribute_id(p_financial_segment_id) end;
    l_behavior_segment_id := case when p_behavior_segment_id = '%' then null else attribute_utl.get_attribute_id(p_behavior_segment_id) end;
    l_social_vip_segment_id := case when p_social_vip_segment_id = '%' then null else attribute_utl.get_attribute_id(p_social_vip_segment_id) end;

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
           a1.value activity_segment,
           a10.value transactor_subsegment,
           a2.value general_prod_pressure,
           a3.value deposit_factor,
           a4.value secured_loans_factor,
           a5.value card_loans_factor,
           a6.value cardless_loans_factor,
           a7.value energy_loans_factor,
           a8.value debit_cards_factor,
           a9.value current_accounts_factor,
           a11.value financial_segment,
           a12.value behavior_segment,
           v.kvip social_vip_segment
    from    customer c
    join    attribute_number_value a1 on a1.object_id = c.rnk and
                                         a1.attribute_id = l_activity_segment_attr_id and
                                         (l_activity_segment_id is null or a1.value = l_activity_segment_id)
    left join attribute_number_value a2 on a2.object_id = c.rnk and a2.attribute_id = l_general_prod_press_attr_id
    left join attribute_number_value a3 on a3.object_id = c.rnk and a3.attribute_id = l_deposit_attr_id
    left join attribute_number_value a4 on a4.object_id = c.rnk and a4.attribute_id = l_secured_loans_attr_id
    left join attribute_number_value a5 on a5.object_id = c.rnk and a5.attribute_id = l_card_loans_attr_id
    left join attribute_number_value a6 on a6.object_id = c.rnk and a6.attribute_id = l_cardless_loans_attr_id
    left join attribute_number_value a7 on a7.object_id = c.rnk and a7.attribute_id = l_energy_loans_attr_id
    left join attribute_number_value a8 on a8.object_id = c.rnk and a8.attribute_id = l_debit_cards_attr_id
    left join attribute_number_value a9 on a9.object_id = c.rnk and a9.attribute_id = l_current_accounts_attr_id
    left join attribute_number_value a10 on a10.object_id = c.rnk and a10.attribute_id = l_transactor_subseg_attr_id
    left join attribute_number_value a11 on a11.object_id = c.rnk and a11.attribute_id = l_financial_segment_attr_id
    left join attribute_number_value a12 on a12.object_id = c.rnk and a12.attribute_id = l_behavior_segment_attr_id
    left join vip_flags v on v.rnk = c.rnk
    where c.custtype = 3 and
          c.date_off is null and
          c.branch = l_branch and
          (l_financial_segment_id is null or a11.value = l_financial_segment_id) and
          (l_behavior_segment_id is null or a12.value = l_behavior_segment_id) and
          (l_social_vip_segment_id is null or v.kvip = l_social_vip_segment_id);

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
exception
    when others then
         rollback;
         bars_audit.error('bars.rpt_customer_segment' || chr(10) ||
                          sqlerrm || chr(10) || dbms_utility.format_error_backtrace());
         raise;
end;
/
show err;

PROMPT *** Create  grants  RPT_BRANCH_CUSTOMER_SEGMENT ***
grant EXECUTE                                                                on RPT_BRANCH_CUSTOMER_SEGMENT to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/RPT_BRANCH_CUSTOMER_SEGMENT.sql ==
PROMPT ===================================================================================== 
