PROMPT ======================================================================================= 
PROMPT *** Run *** = Scripts /Sql/BARS/Script/ALTER_DEPOSIT_ON_DEMAND_CONDITION.sql = *** Run *** =
PROMPT ======================================================================================= 

set define on

define tbl_Spce_ = BRSSMLD
define tbl_Spce_idx = BRSMDLI

begin
    begin
         execute immediate '
            alter table deposit_on_demand_condition drop column product_id';
    exception
        when others then
        if sqlcode in (-904) then 
           null;
        end if;
    end;  
    
    begin
         execute immediate '
            alter table deposit_on_demand_condition add interest_option_id number';
    exception
        when others then
        if sqlcode in (-904, -1430) then 
           null;
        else raise;
        end if;
    end;  
    begin
        execute immediate '
         drop index ui_deposit_on_demand_condition';
    exception
     when others then
       if sqlcode = -1418 then 
          null;
       else raise;
       end if;
    end;    
    -- удаляем дубликаты
    execute immediate'
    delete
      from deposit_on_demand_condition
     where rowid not in (
                select max(rowid) 
                  from deposit_on_demand_condition
                group by currency_id, interest_option_id, currency_id, amount_from)';
    commit;
    begin
        execute immediate '
            create unique index ui_deposit_on_demand_condition on 
                 deposit_on_demand_condition (interest_option_id, currency_id, amount_from) tablespace &tbl_Spce_idx';
    exception when others then
       if sqlcode = -955 then 
          null;
       else raise;  
       end if;
    end;
end;
/

declare
   l_qty number;
begin

    select count(*)
      into l_qty  
      from deposit_on_demand_condition
     where interest_option_id is null;
    if l_qty > 0 then  
        declare
            l_kind_id  number;
            l_id       number;
        begin
            l_kind_id := smb_deposit_utl.read_deal_interest_rate_kind(
                                       p_deal_interest_rate_kind_code => smb_deposit_utl.ON_DEMAND_GENERAL_KIND_CODE
                                      ,p_raise_ndf                    => true
                                      ).id;
            select max(id)
              into l_id  
              from deal_interest_option
             where rate_kind_id = l_kind_id
               and valid_from = date '2018-01-01';
                
            if l_id is null then                                       
                l_id := deal_interest_option_seq.nextVal;
                                          
                insert into deal_interest_option (id, product_id, rate_kind_id, valid_from, valid_through, is_active, user_id )
                     values(l_id, smb_deposit_ui.get_on_demand_product(), l_kind_id, date '2018-01-01', null, 1, user_id())
                     ;
            end if;        
            
           update deposit_on_demand_condition set
               interest_option_id = l_id
            where interest_option_id is null; 
           commit;    
        end;    
    end if;
    begin
        execute immediate '            
            alter table deposit_on_demand_condition modify (interest_option_id constraint cc_dpt_on_demand_cond_io_id_nn not null enable)';
    exception when others then
      if  sqlcode in (-2260, -2261, -2264, -2275, -1442, -904) then 
        null; 
      else raise; 
      end if;
    end;
end;
/

undefine tbl_Spce_
undefine tbl_Spce_idx

set define off

PROMPT ======================================================================================= 
PROMPT *** END *** = Scripts /Sql/BARS/Script/ALTER_DEPOSIT_ON_DEMAND_CONDITION.sql = *** End *** =
PROMPT =======================================================================================