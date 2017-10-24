

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OP_FIELD_GOU.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OP_FIELD_GOU ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OP_FIELD_GOU ***
begin 
  execute immediate '
  CREATE TABLE BARS.OP_FIELD_GOU 
   (	TAG CHAR(5), 
	NAME VARCHAR2(35), 
	FMT VARCHAR2(35), 
	BROWSER VARCHAR2(250), 
	NOMODIFY NUMBER(1,0), 
	VSPO_CHAR VARCHAR2(1), 
	CHKR VARCHAR2(250), 
	DEFAULT_VALUE VARCHAR2(500), 
	TYPE CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OP_FIELD_GOU ***
 exec bpa.alter_policies('OP_FIELD_GOU');


COMMENT ON TABLE BARS.OP_FIELD_GOU IS '';
COMMENT ON COLUMN BARS.OP_FIELD_GOU.TAG IS '';
COMMENT ON COLUMN BARS.OP_FIELD_GOU.NAME IS '';
COMMENT ON COLUMN BARS.OP_FIELD_GOU.FMT IS '';
COMMENT ON COLUMN BARS.OP_FIELD_GOU.BROWSER IS '';
COMMENT ON COLUMN BARS.OP_FIELD_GOU.NOMODIFY IS '';
COMMENT ON COLUMN BARS.OP_FIELD_GOU.VSPO_CHAR IS '';
COMMENT ON COLUMN BARS.OP_FIELD_GOU.CHKR IS '';
COMMENT ON COLUMN BARS.OP_FIELD_GOU.DEFAULT_VALUE IS '';
COMMENT ON COLUMN BARS.OP_FIELD_GOU.TYPE IS '';




PROMPT *** Create  constraint SYS_C008930 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP_FIELD_GOU MODIFY (TAG NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008931 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OP_FIELD_GOU MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OP_FIELD_GOU ***
grant SELECT                                                                 on OP_FIELD_GOU    to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OP_FIELD_GOU.sql =========*** End *** 
PROMPT ===================================================================================== 
