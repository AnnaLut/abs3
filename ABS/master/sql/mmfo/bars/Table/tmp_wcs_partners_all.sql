

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_WCS_PARTNERS_ALL.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_WCS_PARTNERS_ALL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_WCS_PARTNERS_ALL ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_WCS_PARTNERS_ALL 
   (	ID NUMBER, 
	NAME VARCHAR2(255), 
	TYPE_ID VARCHAR2(100), 
	BRANCH VARCHAR2(30), 
	PTN_MFO VARCHAR2(12), 
	PTN_NLS VARCHAR2(15), 
	PTN_OKPO VARCHAR2(14), 
	PTN_NAME VARCHAR2(38), 
	ID_MATHER NUMBER, 
	FLAG_A NUMBER(1,0), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_WCS_PARTNERS_ALL ***
 exec bpa.alter_policies('TMP_WCS_PARTNERS_ALL');


COMMENT ON TABLE BARS.TMP_WCS_PARTNERS_ALL IS '';
COMMENT ON COLUMN BARS.TMP_WCS_PARTNERS_ALL.ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_PARTNERS_ALL.NAME IS '';
COMMENT ON COLUMN BARS.TMP_WCS_PARTNERS_ALL.TYPE_ID IS '';
COMMENT ON COLUMN BARS.TMP_WCS_PARTNERS_ALL.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_WCS_PARTNERS_ALL.PTN_MFO IS '';
COMMENT ON COLUMN BARS.TMP_WCS_PARTNERS_ALL.PTN_NLS IS '';
COMMENT ON COLUMN BARS.TMP_WCS_PARTNERS_ALL.PTN_OKPO IS '';
COMMENT ON COLUMN BARS.TMP_WCS_PARTNERS_ALL.PTN_NAME IS '';
COMMENT ON COLUMN BARS.TMP_WCS_PARTNERS_ALL.ID_MATHER IS '';
COMMENT ON COLUMN BARS.TMP_WCS_PARTNERS_ALL.FLAG_A IS '';
COMMENT ON COLUMN BARS.TMP_WCS_PARTNERS_ALL.KF IS '';




PROMPT *** Create  constraint SYS_C00132471 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_PARTNERS_ALL MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132472 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_PARTNERS_ALL MODIFY (TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00132473 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_WCS_PARTNERS_ALL MODIFY (FLAG_A NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_WCS_PARTNERS_ALL ***
grant SELECT                                                                 on TMP_WCS_PARTNERS_ALL to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_WCS_PARTNERS_ALL.sql =========*** 
PROMPT ===================================================================================== 
