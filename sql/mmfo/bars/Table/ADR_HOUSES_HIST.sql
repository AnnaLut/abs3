begin
  BPA.ALTER_POLICY_INFO( 'ADR_HOUSES_HIST', 'WHOLE' , NULL, NULL, NULL, NULL );
  BPA.ALTER_POLICY_INFO( 'ADR_HOUSES_HIST', 'FILIAL', null, null, null, null );
end;
/

prompt ... 


-- Create table
begin
    execute immediate 'create table ADR_HOUSES_HIST
(
  id            NUMBER(10),
  ddate         DATE,
  house_id      NUMBER(10) not null,
  street_id     NUMBER(10) not null,
  district_id   NUMBER(10),
  house_num     VARCHAR2(5),
  house_num_add VARCHAR2(15),
  postal_code   VARCHAR2(5),
  latitude      VARCHAR2(15),
  longitude     VARCHAR2(15)
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

