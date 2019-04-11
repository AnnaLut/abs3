
PROMPT ===================================================================================== 
PROMPT *** Run *** = Scripts /Sql/BARS/Table/TERMS_REPLENISHMENT_TRANCHE.sql = *** Run *** =
PROMPT ===================================================================================== 
set define on

PROMPT *** ALTER_POLICY_INFO to TERMS_REPLENISHMENT_TRANCHE ***

define tbl_Spce_ = BRSSMLD
define tbl_Spce_idx = BRSMDLI

BEGIN 
        execute immediate  
          q'[begin  
               bpa.alter_policy_info('TERMS_REPLENISHMENT_TRANCHE', 'CENTER' , null, null, null, null);
               bpa.alter_policy_info('TERMS_REPLENISHMENT_TRANCHE', 'FILIAL' , null, null, null, null);
               bpa.alter_policy_info('TERMS_REPLENISHMENT_TRANCHE', 'WHOLE' , null, null, null, null);
           end; 
          ]'; 
END; 
/

PROMPT *** Create  table TERMS_REPLENISHMENT_TRANCHE ***
begin 
  execute immediate '
    create table terms_replenishment_tranche  (
       id                       number,
       interest_option_id       number,
       tranche_term             number,
       days_to_close_replenish  number
    ) tablespace &tbl_Spce_';
 exception when others then       
  if  sqlcode = -955 then 
    null; 
  else raise; 
  end if;
end;
/

comment on table  terms_replenishment_tranche                         is 'Строки поповнення траншів';
comment on column terms_replenishment_tranche.id                      is 'ідентифікатор';
comment on column terms_replenishment_tranche.interest_option_id      is 'ідентифікатор умов (ref deal_interest_option)';
comment on column terms_replenishment_tranche.tranche_term            is 'термін розміщення траншу';
comment on column terms_replenishment_tranche.days_to_close_replenish is 'припинення поповнення траншу за n кількість днів до повернення траншу';


PROMPT *** ALTER_POLICIES to TERMS_REPLENISHMENT_TRANCHE ***

exec bpa.alter_policies('TERMS_REPLENISHMENT_TRANCHE');

PROMPT *** Create  constraint PK_TERMS_REPLENISHMENT_TRANCHE ***
begin   
 execute immediate '
    alter table terms_replenishment_tranche add constraint pk_terms_replenishment_tranche
                primary key (id) using index tablespace &tbl_Spce_idx';
 exception when others then
  if  sqlcode in (-955, -2260) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_TERMS_REPL_TRANCHE_ID_NN ***
begin   
 execute immediate '
    alter table terms_replenishment_tranche modify (id constraint cc_terms_repl_tranche_id_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_TERMS_REPL_TRANCHE_DAYS_NN ***
begin   
 execute immediate '
    alter table terms_replenishment_tranche modify (days_to_close_replenish constraint cc_terms_repl_tranche_days_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_TERMS_REPL_TRANCHE_TERM_NN ***
begin   
 execute immediate '
    alter table terms_replenishment_tranche modify (tranche_term constraint cc_terms_repl_tranche_term_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  index UI_TERMS_REPLENISHMENT_TRANCHE ***
begin   
 execute immediate '
    create unique index ui_terms_replenishment_tranche on terms_replenishment_tranche(interest_option_id, tranche_term) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode in (-955, -904, -1452) then 
      null;
   else raise;  
   end if;
end;
/

begin 
    execute immediate '            
        alter table terms_replenishment_tranche modify (interest_option_id constraint cc_terms_repl_tranche_io_id_nn not null enable)';
exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442, -904, -2296) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  index IDX_TERMS_REPL_TRANCHE_IO ***
begin   
 execute immediate '
    create index idx_terms_repl_tranche_io on terms_replenishment_tranche(interest_option_id) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode in (-955, -904) then 
      null;
   else raise;  
   end if;
end;
/


PROMPT *** Create  constraint FK_TERMS_REPLT_TRANCHE_IO_ID ***
begin   
 execute immediate '
    alter table terms_replenishment_tranche add constraint fk_terms_replt_tranche_io_id
            foreign key (interest_option_id) references deal_interest_option( id ) enable novalidate';
 exception when others then              
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442, -904) then 
    null; 
  else raise; 
  end if;
end;
/


PROMPT *** Create  grants  TERMS_REPLENISHMENT_TRANCHE ***
grant SELECT  on TERMS_REPLENISHMENT_TRANCHE  to BARSREADER_ROLE;
grant select  on TERMS_REPLENISHMENT_TRANCHE  to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** = Scripts /Sql/BARS/Table/TERMS_REPLENISHMENT_TRANCHE.sql = *** End *** =
PROMPT ===================================================================================== 

undefine tbl_Spce_
undefine tbl_Spce_idx

set define off