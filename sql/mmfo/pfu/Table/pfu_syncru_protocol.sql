

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/PFU/Table/PFU_SYNCRU_PROTOCOL.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** Create  table PFU_SYNCRU_PROTOCOL ***
begin 
  execute immediate '
  CREATE TABLE PFU.PFU_SYNCRU_PROTOCOL 
   (	ID NUMBER, 
	KF VARCHAR2(6), 
	URL VARCHAR2(100), 
	TRANSFER_TYPE VARCHAR2(20), 
	TRANSFER_DATE_START DATE, 
	TRANSFER_DATE_END DATE, 
	TRANSFER_ROWS NUMBER, 
	TRANSFER_RESULT VARCHAR2(20), 
	COMM VARCHAR2(4000)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE PFU.PFU_SYNCRU_PROTOCOL IS '';
COMMENT ON COLUMN PFU.PFU_SYNCRU_PROTOCOL.ID IS '';
COMMENT ON COLUMN PFU.PFU_SYNCRU_PROTOCOL.KF IS '';
COMMENT ON COLUMN PFU.PFU_SYNCRU_PROTOCOL.URL IS '';
COMMENT ON COLUMN PFU.PFU_SYNCRU_PROTOCOL.TRANSFER_TYPE IS '';
COMMENT ON COLUMN PFU.PFU_SYNCRU_PROTOCOL.TRANSFER_DATE_START IS '';
COMMENT ON COLUMN PFU.PFU_SYNCRU_PROTOCOL.TRANSFER_DATE_END IS '';
COMMENT ON COLUMN PFU.PFU_SYNCRU_PROTOCOL.TRANSFER_ROWS IS '';
COMMENT ON COLUMN PFU.PFU_SYNCRU_PROTOCOL.TRANSFER_RESULT IS '';
COMMENT ON COLUMN PFU.PFU_SYNCRU_PROTOCOL.COMM IS '';




PROMPT *** Create  constraint SYS_C00111444 ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_SYNCRU_PROTOCOL MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PFUSYNCRUPROTOCOL ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_SYNCRU_PROTOCOL ADD CONSTRAINT PK_PFUSYNCRUPROTOCOL PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PFUSYNCRUPROT_TRDSTART_NN ***
begin   
 execute immediate '
  ALTER TABLE PFU.PFU_SYNCRU_PROTOCOL ADD CONSTRAINT CC_PFUSYNCRUPROT_TRDSTART_NN CHECK (TRANSFER_DATE_START IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_PFUSYNCRUPROTOCOL ***
begin   
 execute immediate '
  CREATE INDEX PFU.I1_PFUSYNCRUPROTOCOL ON PFU.PFU_SYNCRU_PROTOCOL (KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PFUSYNCRUPROTOCOL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX PFU.PK_PFUSYNCRUPROTOCOL ON PFU.PFU_SYNCRU_PROTOCOL (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PFU_SYNCRU_PROTOCOL ***
grant SELECT                                                                 on PFU_SYNCRU_PROTOCOL to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PFU_SYNCRU_PROTOCOL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PFU_SYNCRU_PROTOCOL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/PFU/Table/PFU_SYNCRU_PROTOCOL.sql =========*** En
PROMPT ===================================================================================== 
