

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_REPLACEMENT_REQUEST.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_REPLACEMENT_REQUEST ***
begin 
  execute immediate '
create table PFU.PFU_REPLACEMENT_REQUEST
(
  id                  NUMBER(10),
  pfu_replacement_xml CLOB
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

comment on table PFU.PFU_REPLACEMENT_REQUEST is 'Запит на відправку повідомлення про зміну рахунку';
comment on column PFU.PFU_REPLACEMENT_REQUEST.pfu_replacement_xml is 'Повідомлення';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_REPLACEMENT_REQUEST.sql =========**
PROMPT ===================================================================================== 

