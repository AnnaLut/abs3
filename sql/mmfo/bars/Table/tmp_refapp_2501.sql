

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_REFAPP_2501.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_REFAPP_2501 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_REFAPP_2501 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_REFAPP_2501 
   (	TABID NUMBER(38,0), 
	CODEAPP VARCHAR2(30 CHAR), 
	ACODE VARCHAR2(8), 
	APPROVE NUMBER(1,0), 
	ADATE1 DATE, 
	ADATE2 DATE, 
	RDATE1 DATE, 
	RDATE2 DATE, 
	REVERSE NUMBER(1,0), 
	REVOKED NUMBER(1,0), 
	GRANTOR NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_REFAPP_2501 ***
 exec bpa.alter_policies('TMP_REFAPP_2501');


COMMENT ON TABLE BARS.TMP_REFAPP_2501 IS '';
COMMENT ON COLUMN BARS.TMP_REFAPP_2501.TABID IS '';
COMMENT ON COLUMN BARS.TMP_REFAPP_2501.CODEAPP IS '';
COMMENT ON COLUMN BARS.TMP_REFAPP_2501.ACODE IS '';
COMMENT ON COLUMN BARS.TMP_REFAPP_2501.APPROVE IS '';
COMMENT ON COLUMN BARS.TMP_REFAPP_2501.ADATE1 IS '';
COMMENT ON COLUMN BARS.TMP_REFAPP_2501.ADATE2 IS '';
COMMENT ON COLUMN BARS.TMP_REFAPP_2501.RDATE1 IS '';
COMMENT ON COLUMN BARS.TMP_REFAPP_2501.RDATE2 IS '';
COMMENT ON COLUMN BARS.TMP_REFAPP_2501.REVERSE IS '';
COMMENT ON COLUMN BARS.TMP_REFAPP_2501.REVOKED IS '';
COMMENT ON COLUMN BARS.TMP_REFAPP_2501.GRANTOR IS '';




PROMPT *** Create  constraint SYS_C00109342 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REFAPP_2501 MODIFY (TABID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109343 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REFAPP_2501 MODIFY (CODEAPP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00109344 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_REFAPP_2501 MODIFY (ACODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_REFAPP_2501 ***
grant SELECT                                                                 on TMP_REFAPP_2501 to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_REFAPP_2501 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_REFAPP_2501.sql =========*** End *
PROMPT ===================================================================================== 
