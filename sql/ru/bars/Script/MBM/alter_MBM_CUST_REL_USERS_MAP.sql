begin
    execute immediate 
    'ALTER TABLE MBM_CUST_REL_USERS_MAP
        ADD (IS_APPROVED  NUMBER)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

begin
    execute immediate 
    'ALTER TABLE MBM_CUST_REL_USERS_MAP
		ADD (approved_type  VARCHAR2(100))';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

COMMENT ON COLUMN MBM_CUST_REL_USERS_MAP.is_approved IS 'Признак чи підтверджено зміни бек офісом';
COMMENT ON COLUMN MBM_CUST_REL_USERS_MAP.approved_type IS 'Тип змін, що потрібно підтвердити';