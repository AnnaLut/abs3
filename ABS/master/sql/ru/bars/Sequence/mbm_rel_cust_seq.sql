begin
  execute immediate 
'CREATE SEQUENCE MBM_REL_CUST_SEQ
  START WITH 1
  MAXVALUE 9999999999
  MINVALUE 1
  NOCYCLE
  CACHE 20
  NOORDER';
exception
  when others then if (sqlcode = -955) then null; else raise; end if;
end;
/
  
GRANT SELECT ON MBM_REL_CUST_SEQ TO BARS_ACCESS_DEFROLE;