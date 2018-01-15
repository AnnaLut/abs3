begin
    execute immediate 'create table MSP_ACC_TRANS_2909
(
  acc_num VARCHAR2(20),
  kf      VARCHAR2(10),
  edrpu   VARCHAR2(10)
)
tablespace BRSSMLD
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
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the table 
comment on table MSP_ACC_TRANS_2909
  is '������� ���������� ������� 2909';
-- Grant/Revoke object privileges 
grant select on MSP_ACC_TRANS_2909 to BARS;
grant select on MSP_ACC_TRANS_2909 to BARSREADER_ROLE;
grant select, insert, update, delete on MSP_ACC_TRANS_2909 to BARS_ACCESS_DEFROLE;
