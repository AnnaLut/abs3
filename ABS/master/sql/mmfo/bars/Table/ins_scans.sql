

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_SCANS.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_SCANS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_SCANS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''INS_SCANS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_SCANS ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_SCANS 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(300), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_SCANS ***
 exec bpa.alter_policies('INS_SCANS');


COMMENT ON TABLE BARS.INS_SCANS IS 'Сканкопії страхового договору';
COMMENT ON COLUMN BARS.INS_SCANS.KF IS '';
COMMENT ON COLUMN BARS.INS_SCANS.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.INS_SCANS.NAME IS 'Найменування';




PROMPT *** Create  constraint PK_INSSCANS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_SCANS ADD CONSTRAINT PK_INSSCANS PRIMARY KEY (ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0033342 ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_SCANS MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSSCANS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_SCANS MODIFY (NAME CONSTRAINT CC_INSSCANS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INSSCANS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INSSCANS ON BARS.INS_SCANS (ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INS_SCANS ***
grant SELECT                                                                 on INS_SCANS       to BARSREADER_ROLE;
grant SELECT                                                                 on INS_SCANS       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_SCANS.sql =========*** End *** ===
PROMPT ===================================================================================== 
