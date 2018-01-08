

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML_GATE_RECEIPT.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML_GATE_RECEIPT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XML_GATE_RECEIPT'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''XML_GATE_RECEIPT'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''XML_GATE_RECEIPT'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML_GATE_RECEIPT ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML_GATE_RECEIPT 
   (	ID NUMBER, 
	PARTITION NUMBER, 
	XML_O CLOB, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD 
 LOB (XML_O) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XML_GATE_RECEIPT ***
 exec bpa.alter_policies('XML_GATE_RECEIPT');


COMMENT ON TABLE BARS.XML_GATE_RECEIPT IS '“аблица исход€щих сообщений от клиент-банка';
COMMENT ON COLUMN BARS.XML_GATE_RECEIPT.ID IS '';
COMMENT ON COLUMN BARS.XML_GATE_RECEIPT.PARTITION IS '';
COMMENT ON COLUMN BARS.XML_GATE_RECEIPT.XML_O IS '';
COMMENT ON COLUMN BARS.XML_GATE_RECEIPT.KF IS '';




PROMPT *** Create  constraint PK_XML_GATE_RECEIPT ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_GATE_RECEIPT ADD CONSTRAINT PK_XML_GATE_RECEIPT PRIMARY KEY (ID, PARTITION)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_XML_GATE_RECEIPT_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_GATE_RECEIPT ADD CONSTRAINT FK_XML_GATE_RECEIPT_ID FOREIGN KEY (ID)
	  REFERENCES BARS.XML_GATE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_XMLGATERECEIPT_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_GATE_RECEIPT ADD CONSTRAINT FK_XMLGATERECEIPT_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010309 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_GATE_RECEIPT MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010310 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_GATE_RECEIPT MODIFY (PARTITION NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010311 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_GATE_RECEIPT MODIFY (XML_O NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_XMLGATERECEIPT_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_GATE_RECEIPT MODIFY (KF CONSTRAINT CC_XMLGATERECEIPT_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_XML_GATE_RECEIPT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_XML_GATE_RECEIPT ON BARS.XML_GATE_RECEIPT (ID, PARTITION) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XML_GATE_RECEIPT ***
grant SELECT                                                                 on XML_GATE_RECEIPT to BARS_DM;
grant SELECT                                                                 on XML_GATE_RECEIPT to KLBX;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on XML_GATE_RECEIPT to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML_GATE_RECEIPT.sql =========*** End 
PROMPT ===================================================================================== 
