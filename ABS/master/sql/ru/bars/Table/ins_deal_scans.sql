

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_DEAL_SCANS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_DEAL_SCANS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_DEAL_SCANS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''INS_DEAL_SCANS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_DEAL_SCANS ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_DEAL_SCANS 
   (	DEAL_ID NUMBER, 
	SCAN_ID VARCHAR2(100), 
	VAL BLOB
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD 
 LOB (VAL) STORE AS BASICFILE (
  TABLESPACE BRSBIGD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_DEAL_SCANS ***
 exec bpa.alter_policies('INS_DEAL_SCANS');


COMMENT ON TABLE BARS.INS_DEAL_SCANS IS '������ﳿ �������� �����������';
COMMENT ON COLUMN BARS.INS_DEAL_SCANS.DEAL_ID IS 'id ��������';
COMMENT ON COLUMN BARS.INS_DEAL_SCANS.SCAN_ID IS 'id ������ﳿ';
COMMENT ON COLUMN BARS.INS_DEAL_SCANS.VAL IS '�������� ������ﳿ';




PROMPT *** Create  constraint FK_INSDLSSCNS_DEALTAGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEAL_SCANS ADD CONSTRAINT FK_INSDLSSCNS_DEALTAGS FOREIGN KEY (SCAN_ID)
	  REFERENCES BARS.INS_SCANS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSDLSSCNS_INSDEALS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEAL_SCANS ADD CONSTRAINT FK_INSDLSSCNS_INSDEALS FOREIGN KEY (DEAL_ID)
	  REFERENCES BARS.INS_DEALS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_INSDLSSCNS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEAL_SCANS ADD CONSTRAINT PK_INSDLSSCNS PRIMARY KEY (DEAL_ID, SCAN_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSDLSSCNS_VALUE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEAL_SCANS MODIFY (VAL CONSTRAINT CC_INSDLSSCNS_VALUE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSDLSSCNS_SID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEAL_SCANS MODIFY (SCAN_ID CONSTRAINT CC_INSDLSSCNS_SID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSDLSSCNS_DID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_DEAL_SCANS MODIFY (DEAL_ID CONSTRAINT CC_INSDLSSCNS_DID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INSDLSSCNS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INSDLSSCNS ON BARS.INS_DEAL_SCANS (DEAL_ID, SCAN_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_DEAL_SCANS.sql =========*** End **
PROMPT ===================================================================================== 
