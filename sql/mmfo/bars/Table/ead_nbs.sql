prompt ===========================================
prompt = создание таблицы EAD_NBS
prompt = Балансові рахунки для синхронізації з ЕА
prompt ===========================================

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EAD_NBS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EAD_NBS ***
execute bpa.alter_policy_info( 'EAD_NBS', 'WHOLE' , null, null, null, null ); 
execute bpa.alter_policy_info( 'EAD_NBS', 'FILIAL', null, null, null, null );


-- Create table
begin
  execute immediate '
create table EAD_NBS
(
  nbs      CHAR(4) not null,
  custtype INTEGER not null,
--SED_CONDITION    varchar2(100),
  agr_type VARCHAR2(100),
  acc_type VARCHAR2(100)
)
tablespace BRSSMLD';
exception when others then if (sqlcode = -955) then null; else raise; end if;
end;
/


-- Add/modify columns 
begin
  for i in (select 1 from dual where not exists (select 1 from user_tab_cols where TABLE_NAME = 'EAD_NBS' and COLUMN_NAME = 'AGR_TYPE')) loop
    execute immediate 'alter table EAD_NBS add agr_type varchar2(100)';
  end loop;
  for i in (select 1 from dual where not exists (select 1 from user_tab_cols where TABLE_NAME = 'EAD_NBS' and COLUMN_NAME = 'ACC_TYPE')) loop
    execute immediate 'alter table EAD_NBS add acc_type varchar2(100)';
  end loop;
end;
/


PROMPT *** ALTER_POLICIES to EAD_NBS ***
execute bpa.alter_policies('EAD_NBS');


COMMENT ON TABLE EAD_NBS IS 'Балансові рахунки для синхронізації з ЕА';
COMMENT ON COLUMN EAD_NBS.NBS IS 'Балансовий рахунок до відправки';
COMMENT ON COLUMN EAD_NBS.CUSTTYPE IS 'Групування для різних типів клієнта';
COMMENT ON COLUMN EAD_NBS.AGR_TYPE IS 'Тип угоди, якщо безумовний, якщо є варіанті - не заповнювати';
COMMENT ON COLUMN EAD_NBS.ACC_TYPE IS 'Тип рахунку, якщо безумовний, якщо є варіанті - не заповнювати';


PROMPT *** Create  index PK_EADNBS ***
begin
  execute immediate 'CREATE UNIQUE INDEX PK_EADNBS ON EAD_NBS (NBS,CUSTTYPE) TABLESPACE brssmli';
exception when others then if (sqlcode = -955) then null; else raise; end if;
end;
/



PROMPT *** Create  grants  EAD_NBS ***
GRANT SELECT ON EAD_NBS TO BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EAD_NBS.sql =========*** End *** =====
PROMPT ===================================================================================== 
