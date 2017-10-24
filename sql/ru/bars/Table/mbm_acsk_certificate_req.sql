exec BARS_POLICY_ADM.ALTER_POLICY_INFO('MBM_ACSK_CERTIFICATE_REQ','WHOLE', null, null, null, null);
exec BARS_POLICY_ADM.ALTER_POLICY_INFO('MBM_ACSK_CERTIFICATE_REQ','FILIAL', null, null, null, null);

begin
  execute immediate 
'CREATE TABLE MBM_ACSK_CERTIFICATE_REQ
(
  ID   					NUMBER PRIMARY KEY,
  REL_CUST_ID			NUMBER,
  REQUEST_TIME  		DATE,
  REQUEST_STATE 		NUMBER,
  REQUEST_STATE_MESSAGE VARCHAR2(4000),
  CERTIFICATE_SN 		VARCHAR2(200),
  TEMPLATE_NAME         VARCHAR2(400),
  TEMPLATE_OID			VARCHAR2(200),
  CERTIFICATE_ID		VARCHAR2(200),		
  CERTIFICATE_BODY      CLOB,
  REVOKE_CODE			NUMBER,
  TOKEN_SN				VARCHAR2(200),
  TOKEN_NAME			VARCHAR2(400) 
)';
exception
  when others then if (sqlcode = -955) then null; else raise; end if;
end;
/

COMMENT ON TABLE MBM_ACSK_CERTIFICATE_REQ IS 'Довідник запитів на сертифікати АЦСК';

grant all on MBM_ACSK_CERTIFICATE_REQ to bars_access_defrole;