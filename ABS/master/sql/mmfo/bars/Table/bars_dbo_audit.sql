

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BARS_DBO_AUDIT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BARS_DBO_AUDIT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BARS_DBO_AUDIT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BARS_DBO_AUDIT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BARS_DBO_AUDIT ***
begin 
  execute immediate '
  CREATE TABLE BARS.BARS_DBO_AUDIT 
   (	TIME DATE, 
	INNER_XML CLOB, 
	ID NUMBER, 
	OUTXML CLOB
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (INNER_XML) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (OUTXML) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BARS_DBO_AUDIT ***
 exec bpa.alter_policies('BARS_DBO_AUDIT');


COMMENT ON TABLE BARS.BARS_DBO_AUDIT IS '';
COMMENT ON COLUMN BARS.BARS_DBO_AUDIT.TIME IS '';
COMMENT ON COLUMN BARS.BARS_DBO_AUDIT.INNER_XML IS '';
COMMENT ON COLUMN BARS.BARS_DBO_AUDIT.ID IS '';
COMMENT ON COLUMN BARS.BARS_DBO_AUDIT.OUTXML IS '';




PROMPT *** Create  constraint PK_BARS_DBO_AUDIT ***
begin   
 execute immediate '
  ALTER TABLE BARS.BARS_DBO_AUDIT ADD CONSTRAINT PK_BARS_DBO_AUDIT PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BARS_DBO_AUDIT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BARS_DBO_AUDIT ON BARS.BARS_DBO_AUDIT (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BARS_DBO_AUDIT ***
grant SELECT                                                                 on BARS_DBO_AUDIT  to BARSREADER_ROLE;
grant SELECT                                                                 on BARS_DBO_AUDIT  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BARS_DBO_AUDIT.sql =========*** End **
PROMPT ===================================================================================== 
