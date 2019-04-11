
PROMPT ===================================================================================== 
PROMPT *** Run *** ====== Scripts /Sql/BARS/Table/DEPOSIT_PAYMENT.sql ====== *** Run *** ===
PROMPT ===================================================================================== 
set define on

PROMPT *** ALTER_POLICY_INFO to DEPOSIT_PAYMENT ***

define tbl_Spce_ = BRSSMLD
define tbl_Spce_idx = BRSMDLI

BEGIN 
        execute immediate  
          q'[begin  
               bpa.alter_policy_info('DEPOSIT_PAYMENT', 'CENTER' , null, null, null, null);
               bpa.alter_policy_info('DEPOSIT_PAYMENT', 'FILIAL' , null, null, null, null);
               bpa.alter_policy_info('DEPOSIT_PAYMENT', 'WHOLE' , null, null, null, null);
           end; 
          ]'; 
END; 
/

PROMPT *** Create  table DEPOSIT_PAYMENT ***

begin 
  execute immediate '
    create table deposit_payment  (
       id                   number,
       interest_option_id   number,
       payment_term_id      number,
       currency_id          number,
       interest_rate        number
    ) tablespace &tbl_Spce_';
 exception when others then       
  if  sqlcode = -955 then 
    null; 
  else raise; 
  end if;
end;
/

comment on table  deposit_payment                    is '% ставки при виплаті нарахованих % по депозиту';
comment on column deposit_payment.id                 is 'ідентифікатор';
comment on column deposit_payment.interest_option_id is 'ідентифікатор умов (ref deal_interest_option)';
comment on column deposit_payment.currency_id        is 'ідентифікатор валюти';
comment on column deposit_payment.payment_term_id    is 'період виплати 1 - щомісяця; 2 - щоквартально; 3 - в кінці строку';
comment on column deposit_payment.interest_rate      is '% ставка';


PROMPT *** ALTER_POLICIES to DEPOSIT_PAYMENT ***

exec bpa.alter_policies('DEPOSIT_PAYMENT');

PROMPT *** Create  constraint PK_DEPOSIT_PAYMENT ***
begin   
 execute immediate '
    alter table deposit_payment add constraint pk_deposit_payment
                primary key (id) using index tablespace &tbl_Spce_idx';
 exception when others then
  if  sqlcode in (-955, -2260) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  index IDX_DEPOSIT_PAYMENT_IO_ID ***
begin   
 execute immediate '
    create index idx_deposit_payment_io_id on DEPOSIT_PAYMENT(interest_option_id) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode = -955 then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  index IDX_DEPOSIT_PAYMENT_CURR_ID ***
begin   
 execute immediate '
    create index idx_deposit_payment_curr_id on deposit_payment(currency_id) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode = -955 then 
      null;
   else raise;  
   end if;
end;
/


PROMPT *** Create  index UI_DEPOSIT_PAYMENT ***
begin   
 execute immediate '
    create unique index ui_deposit_payment on deposit_payment(interest_option_id, currency_id, payment_term_id) tablespace &tbl_Spce_idx';
 exception when others then
   if sqlcode = -955 then 
      null;
   else raise;  
   end if;
end;
/

PROMPT *** Create  constraint CC_DEPOSIT_PAYMENT_ID_NN ***
begin   
 execute immediate '            
    alter table deposit_payment modify (id constraint cc_deposit_payment_id_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DEPOSIT_PAYMENT_IO_ID_NN ***
begin   
 execute immediate '
    alter table deposit_payment modify (interest_option_id constraint cc_deposit_payment_io_id_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DEPOSIT_PAYMENT_CURR_NN ***
begin   
 execute immediate '
    alter table deposit_payment modify (currency_id constraint cc_deposit_payment_curr_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DEPOSIT_PAYMENT_IREST_NN ***
begin   
 execute immediate '
    alter table deposit_payment modify (interest_rate constraint cc_deposit_payment_irest_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_DEPOSIT_PAYMENT_PTERM_NN ***
begin   
 execute immediate '
    alter table deposit_payment modify (payment_term_id constraint cc_deposit_payment_pterm_nn not null enable)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  grants  DEPOSIT_PAYMENT ***
grant SELECT  on DEPOSIT_PAYMENT  to BARSREADER_ROLE;
grant select  on DEPOSIT_PAYMENT  to BARS_ACCESS_DEFROLE;

PROMPT ===================================================================================== 
PROMPT *** End *** ====== Scripts /Sql/BARS/Table/DEPOSIT_PAYMENT.sql ====== *** End *** ===
PROMPT ===================================================================================== 

undefine tbl_Spce_
undefine tbl_Spce_idx
set define off