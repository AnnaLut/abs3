begin
    insert into deal_account_type
    select t.id, null, null, null, null, 'N'
    from   attribute_kind t
    where  t.attribute_code in ('DKBO_ACC_LIST') and
           not exists (select 1 from deal_account_type tt
                       where  tt.id = t.id);
    commit;
end;
/
