

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/APP_REP_BAK.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to APP_REP_BAK ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table APP_REP_BAK ***
begin 
  execute immediate '
  CREATE TABLE BARS.APP_REP_BAK 
   (	CODEAPP VARCHAR2(30 CHAR), 
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




PROMPT *** ALTER_POLICIES to APP_REP_BAK ***
 exec bpa.alter_policies('APP_REP_BAK');


COMMENT ON TABLE BARS.APP_REP_BAK IS '';
COMMENT ON COLUMN BARS.APP_REP_BAK.CODEAPP IS '';
COMMENT ON COLUMN BARS.APP_REP_BAK.CODEREP IS '';
COMMENT ON COLUMN BARS.APP_REP_BAK.APPROVE IS '';
COMMENT ON COLUMN BARS.APP_REP_BAK.ADATE1 IS '';
COMMENT ON COLUMN BARS.APP_REP_BAK.ADATE2 IS '';
COMMENT ON COLUMN BARS.APP_REP_BAK.RDATE1 IS '';
COMMENT ON COLUMN BARS.APP_REP_BAK.RDATE2 IS '';
COMMENT ON COLUMN BARS.APP_REP_BAK.REVERSE IS '';
COMMENT ON COLUMN BARS.APP_REP_BAK.REVOKED IS '';
COMMENT ON COLUMN BARS.APP_REP_BAK.GRANTOR IS '';
COMMENT ON COLUMN BARS.APP_REP_BAK.ACODE IS '';




PROMPT *** Create  constraint SYS_C0025777 ***
begin   
 execute immediate '
  ALTER TABLE BARS.APP_REP_BAK MODIFY (CODEAPP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0025778 ***
begin   
 execute immediate '
  ALTER TABLE BARS.APP_REP_BAK MODIFY (CODEREP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  APP_REP_BAK ***
grant SELECT                                                                 on APP_REP_BAK     to BARSREADER_ROLE;
grant SELECT                                                                 on APP_REP_BAK     to BARS_DM;
grant SELECT                                                                 on APP_REP_BAK     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/APP_REP_BAK.sql =========*** End *** =
PROMPT ===================================================================================== 
