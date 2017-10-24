
PROMPT *** Create  procedure RPT_CUSTOMER_SEGMENT ***

create or replace procedure rpt_customer_segment(
    p_branch in varchar2,
    p_activity_segment_id in varchar2,
    p_financial_segment_id in varchar2,
    p_behavior_segment_id in varchar2,
    p_social_vip_segment_id in varchar2)
is
    l_branch varchar2(30 char) default p_branch;
    l_report_branch_level integer;

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

    -- pragma autonomous_transaction;
begin
    bars_audit.trace('bars.rpt_customer_segment' || chr(10) ||
                     'p_branch                : ' || p_branch                || chr(10) ||
                     'p_activity_segment_id   : ' || p_activity_segment_id   || chr(10) ||
                     'p_financial_segment_id  : ' || p_financial_segment_id  || chr(10) ||
                     'p_behavior_segment_id   : ' || p_behavior_segment_id   || chr(10) ||
                     'p_social_vip_segment_id : ' || p_social_vip_segment_id);

    lock table tmp_customer_segment_report in exclusive mode;
    delete tmp_customer_segment_report;
    -- execute immediate 'truncate table tmp_customer_segment_report';

    l_activity_segment_id := case when p_activity_segment_id = '%' then null else attribute_utl.get_attribute_id(p_activity_segment_id) end;
    l_financial_segment_id := case when p_financial_segment_id = '%' then null else attribute_utl.get_attribute_id(p_financial_segment_id) end;
    l_behavior_segment_id := case when p_behavior_segment_id = '%' then null else attribute_utl.get_attribute_id(p_behavior_segment_id) end;
    l_social_vip_segment_id := case when p_social_vip_segment_id = '%' then null else attribute_utl.get_attribute_id(p_social_vip_segment_id) end;

    if (l_branch is null or l_branch = '%' or l_branch = '/') then
        select '/' || p.val || '/'
        into   l_branch
        from   params$base p
        where  p.par = 'MFO';
    end if;

    l_report_branch_level := nvl(length(regexp_replace(l_branch, '[^/]')) - 1, 0);

    insert into tmp_customer_segment_report (branch, activity_segment, financial_segment, behavior_segment, social_vip_segment)
    select b.branch,
           li.list_item_id,
           l_financial_segment_id,
           l_behavior_segment_id,
           l_social_vip_segment_id
    from   branch b
    join   list_type lt on lt.list_code = 'CUSTOMER_SEGMENT_ACTIVITY'
    join   list_item li on li.list_type_id = lt.id and
                           (l_activity_segment_id is null or li.list_item_id = l_activity_segment_id)
    where  b.branch like l_branch || '%'
    union
    select b.branch,
           l_activity_segment_id,
           l_financial_segment_id,
           l_behavior_segment_id,
           l_social_vip_segment_id
    from   branch b
    where  b.branch like l_branch || '%' and
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

    merge into tmp_customer_segment_report a
    using (select t.branch,
                  t.activity_segment,
                  count(t.activity_segment) clients_count,
                  sum(t.general_prod_pressure) general_prod_pressure,
                  sum(t.deposit_factor) deposit_factor,
                  sum(t.secured_loans_factor) secured_loans_factor,
                  sum(t.card_loans_factor) card_loans_factor,
                  sum(t.cardless_loans_factor) cardless_loans_factor,
                  sum(t.energy_loans_factor) energy_loans_factor,
                  sum(t.debit_cards_factor) debit_cards_factor,
                  sum(t.current_accounts_factor) current_accounts_factor,
                  sum(t.transactor_subsegment) transactor_subsegment
           from   (select  c.rnk,
                           c.branch,
                           a1.number_value activity_segment,
                           a2.number_value general_prod_pressure,
                           a3.number_value deposit_factor,
                           a4.number_value secured_loans_factor,
                           a5.number_value card_loans_factor,
                           a6.number_value cardless_loans_factor,
                           a7.number_value energy_loans_factor,
                           a8.number_value debit_cards_factor,
                           a9.number_value current_accounts_factor,
                           a10.number_value transactor_subsegment
                   from    customer c
                   join    (select object_id, attribute_id, max(t.number_value) keep (dense_rank last order by t.value_date) number_value
                            from ATTRIBUTE_VALUE_BY_DATE t group by object_id, attribute_id) 
                                                    a1 on a1.object_id = c.rnk and
                                                        a1.attribute_id = l_activity_segment_attr_id and
                                                        (l_activity_segment_id is null or a1.number_value = l_activity_segment_id)
                   left join (select object_id, attribute_id, max(t.number_value) keep (dense_rank last order by t.value_date) number_value
                            from ATTRIBUTE_VALUE_BY_DATE t group by object_id, attribute_id) a2 on a2.object_id = c.rnk and a2.attribute_id = l_general_prod_press_attr_id
                   left join (select object_id, attribute_id, max(t.number_value) keep (dense_rank last order by t.value_date) number_value
                            from ATTRIBUTE_VALUE_BY_DATE t group by object_id, attribute_id) a3 on a3.object_id = c.rnk and a3.attribute_id = l_deposit_attr_id
                   left join (select object_id, attribute_id, max(t.number_value) keep (dense_rank last order by t.value_date) number_value
                            from ATTRIBUTE_VALUE_BY_DATE t group by object_id, attribute_id) a4 on a4.object_id = c.rnk and a4.attribute_id = l_secured_loans_attr_id
                   left join (select object_id, attribute_id, max(t.number_value) keep (dense_rank last order by t.value_date) number_value
                            from ATTRIBUTE_VALUE_BY_DATE t group by object_id, attribute_id) a5 on a5.object_id = c.rnk and a5.attribute_id = l_card_loans_attr_id
                   left join (select object_id, attribute_id, max(t.number_value) keep (dense_rank last order by t.value_date) number_value
                            from ATTRIBUTE_VALUE_BY_DATE t group by object_id, attribute_id) a6 on a6.object_id = c.rnk and a6.attribute_id = l_cardless_loans_attr_id
                   left join (select object_id, attribute_id, max(t.number_value) keep (dense_rank last order by t.value_date) number_value
                            from ATTRIBUTE_VALUE_BY_DATE t group by object_id, attribute_id) a7 on a7.object_id = c.rnk and a7.attribute_id = l_energy_loans_attr_id
                   left join (select object_id, attribute_id, max(t.number_value) keep (dense_rank last order by t.value_date) number_value
                            from ATTRIBUTE_VALUE_BY_DATE t group by object_id, attribute_id) a8 on a8.object_id = c.rnk and a8.attribute_id = l_debit_cards_attr_id
                   left join (select object_id, attribute_id, max(t.number_value) keep (dense_rank last order by t.value_date) number_value
                            from ATTRIBUTE_VALUE_BY_DATE t group by object_id, attribute_id) a9 on a9.object_id = c.rnk and a9.attribute_id = l_current_accounts_attr_id
                   left join (select object_id, attribute_id, max(t.number_value) keep (dense_rank last order by t.value_date) number_value
                            from ATTRIBUTE_VALUE_BY_DATE t group by object_id, attribute_id) a10 on a10.object_id = c.rnk and a10.attribute_id = l_transactor_subseg_attr_id
                   where c.date_off is null and
                         c.custtype = 3 and
                         length(c.branch) = 22 and
                         (l_financial_segment_id is null or c.rnk in (select a.object_id
                                                                      from   (select object_id, attribute_id, max(t.number_value) keep (dense_rank last order by t.value_date) number_value
                                                                                from ATTRIBUTE_VALUE_BY_DATE t group by object_id, attribute_id) a
                                                                      where  a.attribute_id = l_financial_segment_attr_id and
                                                                             a.number_value = l_financial_segment_id)) and
                         (l_behavior_segment_id is null or c.rnk in (select a.object_id
                                                                     from   (select object_id, attribute_id, max(t.number_value) keep (dense_rank last order by t.value_date) number_value
                                                                                from ATTRIBUTE_VALUE_BY_DATE t group by object_id, attribute_id) a
                                                                     where  a.attribute_id = l_behavior_segment_attr_id and
                                                                            a.number_value = l_behavior_segment_id)) and
                         (l_social_vip_segment_id is null or c.rnk in (select v.rnk
                                                                       from   vip_flags v
                                                                       where  v.kvip = l_social_vip_segment_id))) t
           group by t.branch, t.activity_segment) s
    on (a.branch = s.branch and
        (a.activity_segment = s.activity_segment or (a.activity_segment is null and s.activity_segment is null)))
    when matched then update
         set a.clients_count = s.clients_count,
             a.transactor_subsegment = s.transactor_subsegment,
             a.general_prod_pressure = s.general_prod_pressure,
             a.deposit_factor = s.deposit_factor,
             a.secured_loans_factor = s.secured_loans_factor,
             a.card_loans_factor = s.card_loans_factor,
             a.cardless_loans_factor = s.cardless_loans_factor,
             a.energy_loans_factor = s.energy_loans_factor,
             a.debit_cards_factor = s.debit_cards_factor,
             a.current_accounts_factor = s.current_accounts_factor;

    for i in 1..(3 - l_report_branch_level) loop
        merge into tmp_customer_segment_report a
        using (select substr(t.branch, 1, instr(t.branch, '/', -2, i)) parent_branch,
                      t.activity_segment,
                      sum(t.clients_count) clients_count,
                      sum(t.general_prod_pressure) general_prod_pressure,
                      sum(deposit_factor) deposit_factor,
                      sum(secured_loans_factor) secured_loans_factor,
                      sum(card_loans_factor) card_loans_factor,
                      sum(cardless_loans_factor) cardless_loans_factor,
                      sum(energy_loans_factor) energy_loans_factor,
                      sum(debit_cards_factor) debit_cards_factor,
                      sum(current_accounts_factor) current_accounts_factor,
                      sum(transactor_subsegment) transactor_subsegment
               from   tmp_customer_segment_report t
               group by substr(t.branch, 1, instr(t.branch, '/', -2, i)), t.activity_segment) s
        on (a.branch = s.parent_branch and
            a.activity_segment = s.activity_segment)
        when matched then update
             set a.clients_count = s.clients_count,
                 a.general_prod_pressure = s.general_prod_pressure,
                 a.deposit_factor = s.deposit_factor,
                 a.secured_loans_factor = s.secured_loans_factor,
                 a.card_loans_factor = s.card_loans_factor,
                 a.cardless_loans_factor = s.cardless_loans_factor,
                 a.energy_loans_factor = s.energy_loans_factor,
                 a.debit_cards_factor = s.debit_cards_factor,
                 a.current_accounts_factor = s.current_accounts_factor,
                 a.transactor_subsegment = s.transactor_subsegment;
    end loop;

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
            t.transactor_subsegment) = (select sum(t2.clients_count),
                                               sum(t2.general_prod_pressure),
                                               sum(t2.deposit_factor),
                                               sum(t2.secured_loans_factor),
                                               sum(t2.card_loans_factor),
                                               sum(t2.cardless_loans_factor),
                                               sum(t2.energy_loans_factor),
                                               sum(t2.debit_cards_factor),
                                               sum(t2.current_accounts_factor),
                                               sum(t2.transactor_subsegment)
                                        from   tmp_customer_segment_report t2
                                        where  t2.branch = t.branch and
                                               t2.activity_segment is not null)
    where  t.activity_segment is null;

    update tmp_customer_segment_report t
    set    t.general_prod_pressure = t.general_prod_pressure / t.clients_count;

    --commit;
end;
/
show err;

PROMPT *** Create  grants  RPT_CUSTOMER_SEGMENT ***
grant EXECUTE                                                                on RPT_CUSTOMER_SEGMENT to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Procedure/RPT_CUSTOMER_SEGMENT.sql =========
PROMPT ===================================================================================== 
