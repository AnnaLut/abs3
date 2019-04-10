PROMPT ===========================================================================
PROMPT *** Run *** = Scripts /Sql/BARS/Script/fix_prolongation.sql = *** Run *** =
PROMPT ===========================================================================

declare
    l_data clob;
begin
    for i in (
              select p.id prolongation_process_id
                    ,m.id tranche_process_id
                    ,p.process_data prolongation_process_data
                    ,m.process_data tranche_process_data
                    ,prol.*
                    ,trn.*
                    ,m.object_id
                from process_type pt
                    ,process p            
                    ,process m
                    ,process_type ptm
                    ,xmltable ('/SMBDepositProlongation' passing xmltype(p.process_data) columns
                            start_date_          date   path 'StartDate'
                           ,expiry_date_         date   path 'ExpiryDate'
                           ,action_date_         date   path 'ActionDate' 
                           ,number_tranche_days_ number path 'NumberTrancheDays'
                                   ) prol
                    ,xmltable ('/SMBDepositTranche' passing xmltype(m.process_data) columns
                           start_date           date   path 'StartDate'
                          ,expiry_date          date   path 'ExpiryDate'
                          ,number_tranche_days  number path 'NumberTrancheDays'
                                   ) trn
               where pt.module_code = 'SMBD'
                 and pt.process_code = 'TRANCHE_PROLONGATION'
                 and pt.id = p.process_type_id
                 and p.object_id = m.object_id
                 and m.process_type_id = ptm.id
                 and ptm.module_code = 'SMBD'
                 and ptm.process_code = 'NEW_TRANCHE'
                 and prol.expiry_date_ = trn.expiry_date
        ) loop
            deal_utl.set_deal_expiry_date(
                                    p_deal_id     => i.object_id
                                   ,p_expiry_date => i.start_date_);

            update smb_deposit d set
                   d.current_prolongation_number = 1
                  ,d.expiry_date_prolongation    = i.expiry_date_
                  ,d.number_tranche_days         = i.number_tranche_days_
             where d.id = i.object_id;
  
            l_data := i.tranche_process_data; 
            l_data := smb_deposit_utl.update_value_in_xml(
                                       p_data        => l_data
                                      ,p_node_list   => t_dictionary (
                                                          t_dictionary_item( 
                                                              key   => 'ExpiryDate'
                                                             ,value => to_char(i.start_date_, 'yyyy-mm-dd'))
                                                         ,t_dictionary_item( 
                                                              key   => 'NumberTrancheDays'
                                                             ,value => i.number_tranche_days_))
                                      ,p_parent_node => smb_deposit_utl.PARENT_NODE_PROLONGATION);

            smb_deposit_utl.set_process_data(
                             p_process_id  => i.tranche_process_id
                            ,p_data        => l_data);
            commit;                      
   end loop;
end;
/

PROMPT ===========================================================================
PROMPT *** End *** = Scripts /Sql/BARS/Script/fix_prolongation.sql = *** End *** =
PROMPT ===========================================================================