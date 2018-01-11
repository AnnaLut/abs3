

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_PARTNER_TYPE_SCANS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_PARTNER_TYPE_SCANS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_PARTNER_TYPE_SCANS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
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
	IS_REQUIRED NUMBER DEFAULT 0, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_PARTNER_TYPE_SCANS ***
 exec bpa.alter_policies('INS_PARTNER_TYPE_SCANS');


COMMENT ON TABLE BARS.INS_PARTNER_TYPE_SCANS IS 'Сканкопії СК та типів СД';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_SCANS.KF IS '';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_SCANS.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_SCANS.SCAN_ID IS 'Код сканкопії';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_SCANS.PARTNER_ID IS 'Ідентифікатор СК';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_SCANS.TYPE_ID IS 'Ідентифікатор типу страхового договору';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_SCANS.IS_REQUIRED IS 'Обовязковий';




PROMPT *** Create  constraint PK_PTNTYPESCNS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_SCANS ADD CONSTRAINT PK_PTNTYPESCNS PRIMARY KEY (ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_PTNTYPESCNS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_SCANS ADD CONSTRAINT UK_PTNTYPESCNS UNIQUE (SCAN_ID, PARTNER_ID, TYPE_ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0033386 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_SCANS MODIFY (ID NOT NULL ENABLE)';
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




PROMPT *** Create  constraint CC_PTNTYPESCNS_ISREQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_SCANS MODIFY (IS_REQUIRED CONSTRAINT CC_PTNTYPESCNS_ISREQ_NN NOT NULL ENABLE)';
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




PROMPT *** Create  index PK_PTNTYPESCNS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PTNTYPESCNS ON BARS.INS_PARTNER_TYPE_SCANS (ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_PTNTYPESCNS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_PTNTYPESCNS ON BARS.INS_PARTNER_TYPE_SCANS (SCAN_ID, PARTNER_ID, TYPE_ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INS_PARTNER_TYPE_SCANS ***
grant SELECT                                                                 on INS_PARTNER_TYPE_SCANS to BARSREADER_ROLE;
grant SELECT                                                                 on INS_PARTNER_TYPE_SCANS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_PARTNER_TYPE_SCANS.sql =========**
PROMPT ===================================================================================== 
