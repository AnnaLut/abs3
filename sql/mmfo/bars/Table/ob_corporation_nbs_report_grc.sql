

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OB_CORPORATION_NBS_REPORT_GRC.sql ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OB_CORPORATION_NBS_REPORT_GRC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OB_CORPORATION_NBS_REPORT_GRC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OB_CORPORATION_NBS_REPORT_GRC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OB_CORPORATION_NBS_REPORT_GRC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OB_CORPORATION_NBS_REPORT_GRC ***
begin 
  execute immediate '
  CREATE TABLE BARS.OB_CORPORATION_NBS_REPORT_GRC 
   (	ID NUMBER(5,0), 
	EXTERNAL_ID VARCHAR2(30 CHAR), 
	CORPORATION_NAME VARCHAR2(300 CHAR), 
	NBS CHAR(4), 
	REPORT_IN CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OB_CORPORATION_NBS_REPORT_GRC ***
 exec bpa.alter_policies('OB_CORPORATION_NBS_REPORT_GRC');


COMMENT ON TABLE BARS.OB_CORPORATION_NBS_REPORT_GRC IS '';
COMMENT ON COLUMN BARS.OB_CORPORATION_NBS_REPORT_GRC.ID IS '';
COMMENT ON COLUMN BARS.OB_CORPORATION_NBS_REPORT_GRC.EXTERNAL_ID IS '';
COMMENT ON COLUMN BARS.OB_CORPORATION_NBS_REPORT_GRC.CORPORATION_NAME IS '';
COMMENT ON COLUMN BARS.OB_CORPORATION_NBS_REPORT_GRC.NBS IS '';
COMMENT ON COLUMN BARS.OB_CORPORATION_NBS_REPORT_GRC.REPORT_IN IS '';




PROMPT *** Create  constraint SYS_C00110727 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION_NBS_REPORT_GRC MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OBCORPREPORTNBSGRC ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION_NBS_REPORT_GRC ADD CONSTRAINT PK_OBCORPREPORTNBSGRC PRIMARY KEY (EXTERNAL_ID, NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00110728 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OB_CORPORATION_NBS_REPORT_GRC MODIFY (NBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OBCORPREPORTNBSGRC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OBCORPREPORTNBSGRC ON BARS.OB_CORPORATION_NBS_REPORT_GRC (EXTERNAL_ID, NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OBCORPREPORTNBNBS ***
begin   
 execute immediate '
  CREATE INDEX BARS.PK_OBCORPREPORTNBNBS ON BARS.OB_CORPORATION_NBS_REPORT_GRC (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OBCORPREPORTNBEX ***
begin   
 execute immediate '
  CREATE INDEX BARS.PK_OBCORPREPORTNBEX ON BARS.OB_CORPORATION_NBS_REPORT_GRC (EXTERNAL_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OB_CORPORATION_NBS_REPORT_GRC ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on OB_CORPORATION_NBS_REPORT_GRC to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OB_CORPORATION_NBS_REPORT_GRC.sql ====
PROMPT ===================================================================================== 
