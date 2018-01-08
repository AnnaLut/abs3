

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OPFIELD.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OPFIELD ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OPFIELD ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_OPFIELD 
   (	TAG CHAR(5), 
	NAME VARCHAR2(35), 
	FMT VARCHAR2(35), 
	BROWSER VARCHAR2(250), 
	NOMODIFY NUMBER(1,0), 
	VSPO_CHAR VARCHAR2(1), 
	CHKR VARCHAR2(250), 
	DEFAULT_VALUE VARCHAR2(500), 
	TYPE CHAR(1), 
	USE_IN_ARCH NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OPFIELD ***
 exec bpa.alter_policies('TMP_OPFIELD');


COMMENT ON TABLE BARS.TMP_OPFIELD IS '';
COMMENT ON COLUMN BARS.TMP_OPFIELD.TAG IS '';
COMMENT ON COLUMN BARS.TMP_OPFIELD.NAME IS '';
COMMENT ON COLUMN BARS.TMP_OPFIELD.FMT IS '';
COMMENT ON COLUMN BARS.TMP_OPFIELD.BROWSER IS '';
COMMENT ON COLUMN BARS.TMP_OPFIELD.NOMODIFY IS '';
COMMENT ON COLUMN BARS.TMP_OPFIELD.VSPO_CHAR IS '';
COMMENT ON COLUMN BARS.TMP_OPFIELD.CHKR IS '';
COMMENT ON COLUMN BARS.TMP_OPFIELD.DEFAULT_VALUE IS '';
COMMENT ON COLUMN BARS.TMP_OPFIELD.TYPE IS '';
COMMENT ON COLUMN BARS.TMP_OPFIELD.USE_IN_ARCH IS '';




PROMPT *** Create  constraint SYS_C00110721 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OPFIELD MODIFY (TAG NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00110722 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_OPFIELD MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_OPFIELD ***
grant SELECT                                                                 on TMP_OPFIELD     to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_OPFIELD     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OPFIELD.sql =========*** End *** =
PROMPT ===================================================================================== 
