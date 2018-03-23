-- Create table
begin 
   execute immediate('create table TEST_IBX_XML
(
  ext_ref VARCHAR2(200),
  rq_clob CLOB,
  rs_clob CLOB
)
tablespace BRSDYND
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 128K
    next 128K
    minextents 1
    maxextents unlimited
    pctincrease 0
  )');
exception when others then 
if sqlcode = -955 then null;
else 
   dbms_output.put_line('INFO: code: '||sqlcode||', '||sqlerrm(sqlcode)||' with msg: ''oper: create table TEST_IBX_XML'); 
end if;
end;
/

