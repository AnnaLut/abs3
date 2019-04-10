declare
    l_interest_rate  number;
begin
    for i in (
              select distinct id, expiry_date, currency_id
                from(
                    select case when nvl(dpt.expiry_date_prolongation, d.expiry_date) < i.value_date then 1 end is_set
                          ,a.acc, a.blkd, a.lim, a.ostc, a.dazs, d.id, nvl(dpt.expiry_date_prolongation, d.expiry_date) expiry_date, d.branch_id, dpt.currency_id
                      from deal d
                          ,smb_deposit dpt
                          ,object o
                          ,object_state os
                          ,deal_account da
                          ,attribute_kind kda
                          ,attribute_kind ki
                          ,attribute_value_by_date i 
                          ,accounts a
                     where d.close_date is null
                       and nvl(dpt.expiry_date_prolongation, d.expiry_date) < gl.bd 
                       and d.id = dpt.id
                       and dpt.id = o.id
                       and o.state_id = os.id
                       and os.state_code in ('BLOCKED', 'ACTIVE')
                       and o.id = da.deal_id
                       and da.account_type_id = kda.id
                       and kda.attribute_code = 'DEPOSIT_PRIMARY_ACCOUNT'
                       and ki.attribute_code = 'SMB_DEPOSIT_TRANCHE_INTEREST_RATE'
                       and ki.id = i.attribute_id
                       and i.object_id = o.id
                       and da.account_id = a.acc) x
                     where is_set is null
                       and (blkd <> 0 or lim <> 0) 
                       and not exists(
                           select null
                             from process p
                                 ,process_type pt
                            where p.object_id = x.id
                              and pt.id = p.process_type_id
                              and pt.process_code = 'PROCESSING_BLOCKED_DEPOSIT')
              ) loop
                  -- новая ставка                
                  l_interest_rate := smb_deposit_utl.get_interest_rate_blocked(
                                              p_object_id   => i.id 
                                             ,p_date        => i.expiry_date + 1
                                             ,p_currency_id => i.currency_id);
                  if l_interest_rate is not null then                           
                      -- устанавливаем с "завтра"             
                      smb_deposit_utl.set_interest_rate_tranche(
                                           p_object_id     => i.id
                                          ,p_interest_rate => l_interest_rate
                                          ,p_valid_from    => i.expiry_date + 1
                                          ,p_comment       => 'closing blocked deposit : '||i.id);
                  end if;
                  tools.hide_hint(
                       process_utl.process_create(
                                            p_proc_type_code    => smb_deposit_utl.PROCESS_PROCESSING_BLOCKED_DPT
                                           ,p_proc_type_module  => smb_deposit_utl.PROCESS_TRANCHE_MODULE
                                           ,p_process_name      => '[обработка заблокированного транша / счета]'
                                           ,p_process_data      => '<SMBDepositTranche><ActionDate>'||to_char(i.expiry_date, 'yyyy-mm-dd')||'</ActionDate>'||
                                                                   '<InterestRate>'||l_interest_rate||'</InterestRate></SMBDepositTranche>'
                                           ,p_process_object_id => i.id));
           end loop;
     commit;
end;
/