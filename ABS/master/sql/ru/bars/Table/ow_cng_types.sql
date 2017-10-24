prompt --------------------------------------------------------------------------------
prompt  создание таблицы OW_CNG_TYPES, ее наполнение
prompt ---------------------------------------------------------------------------------
/
begin
  execute immediate 'begin bpa.alter_policy_info(''ow_cng_types'', ''WHOLE'',  null, ''E'', ''E'', ''E''); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/
begin
  execute immediate 'begin bpa.alter_policy_info(''ow_cng_types'', ''FILIAL'', ''M'', ''M'', ''M'', ''M''); end;';
exception when others then
  if sqlcode = -06550 then null; else raise; end if;
end;
/
begin 
  execute immediate '
create table ow_cng_types
(
   id        number,
   nbs_ow    varchar2 (15) CONSTRAINT CC_OWCNGTYPES_NBS_OW_NN NOT NULL,
   nbs       varchar2 (15),
   descr     varchar2 (4000)
)';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
commit;
/
grant select, insert, update, delete on ow_cng_types to bars_access_defrole;
/
begin 
  execute immediate '
CREATE UNIQUE INDEX BARS.PK_OWCNGTYPES ON BARS.OW_CNG_TYPES(NBS_OW)';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/
begin 
  execute immediate '
ALTER TABLE BARS.OW_CNG_types ADD (
  CONSTRAINT PK_OWCNGTYPES
  PRIMARY KEY
  (NBS_OW)
  USING INDEX BARS.PK_OWCNGTYPES
  ENABLE VALIDATE)
';
exception when others then       
  if sqlcode=-2275 or sqlcode=-2260 or sqlcode=-2261 then null; else raise; end if; 
end;
/

create or replace trigger TBI_ow_cng_types
  before insert on BARS.ow_cng_types
  for each row
  begin
   select bars_sqnc.get_nextval('S_OW_CNG_TYPES') into :new.id from dual;
end;
/


begin 
    begin 
    insert into ow_cng_types(nbs_ow,nbs,descr) values('NLS_639709','','Пеня');
    exception when others then       
      if sqlcode=-911 or sqlcode=-001 then null; else raise; end if; 
    end;
insert into ow_cng_types(nbs_ow,nbs,descr) values('NLS_TRANS','W4_ARSUM','Арештовані рахунки (відповідний параметр в картці рахунку)');
insert into ow_cng_types(nbs_ow,nbs,descr) values('NLS_2202','ACC_OVR','');
insert into ow_cng_types(nbs_ow,nbs,descr) values('NLS_2203','ACC_OVR','');
insert into ow_cng_types(nbs_ow,nbs,descr) values('NLS_2207','ACC_2207','');
insert into ow_cng_types(nbs_ow,nbs,descr) values('NLS_2208','ACC_2208','');
insert into ow_cng_types(nbs_ow,nbs,descr) values('NLS_2209','ACC_2209','');
insert into ow_cng_types(nbs_ow,nbs,descr) values('NLS_2607','','');
insert into ow_cng_types(nbs_ow,nbs,descr) values('NLS_2625D','ACC_2625D','Рахунки мобільних заощаджень 2625');
insert into ow_cng_types(nbs_ow,nbs,descr) values('NLS_2627','ACC_2627','');
insert into ow_cng_types(nbs_ow,nbs,descr) values('NLS_2627X','ACC_2627X','');
insert into ow_cng_types(nbs_ow,nbs,descr) values('NLS_2628','ACC_2628','');
insert into ow_cng_types(nbs_ow,nbs,descr) values('NLS_2657','','');
insert into ow_cng_types(nbs_ow,nbs,descr) values('NLS_290005','','');
insert into ow_cng_types(nbs_ow,nbs,descr) values('NLS_3570','ACC_3570','');
insert into ow_cng_types(nbs_ow,nbs,descr) values('NLS_3579','ACC_3579','');
insert into ow_cng_types(nbs_ow,nbs,descr) values('NLS_9129','ACC_9129','');
insert into ow_cng_types(nbs_ow,nbs,descr) values('NLS_9900','','');
insert into ow_cng_types(nbs_ow,nbs,descr) values('2520','ACC_PK','');
insert into ow_cng_types(nbs_ow,nbs,descr) values('2541','ACC_PK','');
insert into ow_cng_types(nbs_ow,nbs,descr) values('2542','ACC_PK','');
insert into ow_cng_types(nbs_ow,nbs,descr) values('2605','ACC_PK','');
insert into ow_cng_types(nbs_ow,nbs,descr) values('2625','ACC_PK','');
insert into ow_cng_types(nbs_ow,nbs,descr) values('2628','ACC_PK','');
insert into ow_cng_types(nbs_ow,nbs,descr) values('2655','ACC_PK','');
insert into ow_cng_types(nbs_ow,nbs,descr) values('3550','ACC_PK','');
insert into ow_cng_types(nbs_ow,nbs,descr) values('3551','ACC_PK','');
insert into ow_cng_types(nbs_ow,nbs,descr) values('9999','','Технічні рахунки WAY4, в АБС не відвантажуються');
insert into ow_cng_types(nbs_ow,nbs,descr) values('9999D','','Технічні рахунки WAY4, в АБС не відвантажуються');   
exception when others then       
  if sqlcode=-911 or sqlcode=-001 then null; else raise; end if; 
end;
/