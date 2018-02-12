begin
  BPA.ALTER_POLICY_INFO( 'ADR_REGIONS_HIST', 'WHOLE' , NULL, NULL, NULL, NULL );
  BPA.ALTER_POLICY_INFO( 'ADR_REGIONS_HIST', 'FILIAL', null, null, null, null );
end;
/

prompt ... 


-- Create table
begin
    execute immediate 'create table ADR_REGIONS_HIST
(
  id             NUMBER(10),
  ddate          DATE,
  region_id      NUMBER(10) not null,
  region_name    VARCHAR2(50) not null,
  region_name_ru VARCHAR2(50),
  country_id     NUMBER(3) not null,
  koatuu         VARCHAR2(2),
  iso3166_2      VARCHAR2(5)
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