

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/JAVA$CLASS$MD5$TABLE.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to JAVA$CLASS$MD5$TABLE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table JAVA$CLASS$MD5$TABLE ***
begin 
  execute immediate '
  CREATE TABLE BARS.JAVA$CLASS$MD5$TABLE 
   (	NAME VARCHAR2(200), 
	MD5 RAW(16)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to JAVA$CLASS$MD5$TABLE ***
 exec bpa.alter_policies('JAVA$CLASS$MD5$TABLE');


COMMENT ON TABLE BARS.JAVA$CLASS$MD5$TABLE IS '';
COMMENT ON COLUMN BARS.JAVA$CLASS$MD5$TABLE.NAME IS '';
COMMENT ON COLUMN BARS.JAVA$CLASS$MD5$TABLE.MD5 IS '';




PROMPT *** Create  constraint SYS_C0012042 ***
begin   
 execute immediate '
  ALTER TABLE BARS.JAVA$CLASS$MD5$TABLE ADD UNIQUE (NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C0012042 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C0012042 ON BARS.JAVA$CLASS$MD5$TABLE (NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  JAVA$CLASS$MD5$TABLE ***
grant SELECT                                                                 on JAVA$CLASS$MD5$TABLE to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on JAVA$CLASS$MD5$TABLE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/JAVA$CLASS$MD5$TABLE.sql =========*** 
PROMPT ===================================================================================== 
