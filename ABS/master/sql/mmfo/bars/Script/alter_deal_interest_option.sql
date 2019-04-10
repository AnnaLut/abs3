PROMPT ====================================================================================
PROMPT *** Run *** = Scripts /Sql/BARS/Script/ALTER_DEAL_INTEREST_OPTION.sql = *** Run *** =
PROMPT ====================================================================================

set define on

define tbl_Spce_ = BRSSMLD
define tbl_Spce_idx = BRSMDLI

begin
    begin
        execute immediate '
         alter table deal_interest_option add option_description varchar2(100)';
        exception
            when others then
            if sqlcode in (-904, -1430) then 
               null;
            else raise;
            end if;
    end;
    -- recreate index ui_deal_interest_option    
    begin
        execute immediate '
         drop index ui_deal_interest_option';
    exception
     when others then
       if sqlcode = -1418 then 
          null;
       else raise;
       end if;
    end;    
    begin   
     execute immediate '
        create unique index ui_deal_interest_option on deal_interest_option (rate_kind_id, valid_from, case when is_active = 1 then 1 else id end) tablespace &tbl_Spce_idx';
     exception when others then
       if sqlcode in (-1408, -955) then 
          null;
       else raise;  
       end if;
    end;    
end;  
/

undefine tbl_Spce_
undefine tbl_Spce_idx

set define off

PROMPT ==================================================================================== 
PROMPT *** End *** = Scripts /Sql/BARS/Script/ALTER_DEAL_INTEREST_OPTION.sql = *** End *** =
PROMPT ==================================================================================== 