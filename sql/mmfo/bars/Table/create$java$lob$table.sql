

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CREATE$JAVA$LOB$TABLE.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CREATE$JAVA$LOB$TABLE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CREATE$JAVA$LOB$TABLE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CREATE$JAVA$LOB$TABLE 
   (	NAME VARCHAR2(700), 
	LOB BLOB, 
	LOADTIME DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD 
 LOB (LOB) STORE AS BASICFILE (
  TABLESPACE BRSSMLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CREATE$JAVA$LOB$TABLE ***
 exec bpa.alter_policies('CREATE$JAVA$LOB$TABLE');


COMMENT ON TABLE BARS.CREATE$JAVA$LOB$TABLE IS '';
COMMENT ON COLUMN BARS.CREATE$JAVA$LOB$TABLE.NAME IS '';
COMMENT ON COLUMN BARS.CREATE$JAVA$LOB$TABLE.LOB IS '';
COMMENT ON COLUMN BARS.CREATE$JAVA$LOB$TABLE.LOADTIME IS '';




PROMPT *** Create  constraint SYS_C0011603 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CREATE$JAVA$LOB$TABLE ADD UNIQUE (NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C0011603 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C0011603 ON BARS.CREATE$JAVA$LOB$TABLE (NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CREATE$JAVA$LOB$TABLE ***
grant SELECT                                                                 on CREATE$JAVA$LOB$TABLE to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CREATE$JAVA$LOB$TABLE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CREATE$JAVA$LOB$TABLE.sql =========***
PROMPT ===================================================================================== 
