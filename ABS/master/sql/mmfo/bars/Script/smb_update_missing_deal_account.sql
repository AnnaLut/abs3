declare
    -- COBUDPUMMSB-332
    l_att_id           number;
    l_main_account_row accounts%rowtype;
begin
    select id
      into l_att_id
      from attribute_kind k
     where k.attribute_code(+) = 'DEPOSIT_PRIMARY_ACCOUNT';
    for i in (select * from mv_kf) loop
        bc.go(i.kf);
        for j in (
            select p.object_id, nvl(trn.Primary_Account, dod.Primary_Account) Primary_Account, dpt.currency_id
              from process_type t
                  ,process p 
                  ,deal_account da
                  ,object o
                  ,object_state s
                  ,smb_deposit dpt
                  ,xmlTable('/SMBDepositTranche' passing xmltype(p.process_data) columns
                                         Primary_Account               varchar2(100)  path 'PrimaryAccount'                   
                                                           )(+) trn
                  ,xmlTable('/SMBDepositOnDemand' passing xmltype(p.process_data) columns
                                         Primary_Account               varchar2(100)  path 'PrimaryAccount'                   
                                                           )(+) dod
             where process_code in ('NEW_TRANCHE', 'NEW_ON_DEMAND')
               and t.id = p.process_type_id
               and p.object_id = da.deal_id(+)
               and da.account_type_id(+) = l_att_id
               and o.id = p.object_id
               and o.state_id = s.id
               and s.state_code in ('ACTIVE', 'BLOCKED')
               and p.object_id = dpt.id
               and da.deal_id is null) 
      loop
            l_main_account_row := account_utl.read_account(
                                                p_account_number => j.primary_account
                                               ,p_currency_id    => j.currency_id
                                               ,p_mfo            => i.kf
                                               ,p_raise_ndf => false);
            if l_main_account_row.acc is not null then  
                deal_utl.set_deal_account(p_deal_id => j.object_id 
                                         ,p_account_type_code => 'DEPOSIT_PRIMARY_ACCOUNT'
                                         ,p_account_id => l_main_account_row.acc);
            end if;
      end loop;
      commit;
  end loop;
 bc.go('/');
end;
/