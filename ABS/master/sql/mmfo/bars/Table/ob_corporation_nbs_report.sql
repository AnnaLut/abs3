

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OB_CORPORATION_NBS_REPORT.sql ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OB_CORPORATION_NBS_REPORT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OB_CORPORATION_NBS_REPORT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OB_CORPORATION_NBS_REPORT'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''OB_CORPORATION_NBS_REPORT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OB_CORPORATION_NBS_REPORT ***
begin 
  execute immediate '
  CREATE TABLE BARS.OB_CORPORATION_NBS_REPORT 
   (	ID NUMBER(5,0), 
	EXTERNAL_ID VARCHAR2(30 CHAR), 
	CORPORATION_NAME VARCHAR2(300 CHAR), 
	NBS CHAR(4), 
	REPORT_IN CHAR(1), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OB_CORPORATION_NBS_REPORT ***
 exec bpa.alter_policies('OB_CORPORATION_NBS_REPORT');


COMMENT ON TABLE BARS.OB_CORPORATION_NBS_REPORT IS '';
COMMENT ON COLUMN BARS.OB_CORPORATION_NBS_REPORT.ID IS '';
COMMENT ON COLUMN BARS.OB_CORPORATION_NBS_REPORT.EXTERNAL_ID IS '';
COMMENT ON COLUMN BARS.OB_CORPORATION_NBS_REPORT.CORPORATION_NAME IS '';
COMMENT ON COLUMN BARS.OB_CORPORATION_NBS_REPORT.NBS IS '';
COMMENT ON COLUMN BARS.OB_CORPORATION_NBS_REPORT.REPORT_IN IS '';
COMMENT ON COLUMN BARS.OB_CORPORATION_NBS_REPORT.KF IS '';




PROMPT *** Create  constraint SYS_C00110723 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION_NBS_REPORT MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OB_CORPNBSREPORT_YN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION_NBS_REPORT ADD CONSTRAINT CC_OB_CORPNBSREPORT_YN CHECK (REPORT_IN in (''Y'',''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OBCORPREPORTNBSKF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION_NBS_REPORT ADD CONSTRAINT PK_OBCORPREPORTNBSKF PRIMARY KEY (EXTERNAL_ID, NBS, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00110724 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION_NBS_REPORT MODIFY (NBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OBCORPREPORTNBSKF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OBCORPREPORTNBSKF ON BARS.OB_CORPORATION_NBS_REPORT (EXTERNAL_ID, NBS, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OB_CORPORATION_NBS_REPORT ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on OB_CORPORATION_NBS_REPORT to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OB_CORPORATION_NBS_REPORT.sql ========
PROMPT ===================================================================================== 
