begin
  BPA.ALTER_POLICY_INFO( 'ADR_CITY_DISTRICTS_HIST', 'WHOLE' , NULL, NULL, NULL, NULL );
  BPA.ALTER_POLICY_INFO( 'ADR_CITY_DISTRICTS_HIST', 'FILIAL', null, null, null, null );
end;
/

prompt ... 


-- Create table
begin
    execute immediate 'create table ADR_CITY_DISTRICTS_HIST
(
  id               NUMBER(10),
  ddate            DATE,
  district_id      NUMBER(3) not null,
  district_name    VARCHAR2(50) not null,
  district_name_ru VARCHAR2(50),
  settlement_id    NUMBER(10) not null,
  spiu_district_id NUMBER(10) not null
)
tablespace BRSDYND
  pctfree 10
  initrans 1
  maxtrans 255';
 exception when others then 
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

