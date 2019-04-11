-- заполняем счета штраф
declare
    l_account_number   varchar2(15 char);
    l_account_type_id  number;
    l_branch           varchar2(8);
begin
    l_account_type_id := attribute_utl.get_attribute_id(p_attribute_code => 'DEPOSIT_PENALTY_EXPENSE_ACCOUNT');  
    for acc_type in (select * from deal_balance_account_settings t where t.account_type_id = l_account_type_id) loop
        for b in (select branch from branch b where b.branch <> '/' and b.date_closed is null order by b.branch) loop
            if l_branch is null or l_branch <> substr(b.branch, 1, 8) then
                l_branch := substr(b.branch, 1, 8);
                bc.go(l_branch);
            end if;
            l_account_number := nbs_ob22_null(acc_type.balance_account, acc_type.ob22_code, b.branch);
            deal_utl.set_deal_account_settings(acc_type.account_type_id, acc_type.deal_group_id, acc_type.currency_id, acc_type.product_id, b.branch, account_utl.get_account_id(l_account_number, 980, bars_context.extract_mfo(b.branch)));
        end loop;
        commit;
        l_branch := null;
    end loop;
    bc.go('/');
end;
/
