PROMPT ======================================================================================
PROMPT *** Run *** = Scripts /Sql/BARS/Script/ALTER_DEPOSIT_REPLENISHMENT.sql = *** Run *** =
PROMPT ======================================================================================

set define on 
define tbl_Spce_ = BRSSMLD
define tbl_Spce_idx = BRSMDLI

declare
    l_found number;
begin
    select count(*)
      into l_found
      from user_tab_cols
     where table_name = 'DEPOSIT_REPLENISHMENT'
       and column_name = 'IS_REPLENISHMENT';
    if l_found = 0 then
        begin
             execute immediate '
                alter table deposit_replenishment add is_replenishment number';
        exception
            when others then
            if sqlcode in (-904, -1430) then 
               null;
            else raise;
            end if;
        end;
        execute immediate '
        update deposit_replenishment set
              is_replenishment = 1
         where is_replenishment is null';
        begin 
            execute immediate '            
                alter table deposit_replenishment modify is_replenishment default 1 not null check( is_replenishment in (0, 1))';
        exception when others then
          if  sqlcode in (-2260, -2261, -2264, -2275, -1442, -904) then 
            null; 
          else raise; 
          end if;
        end;
        begin
            execute immediate '
             drop index ui_dpt_replenishment';
        exception
         when others then
           if sqlcode = -1418 then 
              null;
           else raise;
           end if;
        end;    
        begin   
         execute immediate '
            create unique index ui_dpt_replenishment on deposit_replenishment(interest_option_id, currency_id, is_replenishment) tablespace &tbl_Spce_idx';
         exception when others then
           if sqlcode = -955 then 
              null;
           else raise;  
           end if;
        end;
    end if;    
end;
/

undefine tbl_Spce_
undefine tbl_Spce_idx

set define off

PROMPT ======================================================================================
PROMPT *** END *** = Scripts /Sql/BARS/Script/ALTER_DEPOSIT_REPLENISHMENT.sql = *** End *** =
PROMPT ======================================================================================