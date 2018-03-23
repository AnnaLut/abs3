begin
    execute immediate 'CREATE INDEX BARS.I1_NBUR_KOR_BALANCES ON BARS.NBUR_KOR_BALANCES
(REPORT_DATE, KF, ACC_ID, ACC_TYPE)
LOGGING
TABLESPACE BRSDYND';
 exception when others then 
    if sqlcode = -955 or sqlcode = -1408 then null; else raise; 
    end if; 
end;
/


