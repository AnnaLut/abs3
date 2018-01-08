

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SQL_STORAGE.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SQL_STORAGE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SQL_STORAGE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SQL_STORAGE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SQL_STORAGE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SQL_STORAGE ***
begin 
  execute immediate '
  CREATE TABLE BARS.SQL_STORAGE 
   (	URI VARCHAR2(255), 
	SQL_DATA CLOB, 
	SQL_STATEMENT CLOB
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (SQL_DATA) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (SQL_STATEMENT) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SQL_STORAGE ***
 exec bpa.alter_policies('SQL_STORAGE');


COMMENT ON TABLE BARS.SQL_STORAGE IS '';
COMMENT ON COLUMN BARS.SQL_STORAGE.URI IS '';
COMMENT ON COLUMN BARS.SQL_STORAGE.SQL_DATA IS '';
COMMENT ON COLUMN BARS.SQL_STORAGE.SQL_STATEMENT IS '';




PROMPT *** Create  constraint XPK_SQL_STORAGE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SQL_STORAGE ADD CONSTRAINT XPK_SQL_STORAGE PRIMARY KEY (URI)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_SQL_STORAGE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_SQL_STORAGE ON BARS.SQL_STORAGE (URI) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SQL_STORAGE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SQL_STORAGE     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SQL_STORAGE     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SQL_STORAGE.sql =========*** End *** =
PROMPT ===================================================================================== 
