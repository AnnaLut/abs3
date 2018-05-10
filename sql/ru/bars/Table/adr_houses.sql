begin
  BPA.ALTER_POLICY_INFO( 'ADR_HOUSES', 'WHOLE' , NULL, NULL, NULL, NULL );
  BPA.ALTER_POLICY_INFO( 'ADR_HOUSES', 'FILIAL', null, null, null, null );
end;
/

prompt ... 

-- Create table
create table BARS.ADR_HOUSES
(
  house_id      NUMBER(10) not null,
  street_id     NUMBER(10) not null,
  district_id   NUMBER(10),
  house_num     VARCHAR2(5),
  house_num_add VARCHAR2(15),
  postal_code   VARCHAR2(5),
  latitude      VARCHAR2(15),
  longitude     VARCHAR2(15)
)
tablespace BRSMDLD
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
  );
-- Add comments to the table 
comment on table BARS.ADR_HOUSES
  is 'Довідник номерів будинків';
-- Add comments to the columns 
comment on column BARS.ADR_HOUSES.house_id
  is 'Ід. будинку';
comment on column BARS.ADR_HOUSES.street_id
  is 'Ід. вулиці (в населеному пункті)';
comment on column BARS.ADR_HOUSES.district_id
  is 'Ід. району в місті';
comment on column BARS.ADR_HOUSES.house_num
  is 'Номер будинку';
comment on column BARS.ADR_HOUSES.house_num_add
  is 'дополнительная часть номера дома (содержит дробную или буквенную часть)';
comment on column BARS.ADR_HOUSES.postal_code
  is 'Поштовий індекс будинку';
comment on column BARS.ADR_HOUSES.latitude
  is 'Географічні координати будинку (широта)';
comment on column BARS.ADR_HOUSES.longitude
  is 'Географічні координати будинку (довгота)';

-- Create/Rebegin
begin
    execute immediate 'create index BARS.I_ADRHOUSES_STREETID on BARS.ADR_HOUSES (STREET_ID)
  tablespace BRSMDLI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 64K
    minextents 1
    maxextents unlimited
    pctincrease 0
  )';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/ 

-- Create/Recreate primary, unique and foreign key constraints 
alter table BARS.ADR_HOUSES
  add constraint PK_HOUSENUMS primary key (HOUSE_ID)
  using index 
  tablespace BRSMDLI
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 64K
    minextents 1
    maxextents unlimited
    pctincrease 0
  );
alter table BARS.ADR_HOUSES
  add constraint FK_HOUSENUMS_CITYDISTRICTS foreign key (DISTRICT_ID)
  references BARS.ADR_CITY_DISTRICTS (DISTRICT_ID);
alter table BARS.ADR_HOUSES
  add constraint FK_HOUSENUMS_STREETS foreign key (STREET_ID)
  references BARS.ADR_STREETS (STREET_ID);
-- Grant/Revoke object privileges 
grant select on BARS.ADR_HOUSES to BARSUPL;
grant select on BARS.ADR_HOUSES to FINMON01;
grant select on BARS.ADR_HOUSES to START1;
grant select on BARS.ADR_HOUSES to UPLD;
/;
