

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_APP_REP.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_APP_REP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_APP_REP ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_APP_REP 
   (	CODEAPP CHAR(4), 
	CODEREP NUMBER(38,0), 
	APPROVE NUMBER(1,0), 
	ADATE1 DATE, 
	ADATE2 DATE, 
	RDATE1 DATE, 
	RDATE2 DATE, 
	REVERSE NUMBER(1,0), 
	REVOKED NUMBER(1,0), 
	GRANTOR NUMBER(38,0), 
	ACODE VARCHAR2(8)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_APP_REP ***
 exec bpa.alter_policies('TMP_APP_REP');


COMMENT ON TABLE BARS.TMP_APP_REP IS '';
COMMENT ON COLUMN BARS.TMP_APP_REP.CODEAPP IS '';
COMMENT ON COLUMN BARS.TMP_APP_REP.CODEREP IS '';
COMMENT ON COLUMN BARS.TMP_APP_REP.APPROVE IS '';
COMMENT ON COLUMN BARS.TMP_APP_REP.ADATE1 IS '';
COMMENT ON COLUMN BARS.TMP_APP_REP.ADATE2 IS '';
COMMENT ON COLUMN BARS.TMP_APP_REP.RDATE1 IS '';
COMMENT ON COLUMN BARS.TMP_APP_REP.RDATE2 IS '';
COMMENT ON COLUMN BARS.TMP_APP_REP.REVERSE IS '';
COMMENT ON COLUMN BARS.TMP_APP_REP.REVOKED IS '';
COMMENT ON COLUMN BARS.TMP_APP_REP.GRANTOR IS '';
COMMENT ON COLUMN BARS.TMP_APP_REP.ACODE IS '';




PROMPT *** Create  constraint SYS_C004921 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_APP_REP MODIFY (CODEAPP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004922 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_APP_REP MODIFY (CODEREP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_APP_REP ***
grant SELECT                                                                 on TMP_APP_REP     to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_APP_REP.sql =========*** End *** =
PROMPT ===================================================================================== 
