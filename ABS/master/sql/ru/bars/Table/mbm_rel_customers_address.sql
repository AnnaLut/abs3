exec BARS_POLICY_ADM.ALTER_POLICY_INFO('MBM_REL_CUSTOMERS_ADDRESS','WHOLE', null, null, null, null);
exec BARS_POLICY_ADM.ALTER_POLICY_INFO('MBM_REL_CUSTOMERS_ADDRESS','FILIAL', null, null, null, null);

begin
  execute immediate 
'CREATE TABLE MBM_REL_CUSTOMERS_ADDRESS
(
  REL_CUST_ID   NUMBER                          NOT NULL,
  REGION_ID     NUMBER,
  CITY          VARCHAR2(200),
  STREET        VARCHAR2(500),
  HOUSE_NUMBER  VARCHAR2(100),
  ADDITION      VARCHAR2(4000)
)';
exception
  when others then if (sqlcode = -955) then null; else raise; end if;
end;
/

COMMENT ON TABLE MBM_REL_CUSTOMERS_ADDRESS IS 'Адреси повязаних осіб котрим надано доступ до CorpLight';

grant all on MBM_REL_CUSTOMERS_ADDRESS to bars_access_defrole;