


PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_NO_TURNOVER_REQUEST.sql =========**
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_NO_TURNOVER_REQUEST ***
begin 
  execute immediate '
create table PFU.PFU_NO_TURNOVER_REQUEST
(
  id      NUMBER(10),
  pfu_xml CLOB
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

comment on table PFU.PFU_NO_TURNOVER_REQUEST is 'Запит на відправку квітанцій';
comment on column PFU.PFU_NO_TURNOVER_REQUEST.pfu_xml is 'Квитанция';

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_NO_TURNOVER_REQUEST.sql =========**
PROMPT ===================================================================================== 
