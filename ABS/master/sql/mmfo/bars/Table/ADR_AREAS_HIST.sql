begin
  BPA.ALTER_POLICY_INFO( 'ADR_AREAS_HIST', 'WHOLE' , NULL, NULL, NULL, NULL );
  BPA.ALTER_POLICY_INFO( 'ADR_AREAS_HIST', 'FILIAL', null, null, null, null );
end;
/

prompt ... 


-- Create table
begin
    execute immediate 'create table ADR_AREAS_HIST
(
  id           NUMBER(10),
  ddate        DATE,
  area_id      NUMBER(10) not null,
  spiu_area_id NUMBER(10) not null,
  area_name    VARCHAR2(50) not null,
  area_name_ru VARCHAR2(50),
  region_id    NUMBER(10) not null,
  koatuu       VARCHAR2(5)
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

