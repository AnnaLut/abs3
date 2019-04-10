
PROMPT ==================================================================
PROMPT *** Run ** = Scripts /Sql/BARS/Table/SMB_DEPOSIT.sql = *** Run * =
PROMPT ==================================================================


PROMPT *** ALTER_POLICY_INFO to SMB_DEPOSIT ***

BEGIN 
        execute immediate  
          q'[begin  
               bpa.alter_policy_info('SMB_DEPOSIT', 'CENTER' , null, null, null, null);
               bpa.alter_policy_info('SMB_DEPOSIT', 'FILIAL' , null, null, null, null);
               bpa.alter_policy_info('SMB_DEPOSIT', 'WHOLE' , null, null, null, null);
           end; 
          ]'; 
END; 
/

PROMPT *** Create  table SMB_DEPOSIT ***
begin 
  execute immediate '
    create table smb_deposit(
       id                              number(38)      not null,
       currency_id                     number          not null,
       amount_tranche                  number, 
       is_replenishment_tranche        number          default 0 not null check (is_replenishment_tranche in (0, 1)),
       max_sum_tranche                 number,
       min_replenishment_amount        number,
       last_replenishment_date         date,
       is_prolongation                 number          default 0 not null check (is_prolongation in (0, 1)),
       number_prolongation             number,
       prolongation_interest_rate      number,
       apply_bonus_prolongation        number,
       frequency_payment               number,
       is_capitalization               number          default 0 not null check (is_capitalization in (0, 1)),
       is_individual_rate              number          default 0 not null check (is_individual_rate in (0, 1)),
       penalty_interest_rate           number,
       number_tranche_days             number,  
       last_accrual_date               date,
       last_payment_date               date,
       tail_amount                     number,
       general_interest_rate           number,
       bonus_interest_rate             number,
       capitalization_interest_rate    number,
       payment_interest_rate           number,
       replenishment_interest_rate     number,
       individual_interest_rate        number,
       calculation_type                number,  
       current_prolongation_number     number,
       expiry_date_prolongation        date,            
       sys_time                        date            default sysdate not null
    ) tablespace brsbigd';
 exception when others then
  if  sqlcode = -955 then 
    null; 
  else raise; 
  end if;
end;
/


PROMPT *** add column current_prolongation_number ***
begin 
  execute immediate 'alter table smb_deposit add current_prolongation_number number';
exception when others then       
  if sqlcode=-1430 then null; else raise; end if; 
end; 
/

PROMPT *** add column current_prolongation_number ***
begin 
  execute immediate 'alter table smb_deposit add expiry_date_prolongation date';
exception when others then       
  if sqlcode=-1430 then null; else raise; end if; 
end; 
/

comment on table  smb_deposit                                is 'SMB депозити (малий середній бізнес) ';
comment on column smb_deposit.id                             is 'ідентифікатор (ref object)';
comment on column smb_deposit.currency_id                    is 'ідентифікатор валюти';
comment on column smb_deposit.amount_tranche                 is 'сума траншу';
comment on column smb_deposit.is_replenishment_tranche       is 'поповнення траншу (0, 1)';
comment on column smb_deposit.max_sum_tranche                is 'максимальна сумма траншу';
comment on column smb_deposit.min_replenishment_amount       is 'мінімальна сума поповнення траншу';
comment on column smb_deposit.last_replenishment_date        is 'остання дата поповнення траншу';
comment on column smb_deposit.is_prolongation                is 'пролонгація (0, 1)';
comment on column smb_deposit.number_prolongation            is 'кіл-сть пролонгацій';
comment on column smb_deposit.prolongation_interest_rate     is '% ставка при пролонгаціі';
comment on column smb_deposit.apply_bonus_prolongation       is 'до якой пролонгації застосовується % ставка; 1 - до першої, 2 - до кожної';
comment on column smb_deposit.frequency_payment              is 'період виплати 1 - щомісяця; 2 - щоквартально; 3 - в кінці строку';
comment on column smb_deposit.is_capitalization              is 'капіталізація (0, 1)';
comment on column smb_deposit.is_individual_rate             is 'встановлено індивідуальну % ставка (0, 1)';
comment on column smb_deposit.penalty_interest_rate          is 'штрафна % ставка';
comment on column smb_deposit.number_tranche_days            is 'кіл-сть днів траншу';
comment on column smb_deposit.last_accrual_date              is 'дата останнього нарахування відсотків';
comment on column smb_deposit.last_payment_date              is 'остання дата виплати відсотків';
comment on column smb_deposit.tail_amount                    is 'остання остача від нарахувааня відсотків';
comment on column smb_deposit.general_interest_rate          is '% ставка базова';
comment on column smb_deposit.bonus_interest_rate            is '% ставка акційна';
comment on column smb_deposit.capitalization_interest_rate   is '% ставка при капиталізації';
comment on column smb_deposit.payment_interest_rate          is '% ставка при виплате';
comment on column smb_deposit.replenishment_interest_rate    is '% ставка при поповненні';
comment on column smb_deposit.individual_interest_rate       is 'індивідуальна % ставка';
comment on column smb_deposit.calculation_type               is 'метод нарахування % для вкладів на вимогу'; 
comment on column smb_deposit.current_prolongation_number    is 'номер діючої пролонгації (null - дїє "тіло" дерозиту)';
comment on column smb_deposit.expiry_date_prolongation       is 'останній день дії пролонгації (null - дїє "тіло" дерозиту)'; 
comment on column smb_deposit.sys_time                       is 'остання дата зміни';


