

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_ACC_2560_PAYBACK.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_ACC_2560_PAYBACK ***
begin 
  execute immediate '
create table PFU_ACC_2560_PAYBACK
(
  acc_num VARCHAR2(20),
  kf      VARCHAR2(10),
  edrpu   VARCHAR2(10)
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
  )';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

-- Add comments to the table 
comment on table PFU_ACC_2560_PAYBACK is 'Рахунки для повернення грошей  в ПФУ';

begin
    execute immediate 'alter table PFU_ACC_2560_PAYBACK
						  add constraint PK_PFU_ACC_2560_PAYBACK primary key (KF)
						  using index 
						  tablespace BRSBIGI
						  pctfree 10
						  initrans 2
						  maxtrans 255
						  storage
						  (
							initial 64K
							minextents 1
							maxextents unlimited
						  )';
 exception when others then 
    if sqlcode = -2261 or sqlcode = -2260 then null; else raise; 
    end if; 
end;
/ 

PROMPT ===================================================================================== 
PROMPT *** END *** ========== Scripts /Sql/PFU/Table/PFU_ACC_2560_PAYBACK.sql =========*** END
PROMPT ===================================================================================== 
