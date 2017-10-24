begin
  execute immediate 
'ALTER TABLE MBM_CUST_REL_USERS_MAP
 ADD FOREIGN KEY (REL_CUST_ID) 
  REFERENCES MBM_REL_CUSTOMERS (ID)
  ENABLE VALIDATE';
exception
  when others then if (sqlcode = -2275) then null; else raise; end if;
end;
/

begin
  execute immediate 
'ALTER TABLE MBM_CUST_REL_USERS_MAP
 ADD FOREIGN KEY (CUST_ID) 
  REFERENCES CUSTOMER (RNK)
  ENABLE VALIDATE';
exception
  when others then if (sqlcode = -2275) then null; else raise; end if;
end;
/

begin
  execute immediate 
'ALTER TABLE MBM_NBS_ACC_TYPES ADD (
  CONSTRAINT FK_MBM_NBSACCTYPES_TYPE 
  FOREIGN KEY (TYPE_ID) 
  REFERENCES MBM_ACC_TYPES (TYPE_ID)
  ENABLE VALIDATE)';
exception
  when others then if (sqlcode = -2275) then null; else raise; end if;
end;
/

begin
  execute immediate 
'ALTER TABLE MBM_REL_CUSTOMERS_ADDRESS ADD (
  FOREIGN KEY (REL_CUST_ID) 
  REFERENCES MBM_REL_CUSTOMERS (ID)
  ENABLE VALIDATE)';
exception
  when others then if (sqlcode = -2275) then null; else raise; end if;
end;
/

begin
  execute immediate 
'ALTER TABLE MBM_REL_CUST_VISA_STAMPS ADD (
  FOREIGN KEY (REL_CUST_ID) 
  REFERENCES MBM_REL_CUSTOMERS (ID)
  ENABLE VALIDATE)';
exception
  when others then if (sqlcode = -2275) then null; else raise; end if;
end;
/

begin
  execute immediate 
'ALTER TABLE MBM_ACSK_REGISTRATION ADD (
  FOREIGN KEY (REL_CUST_ID) 
  REFERENCES MBM_REL_CUSTOMERS (ID)
  ENABLE VALIDATE)';
exception
  when others then if (sqlcode = -2275) then null; else raise; end if;
end;
/
