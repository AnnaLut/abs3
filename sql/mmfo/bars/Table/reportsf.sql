

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REPORTSF.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REPORTSF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REPORTSF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REPORTSF'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REPORTSF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REPORTSF ***
begin 
  execute immediate '
  CREATE TABLE BARS.REPORTSF 
   (	IDF NUMBER(38,0), 
	TYPE VARCHAR2(4), 
	NAME VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REPORTSF ***
 exec bpa.alter_policies('REPORTSF');


COMMENT ON TABLE BARS.REPORTSF IS 'Папки печатных отчетов АБС';
COMMENT ON COLUMN BARS.REPORTSF.IDF IS 'Код папки отчетов';
COMMENT ON COLUMN BARS.REPORTSF.TYPE IS 'Тип папки отчетов (символьный)';
COMMENT ON COLUMN BARS.REPORTSF.NAME IS 'Наименование папки отчетов';




PROMPT *** Create  constraint PK_REPORTSF ***
begin   
 execute immediate '
  ALTER TABLE BARS.REPORTSF ADD CONSTRAINT PK_REPORTSF PRIMARY KEY (IDF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REPORTSF_IDF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REPORTSF MODIFY (IDF CONSTRAINT CC_REPORTSF_IDF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REPORTSF_TYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REPORTSF MODIFY (TYPE CONSTRAINT CC_REPORTSF_TYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_REPORTSF_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REPORTSF MODIFY (NAME CONSTRAINT CC_REPORTSF_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REPORTSF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REPORTSF ON BARS.REPORTSF (IDF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REPORTSF ***
grant DELETE,INSERT,SELECT,UPDATE                                            on REPORTSF        to ABS_ADMIN;
grant SELECT                                                                 on REPORTSF        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REPORTSF        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REPORTSF        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on REPORTSF        to REF0000;
grant SELECT                                                                 on REPORTSF        to START1;
grant SELECT                                                                 on REPORTSF        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REPORTSF        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on REPORTSF        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REPORTSF.sql =========*** End *** ====
PROMPT ===================================================================================== 
