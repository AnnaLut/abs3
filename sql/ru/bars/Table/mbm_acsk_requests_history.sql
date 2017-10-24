exec BARS_POLICY_ADM.ALTER_POLICY_INFO('MBM_ACSK_REQUESTS_HISTORY','WHOLE', null, null, null, null);
exec BARS_POLICY_ADM.ALTER_POLICY_INFO('MBM_ACSK_REQUESTS_HISTORY','FILIAL', null, null, null, null);

begin
  execute immediate 
'CREATE TABLE MBM_ACSK_REQUESTS_HISTORY
(
  NONCE             VARCHAR2(128),
  REQUEST_DATE      DATE                        NOT NULL,
  REQUEST_BODY      CLOB,
  RESPONSE_DATE     DATE,
  RESPONSE_CODE     VARCHAR2(100),
  RESPONSE_MESSAGE  VARCHAR2(4000)
)';
exception
  when others then if (sqlcode = -955) then null; else raise; end if;
end;
/

begin   
 execute immediate '
  ALTER TABLE BARS.MBM_ACSK_REQUESTS_HISTORY ADD CONSTRAINT PK_MBM_ACSK_REQ_HIST_PK PRIMARY KEY (NONCE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

COMMENT ON TABLE MBM_ACSK_REQUESTS_HISTORY IS 'Історія звернень до АЦСК';

grant all on MBM_ACSK_REQUESTS_HISTORY to bars_access_defrole;