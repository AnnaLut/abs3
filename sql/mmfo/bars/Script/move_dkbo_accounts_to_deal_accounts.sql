begin
    insert into deal_account
    select /*+ noparallel */ f.object_id, f.attribute_id, v.number_values
    from   (select t.object_id,
                   t.attribute_id,
                   min(t.nested_table_id) keep (dense_rank last order by t.value_date) active_nested_table_id
            from   attribute_value_by_date t
            where  t.attribute_id = (select a.id from attribute_kind a where a.attribute_code = 'DKBO_ACC_LIST') and
                   t.value_date <= sysdate
            group by t.object_id, t.attribute_id) f
    join attribute_values v on v.nested_table_id = f.active_nested_table_id
    join accounts a on a.acc = v.number_values
    join deal d on d.id = f.object_id
    minus
    select * from deal_account;

    commit;
end;
/