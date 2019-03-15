prompt ===========================================
prompt = создание таблицы DPA_EAD_NBS
prompt = Балансові рахунки для формування звіту в ЕА
prompt ===========================================

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPA_EAD_NBS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPA_EAD_NBS ***
execute bpa.alter_policy_info( 'DPA_EAD_NBS', 'WHOLE' , null, null, null, null ); 
execute bpa.alter_policy_info( 'DPA_EAD_NBS', 'FILIAL', null, null, null, null );


-- Create table
begin
  execute immediate '
create table DPA_EAD_NBS
(
  struct_code varchar2(30) not null,
  nbs         varchar2(4)  not null,
  custtype    integer      not null,
  oper_type   number(1)    not null,
  tip         varchar2(30) not null,
  is_ddbo     number(1)    not null,
  agr_type    varchar2(100) not null,
  acc_type    varchar2(100),
  name        varchar2(256),
  id          number(38) not null
)
tablespace BRSSMLD';
exception when others then if (sqlcode = -955) then null; else raise; end if;
end;
/



PROMPT *** ALTER_POLICIES to DPA_EAD_NBS ***
execute bpa.alter_policies('DPA_EAD_NBS');


COMMENT ON TABLE DPA_EAD_NBS              IS 'Балансові рахунки для синхронізації з ЕА';
COMMENT ON COLUMN DPA_EAD_NBS.struct_code IS 'Код документа';
COMMENT ON COLUMN DPA_EAD_NBS.NBS         IS 'Балансовий рахунок до відправки';
COMMENT ON COLUMN DPA_EAD_NBS.CUSTTYPE    IS 'Групування для різних типів клієнта';
COMMENT ON COLUMN DPA_EAD_NBS.OPER_TYPE   IS 'Тип операції: 1 - відкриття рахунку, 2 - закриття рахунку';
COMMENT ON COLUMN DPA_EAD_NBS.TIP         IS 'Тип рахунку (або маска -  TIP%)  з урахуванням довідника TIPS';
COMMENT ON COLUMN DPA_EAD_NBS.IS_DDBO     IS 'Ознака ДБО 1 - Так / 0 - Ні';
COMMENT ON COLUMN DPA_EAD_NBS.AGR_TYPE    IS 'Тип угоди, якщо безумовний, якщо є варіанті - не заповнювати';
COMMENT ON COLUMN DPA_EAD_NBS.ACC_TYPE    IS 'Тип рахунку, якщо безумовний, якщо є варіанті - не заповнювати';
COMMENT ON COLUMN DPA_EAD_NBS.NAME        IS 'Назва типу документа';
COMMENT ON COLUMN DPA_EAD_NBS.id          IS 'Локальный ідентифікатор';

PROMPT *** Create  index UK_DPAEADNBS ***
begin
--  execute immediate 'drop INDEX PK_EADNBS';
  execute immediate 'CREATE UNIQUE INDEX UK_DPAEADNBS ON DPA_EAD_NBS (struct_code,nbs,custtype,oper_type,tip,is_ddbo) TABLESPACE brssmli';
exception when others then if (sqlcode = -955) then null; else raise; end if;
end;
/

PROMPT *** Create constraint PK_DPAEADNBS_ID ***
begin
    execute immediate 'alter table DPA_EAD_NBS
                       add constraint PK_DPAEADNBS_ID primary key (ID)
                       using index';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

PROMPT *** Create  grants  DPA_EAD_NBS ***
GRANT SELECT ON DPA_EAD_NBS TO BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPA_EAD_NBS.sql =========*** End *** =====
PROMPT ===================================================================================== 
