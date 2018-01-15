begin
    execute immediate 'create table MSP_ACC_REST
(
  acc      VARCHAR2(20),
  rest     NUMBER(38,2),
  restdate DATE,
  fileid   NUMBER(10)
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
    if sqlcode = -955 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the columns 
comment on column MSP_ACC_REST.acc
  is '���� 2909';
comment on column MSP_ACC_REST.rest
  is '�������';
comment on column MSP_ACC_REST.restdate
  is '���� �������';
comment on column MSP_ACC_REST.fileid
  is '����� � ��������';
-- Grant/Revoke object privileges 
grant select on MSP_ACC_REST to BARSREADER_ROLE;
