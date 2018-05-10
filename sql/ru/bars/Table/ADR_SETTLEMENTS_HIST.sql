begin
  BPA.ALTER_POLICY_INFO( 'ADR_SETTLEMENTS_HIST', 'WHOLE' , NULL, NULL, NULL, NULL );
  BPA.ALTER_POLICY_INFO( 'ADR_SETTLEMENTS_HIST', 'FILIAL', null, null, null, null );
end;
/

prompt ... 


-- Create table
begin
    execute immediate 'create table ADR_SETTLEMENTS_HIST
(
  id                 NUMBER(10),
  ddate              DATE,
  settlement_id      NUMBER(10) not null,
  settlement_name    VARCHAR2(50) not null,
  settlement_name_ru VARCHAR2(50),
  settlement_type_id NUMBER(3) not null,
  postal_code_min    VARCHAR2(5) not null,
  postal_code_max    VARCHAR2(5) not null,
  phone_code_id      NUMBER(10),
  region_center_f    NUMBER(1) not null,
  area_center_f      NUMBER(1) not null,
  region_id          NUMBER(10),
  area_id            NUMBER(10),
  koatuu             VARCHAR2(15),
  terrstatus         VARCHAR2(50),
  eff_dt             DATE not null,
  end_dt             DATE,
  settlement_pid     NUMBER(10),
  spiu_city_id       NUMBER(10) not null,
  spiu_suburb_id     NUMBER(10)
)
tablespace BRSDYND
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 128K
    minextents 1
    maxextents unlimited
    pctincrease 0
  )';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

