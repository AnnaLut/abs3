

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SWI_MTI_LIST.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SWI_MTI_LIST ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SWI_MTI_LIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_SWI_MTI_LIST 
   (	NUM NUMBER, 
	ID VARCHAR2(2), 
	NAME VARCHAR2(60), 
	DESCRIPTION VARCHAR2(256), 
	OB22_2909 CHAR(2), 
	OB22_2809 CHAR(2), 
	OB22_KOM CHAR(2), 
	CDOG VARCHAR2(20), 
	DDOG DATE, 
	KOD_NBU VARCHAR2(5)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SWI_MTI_LIST ***
 exec bpa.alter_policies('TMP_SWI_MTI_LIST');


COMMENT ON TABLE BARS.TMP_SWI_MTI_LIST IS '';
COMMENT ON COLUMN BARS.TMP_SWI_MTI_LIST.NUM IS '';
COMMENT ON COLUMN BARS.TMP_SWI_MTI_LIST.ID IS '';
COMMENT ON COLUMN BARS.TMP_SWI_MTI_LIST.NAME IS '';
COMMENT ON COLUMN BARS.TMP_SWI_MTI_LIST.DESCRIPTION IS '';
COMMENT ON COLUMN BARS.TMP_SWI_MTI_LIST.OB22_2909 IS '';
COMMENT ON COLUMN BARS.TMP_SWI_MTI_LIST.OB22_2809 IS '';
COMMENT ON COLUMN BARS.TMP_SWI_MTI_LIST.OB22_KOM IS '';
COMMENT ON COLUMN BARS.TMP_SWI_MTI_LIST.CDOG IS '';
COMMENT ON COLUMN BARS.TMP_SWI_MTI_LIST.DDOG IS '';
COMMENT ON COLUMN BARS.TMP_SWI_MTI_LIST.KOD_NBU IS '';




PROMPT *** Create  constraint SYS_C00119142 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SWI_MTI_LIST MODIFY (NUM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119143 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SWI_MTI_LIST MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119144 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SWI_MTI_LIST MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119145 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SWI_MTI_LIST MODIFY (DESCRIPTION NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119146 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SWI_MTI_LIST MODIFY (OB22_2909 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00119147 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SWI_MTI_LIST MODIFY (OB22_KOM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_SWI_MTI_LIST ***
grant SELECT                                                                 on TMP_SWI_MTI_LIST to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_SWI_MTI_LIST to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SWI_MTI_LIST.sql =========*** End 
PROMPT ===================================================================================== 
