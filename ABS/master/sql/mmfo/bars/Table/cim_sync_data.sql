

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_SYNC_DATA.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_SYNC_DATA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_SYNC_DATA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_SYNC_DATA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_SYNC_DATA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_SYNC_DATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_SYNC_DATA 
   (	TABLE_NAME VARCHAR2(30), 
	DATA_CLOB CLOB, 
	DATA_XML SYS.XMLTYPE , 
	SYNC_DATE DATE DEFAULT sysdate, 
	ERROR_MESSAGE VARCHAR2(4000), 
	ROWS_COUNT NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD 
 LOB (DATA_CLOB) STORE AS BASICFILE (
  TABLESPACE BRSMDLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 XMLTYPE COLUMN DATA_XML STORE AS SECUREFILE BINARY XML (
  TABLESPACE BRSMDLD ENABLE STORAGE IN ROW CHUNK 8192
  NOCACHE LOGGING  NOCOMPRESS  KEEP_DUPLICATES ) ALLOW NONSCHEMA DISALLOW ANYSCHEMA ROWDEPENDENCIES ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_SYNC_DATA ***
 exec bpa.alter_policies('CIM_SYNC_DATA');


COMMENT ON TABLE BARS.CIM_SYNC_DATA IS '';
COMMENT ON COLUMN BARS.CIM_SYNC_DATA.TABLE_NAME IS '';
COMMENT ON COLUMN BARS.CIM_SYNC_DATA.DATA_CLOB IS '';
COMMENT ON COLUMN BARS.CIM_SYNC_DATA.DATA_XML IS '';
COMMENT ON COLUMN BARS.CIM_SYNC_DATA.SYNC_DATE IS '';
COMMENT ON COLUMN BARS.CIM_SYNC_DATA.ERROR_MESSAGE IS '';
COMMENT ON COLUMN BARS.CIM_SYNC_DATA.ROWS_COUNT IS '';




PROMPT *** Create  constraint PK_CIM_SYNC_DATA ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_SYNC_DATA ADD CONSTRAINT PK_CIM_SYNC_DATA PRIMARY KEY (TABLE_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIM_SYNC_DATA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIM_SYNC_DATA ON BARS.CIM_SYNC_DATA (TABLE_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_SYNC_DATA ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_SYNC_DATA   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_SYNC_DATA   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_SYNC_DATA   to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_SYNC_DATA.sql =========*** End ***
PROMPT ===================================================================================== 
