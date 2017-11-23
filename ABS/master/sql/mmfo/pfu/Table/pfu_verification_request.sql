

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_VERIFICATION_REQUEST.sql =========*
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_VERIFICATION_REQUEST ***
begin 
  execute immediate '
create table PFU.PFU_VERIFICATION_REQUEST
(
  id                  NUMBER(10) not null,
  pfu_verification_id NUMBER(10) not null,
  pfu_branch_code     VARCHAR2(300 CHAR),
  pfu_branch_name     VARCHAR2(300 CHAR),
  register_date       DATE,
  check_lines_count   NUMBER(38),
  crt_date            DATE default sysdate,
  files_data          CLOB,
  ecp_list            CLOB,
  verifylists         CLOB,
  state               VARCHAR2(30),
  zip_data            BLOB,
  userid              NUMBER(38)
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



comment on table PFU.PFU_VERIFICATION_REQUEST is 'Запит на отримання конверту з даними для зарахувань пенсій';
comment on column PFU.PFU_VERIFICATION_REQUEST.pfu_verification_id is 'Ідентифікатор конверту, отриманого в результаті виконання запиту на отримання конвертів';

begin
    execute immediate 'alter table PFU.PFU_VERIFICATION_REQUEST
  add constraint PK_PFU_VERIFICATION_REQUEST primary key (ID)
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
    execute immediate 'alter table PFU.PFU_VERIFICATION_REQUEST
  add constraint FK_VERIF_REQ_REF_REQUEST foreign key (ID)
  references PFU_REQUEST (ID)';
 exception when others then 
    if sqlcode = -2275 then null; else raise; 
    end if; 
end;
/ 


grant select on PFU.PFU_VERIFICATION_REQUEST to BARS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_VERIFICATION_REQUEST.sql =========*
PROMPT ===================================================================================== 

