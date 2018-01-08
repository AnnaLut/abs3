


PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_NO_TURNOVER_LIST.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_NO_TURNOVER_LIST ***
begin 
  execute immediate '

create table PFU.PFU_NO_TURNOVER_LIST
(
  id          NUMBER(38),
  id_request  NUMBER(38),
  date_create DATE,
  date_sent   DATE,
  full_lines  NUMBER(38),
  user_id     NUMBER,
  state       VARCHAR2(20),
  kf          VARCHAR2(10)
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


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_NO_TURNOVER_LIST.sql =========*** E
PROMPT ===================================================================================== 