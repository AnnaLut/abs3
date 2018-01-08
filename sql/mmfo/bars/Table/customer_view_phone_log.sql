begin
BARS_POLICY_ADM.ALTER_POLICY_INFO('CUSTOMER_VIEW_PHONE_LOG','WHOLE', 'B', 'E', 'E','E'); 
end;
/

begin
BARS_POLICY_ADM.ALTER_POLICY_INFO('CUSTOMER_VIEW_PHONE_LOG','FILIAL', 'B', 'B', 'B','B'); 
end;
/

begin
execute immediate 'CREATE TABLE BARS.CUSTOMER_VIEW_PHONE_LOG(rnk number, date_post date, phone varchar2(50), branch varchar2(30), userid number, logname varchar2(30), fio varchar2(60)) tablespace BRSMDLD';
exception when others then if (sqlcode=-955) then null; else raise; end if;
end;
/

grant select, insert, update, delete on bars.customer_view_phone_log to bars_access_defrole
/

begin
execute immediate 'CREATE INDEX BARS.I_CUSTOMER_VIEW_PHONE_LOG ON BARS.CUSTOMER_VIEW_PHONE_LOG (DATE_POST, RNK) TABLESPACE BRSMDLI';
exception when others then if (sqlcode=-955) then null; else raise; end if;
end;
/


begin
execute immediate 'ALTER TABLE BARS.CUSTOMER_VIEW_PHONE_LOG ADD 
CONSTRAINT fk_customer_view_phone_log
 FOREIGN KEY (RNK)
 REFERENCES BARS.CUSTOMER (RNK)
 ENABLE
 VALIDATE';
exception when others then if (sqlcode=-2275) then null; else raise; end if;
end;
/




begin
BARS_POLICY_ADM.ALTER_POLICIES('CUSTOMER_VIEW_PHONE_LOG');
end;
/

COMMIT;
/ 