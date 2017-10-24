exec BARS_POLICY_ADM.ALTER_POLICY_INFO('MBM_ACSK_REGISTRATION','WHOLE', null, null, null, null);
exec BARS_POLICY_ADM.ALTER_POLICY_INFO('MBM_ACSK_REGISTRATION','FILIAL', null, null, null, null);

begin
  execute immediate 
'CREATE TABLE MBM_ACSK_REGISTRATION
(
  REGISTRATION_ID    NUMBER,
  REL_CUST_ID        NUMBER,
  ACSK_USER_ID       VARCHAR2(128),
  REGISTRATION_DATE  DATE           DEFAULT sysdate               NOT NULL
)';
exception
  when others then if (sqlcode = -955) then null; else raise; end if;
end;
/

begin   
 execute immediate '
  ALTER TABLE BARS.MBM_ACSK_REGISTRATION ADD CONSTRAINT PK_MBM_ACSK_REG_REG_ID PRIMARY KEY (REGISTRATION_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

begin   
 execute immediate '
  ALTER TABLE BARS.MBM_ACSK_REGISTRATION ADD FOREIGN KEY (REL_CUST_ID)
	  REFERENCES BARS.MBM_REL_CUSTOMERS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

begin   
 execute immediate '
  ALTER TABLE BARS.MBM_ACSK_REGISTRATION MODIFY (REL_CUST_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

COMMENT ON TABLE MBM_ACSK_REGISTRATION IS 'Зареєстровані в АЦСК клієнта';

grant all on MBM_ACSK_REGISTRATION to bars_access_defrole;