PROMPT *** ALTER_POLICIES to SMB_DEPOSIT ***

exec bpa.alter_policies('SMB_DEPOSIT');

PROMPT *** Create  constraint PK_SMB_DEPOSIT ***
begin   
 execute immediate '
alter table smb_deposit
   add constraint pk_smb_deposit primary key (id)
      using index tablespace brsmdli';
 exception when others then
  if  sqlcode in (-955, -2260) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_SMB_DEPOSIT_RMAXS ***

begin   
 execute immediate '
alter table smb_deposit
   add constraint cc_smb_deposit_rmaxs check(case when is_replenishment_tranche = 1 then max_sum_tranche else 1 end is not null)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_SMB_DEPOSIT_RMINA ***

begin   
 execute immediate '
alter table smb_deposit
   add constraint cc_smb_deposit_rmina check(case when is_replenishment_tranche = 1 then min_replenishment_amount else 1 end is not null)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_SMB_DEPOSIT_RMMS ***
begin   
 execute immediate '
alter table smb_deposit
   add constraint cc_smb_deposit_rmms check(case when is_replenishment_tranche = 0 then 1
                                                         when is_replenishment_tranche = 1 
                                                          and max_sum_tranche >= min_replenishment_amount then 1
                                                         else 0
                                                    end = 1)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_SMB_DEPOSIT_APPLY_PROL ***

begin   
 execute immediate '
alter table smb_deposit
   add constraint cc_smb_deposit_apply_prol check(case when is_prolongation = 0 then 1
                                                         when is_prolongation = 1 
                                                          and apply_bonus_prolongation in (1, 2)  then 1
                                                         else 0
                                                    end = 1)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/


PROMPT *** Create  constraint CC_SMB_DEPOSIT_RLASTD ***

begin   
 execute immediate q'[
alter table smb_deposit
   add constraint cc_smb_deposit_rlastd check(case when is_replenishment_tranche = 1 then last_replenishment_date else date '2018-01-01' end is not null)]';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/

PROMPT *** Create  constraint CC_SMB_DEPOSIT_INDIVIDUAL ***
begin   
 execute immediate '
alter table smb_deposit
   add constraint cc_smb_deposit_individual check(case when is_individual_rate = 1 
                                                       then nvl(individual_interest_rate, 0)
                                                       else 1 
                                                  end <> 0)';
 exception when others then
  if  sqlcode in (-2260, -2261, -2264, -2275, -1442) then 
    null; 
  else raise; 
  end if;
end;
/


PROMPT *** Create  grants  SMB_DEPOSIT ***
grant SELECT  on SMB_DEPOSIT  to BARSREADER_ROLE;
grant select  on SMB_DEPOSIT  to BARS_ACCESS_DEFROLE;

PROMPT ==========================================================================
PROMPT *** End ** = Scripts /Sql/BARS/Table/SMB_DEPOSIT.sql = *** End * =
PROMPT ==========================================================================
