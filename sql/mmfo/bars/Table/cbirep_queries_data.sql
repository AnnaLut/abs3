

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CBIREP_QUERIES_DATA.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CBIREP_QUERIES_DATA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CBIREP_QUERIES_DATA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CBIREP_QUERIES_DATA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CBIREP_QUERIES_DATA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CBIREP_QUERIES_DATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.CBIREP_QUERIES_DATA 
   (	QUERIES_ID NUMBER, 
	FILE_DATA BLOB, 
	FILE_TYPE VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (FILE_DATA) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CBIREP_QUERIES_DATA ***
 exec bpa.alter_policies('CBIREP_QUERIES_DATA');


COMMENT ON TABLE BARS.CBIREP_QUERIES_DATA IS 'Сформовані звіти готові для відображення';
COMMENT ON COLUMN BARS.CBIREP_QUERIES_DATA.QUERIES_ID IS 'Ид запроса';
COMMENT ON COLUMN BARS.CBIREP_QUERIES_DATA.FILE_DATA IS 'Звіт';
COMMENT ON COLUMN BARS.CBIREP_QUERIES_DATA.FILE_TYPE IS 'Тип файла';




PROMPT *** Create  constraint PK_CBIREPDATA_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CBIREP_QUERIES_DATA ADD CONSTRAINT PK_CBIREPDATA_ID PRIMARY KEY (QUERIES_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CBIREPQUERIES_DATA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CBIREP_QUERIES_DATA MODIFY (FILE_DATA CONSTRAINT CC_CBIREPQUERIES_DATA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CBIREPDATA_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CBIREPDATA_ID ON BARS.CBIREP_QUERIES_DATA (QUERIES_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CBIREP_QUERIES_DATA ***
grant SELECT                                                                 on CBIREP_QUERIES_DATA to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CBIREP_QUERIES_DATA to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CBIREP_QUERIES_DATA to BARS_DM;
grant SELECT                                                                 on CBIREP_QUERIES_DATA to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CBIREP_QUERIES_DATA.sql =========*** E
PROMPT ===================================================================================== 
