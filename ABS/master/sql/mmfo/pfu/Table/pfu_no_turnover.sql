


PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_NO_TURNOVER.sql =========*** RUN **
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_NO_TURNOVER ***
begin 
  execute immediate '
create table PFU.PFU_NO_TURNOVER
(
  id          NUMBER(38),
  id_file     NUMBER(38),
  last_name   VARCHAR2(70),
  name        VARCHAR2(70),
  father_name VARCHAR2(70),
  okpo        VARCHAR2(20),
  ser_num     VARCHAR2(20),
  num_acc     VARCHAR2(20),
  kf          VARCHAR2(6),
  date_last   DATE
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

comment on table PFU.PFU_NO_TURNOVER is 'Список пенсионеров, по которым не было дебетового движения';



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_NO_TURNOVER.sql =========*** END **
PROMPT ===================================================================================== 

