declare
    name_already_used exception;
    pragma exception_init(name_already_used, -955);
begin
    execute immediate
    'create table nbu_reported_object
     (
            id number(38),
            object_type_id number(5),
            state_id number(5),
            external_id varchar2(4000 byte)
     )
     tablespace brsmdld';
exception
    when name_already_used then
         null;
end;
/
alter table NBU_REPORTED_OBJECT
  add constraint XPK_NBU_REPORTED_OBJECT primary key (ID)
  using index 
  tablespace BRSDYND
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
/
