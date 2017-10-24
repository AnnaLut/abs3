

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_PARTNER_TYPE_SCANS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_PARTNER_TYPE_SCANS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_PARTNER_TYPE_SCANS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''INS_PARTNER_TYPE_SCANS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_PARTNER_TYPE_SCANS ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_PARTNER_TYPE_SCANS 
   (	ID NUMBER, 
	SCAN_ID VARCHAR2(100), 
	PARTNER_ID NUMBER, 
	TYPE_ID NUMBER, 
	IS_REQUIRED NUMBER DEFAULT 0
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_PARTNER_TYPE_SCANS ***
 exec bpa.alter_policies('INS_PARTNER_TYPE_SCANS');


COMMENT ON TABLE BARS.INS_PARTNER_TYPE_SCANS IS '������ﳿ �� �� ���� ��';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_SCANS.ID IS '�������������';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_SCANS.SCAN_ID IS '��� ������ﳿ';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_SCANS.PARTNER_ID IS '������������� ��';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_SCANS.TYPE_ID IS '������������� ���� ���������� ��������';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_SCANS.IS_REQUIRED IS '�����������';




PROMPT *** Create  constraint FK_PTNTYPESCNS_TID_TYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_SCANS ADD CONSTRAINT FK_PTNTYPESCNS_TID_TYPES FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.INS_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PTNTYPESCNS_PID_PARTNERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_SCANS ADD CONSTRAINT FK_PTNTYPESCNS_PID_PARTNERS FOREIGN KEY (PARTNER_ID)
	  REFERENCES BARS.INS_PARTNERS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PTNTYPESCNS_SID_SCANS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_SCANS ADD CONSTRAINT FK_PTNTYPESCNS_SID_SCANS FOREIGN KEY (SCAN_ID)
	  REFERENCES BARS.INS_SCANS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PTNTYPESCNS_ISREQ ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_SCANS ADD CONSTRAINT CC_PTNTYPESCNS_ISREQ CHECK (is_required in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_PTNTYPESCNS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_SCANS ADD CONSTRAINT UK_PTNTYPESCNS UNIQUE (SCAN_ID, PARTNER_ID, TYPE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PTNTYPESCNS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_SCANS ADD CONSTRAINT PK_PTNTYPESCNS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PTNTYPESCNS_ISREQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_SCANS MODIFY (IS_REQUIRED CONSTRAINT CC_PTNTYPESCNS_ISREQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PTNTYPESCNS_BRH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_SCANS MODIFY (SCAN_ID CONSTRAINT CC_PTNTYPESCNS_BRH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003101269 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_SCANS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PTNTYPESCNS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PTNTYPESCNS ON BARS.INS_PARTNER_TYPE_SCANS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_PTNTYPESCNS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_PTNTYPESCNS ON BARS.INS_PARTNER_TYPE_SCANS (SCAN_ID, PARTNER_ID, TYPE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_PARTNER_TYPE_SCANS.sql =========**
PROMPT ===================================================================================== 
