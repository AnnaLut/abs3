begin
    execute immediate 
	'ALTER TABLE MBM_CUST_REL_USERS_MAP
		ADD FOREIGN KEY (REL_CUST_ID) 
		REFERENCES MBM_REL_CUSTOMERS (ID)
		ENABLE VALIDATE';
 exception when others then 
    if sqlcode = -02275 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 
	'ALTER TABLE MBM_CUST_REL_USERS_MAP
		ADD FOREIGN KEY (CUST_ID) 
		REFERENCES CUSTOMER (RNK)
		ENABLE VALIDATE';
 exception when others then 
    if sqlcode = -02275 then null; else raise; 
    end if; 
end;
/ 
