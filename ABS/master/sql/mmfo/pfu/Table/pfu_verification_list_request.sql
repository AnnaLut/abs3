

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_VERIFICATION_LIST_REQUEST.sql =====
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_VERIFICATION_LIST_REQUEST ***
begin 
  execute immediate '
create table PFU.PFU_VERIFICATION_LIST_REQUEST
(
  id        NUMBER(10) not null,
  date_from DATE not null,
  date_to   DATE not null,
  set_date  DATE default sysdate
)
tablespace BRSBIGD
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

comment on table PFU.PFU_VERIFICATION_LIST_REQUEST is 'Запити на отримання списків на верификацію';


begin
    execute immediate 'alter table PFU.PFU_VERIFICATION_LIST_REQUEST
  add constraint PK_PFU_VERIF_LIST_REQUEST primary key (ID)
  using index 
  tablespace BRSBIGD
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  )';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table PFU.PFU_VERIFICATION_LIST_REQUEST
  add constraint FK_VER_LIST_REF_REQUEST foreign key (ID)
  references PFU.PFU_REQUEST (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_VERIFICATION_LIST_REQUEST.sql =====
PROMPT ===================================================================================== 
