exec BARS_POLICY_ADM.ALTER_POLICY_INFO('MBM_REL_CUST_VISA_STAMPS','WHOLE', null, null, null, null);
exec BARS_POLICY_ADM.ALTER_POLICY_INFO('MBM_REL_CUST_VISA_STAMPS','FILIAL', null, null, null, null);

begin
  execute immediate 
'CREATE TABLE MBM_REL_CUST_VISA_STAMPS
(
  REL_CUST_ID   NUMBER                           NOT NULL,
  VISA_ID     	NUMBER                           NOT NULL,
  USER_ID     	VARCHAR2(128),
  VISA_DATE   	DATE,
  KEY_ID      	VARCHAR2(200),
  SIGNATURE   	CLOB
)';
exception
  when others then if (sqlcode = -955) then null; else raise; end if;
end;
/

COMMENT ON TABLE MBM_REL_CUST_VISA_STAMPS IS 'Підписи профіля користувача до CorpLight';

grant all on MBM_REL_CUST_VISA_STAMPS to bars_access_defrole;