

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_PARTNER_TYPE_ATTRS.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_PARTNER_TYPE_ATTRS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_PARTNER_TYPE_ATTRS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''INS_PARTNER_TYPE_ATTRS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_PARTNER_TYPE_ATTRS ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_PARTNER_TYPE_ATTRS 
   (	ID NUMBER, 
	ATTR_ID VARCHAR2(100), 
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




PROMPT *** ALTER_POLICIES to INS_PARTNER_TYPE_ATTRS ***
 exec bpa.alter_policies('INS_PARTNER_TYPE_ATTRS');


COMMENT ON TABLE BARS.INS_PARTNER_TYPE_ATTRS IS 'Атрибути СК та типів СД';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_ATTRS.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_ATTRS.ATTR_ID IS 'Код атрибуту';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_ATTRS.PARTNER_ID IS 'Ідентифікатор СК';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_ATTRS.TYPE_ID IS 'Ідентифікатор типу страхового договору';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_ATTRS.IS_REQUIRED IS 'Обовязковий';
COMMENT ON COLUMN BARS.INS_PARTNER_TYPE_ATTRS.KF IS '';




PROMPT *** Create  constraint SYS_C0033359 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_ATTRS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PTNTYPEATTRS_BRH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_ATTRS MODIFY (ATTR_ID CONSTRAINT CC_PTNTYPEATTRS_BRH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PTNTYPEATTRS_ISREQ_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_ATTRS MODIFY (IS_REQUIRED CONSTRAINT CC_PTNTYPEATTRS_ISREQ_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PTNTYPEATTRS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_ATTRS ADD CONSTRAINT PK_PTNTYPEATTRS PRIMARY KEY (ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_PTNTYPEATTRS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_ATTRS ADD CONSTRAINT UK_PTNTYPEATTRS UNIQUE (ATTR_ID, PARTNER_ID, TYPE_ID, ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PTNTYPEATTRS_ISREQ ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNER_TYPE_ATTRS ADD CONSTRAINT CC_PTNTYPEATTRS_ISREQ CHECK (is_required in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PTNTYPEATTRS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PTNTYPEATTRS ON BARS.INS_PARTNER_TYPE_ATTRS (ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_PTNTYPEATTRS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_PTNTYPEATTRS ON BARS.INS_PARTNER_TYPE_ATTRS (ATTR_ID, PARTNER_ID, TYPE_ID, ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INS_PARTNER_TYPE_ATTRS ***
grant SELECT                                                                 on INS_PARTNER_TYPE_ATTRS to BARSREADER_ROLE;
grant SELECT                                                                 on INS_PARTNER_TYPE_ATTRS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_PARTNER_TYPE_ATTRS.sql =========**
PROMPT ===================================================================================== 
