

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_FILTERS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_FILTERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_FILTERS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''INS_FILTERS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_FILTERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_FILTERS 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(300), 
	STMT VARCHAR2(1024), 
	PARAMS VARCHAR2(1024), 
	COLS2HIDE VARCHAR2(1024)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_FILTERS ***
 exec bpa.alter_policies('INS_FILTERS');


COMMENT ON TABLE BARS.INS_FILTERS IS 'Графік платежів по страховим договорам';
COMMENT ON COLUMN BARS.INS_FILTERS.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.INS_FILTERS.NAME IS 'Найменування';
COMMENT ON COLUMN BARS.INS_FILTERS.STMT IS 'sql вираз (без слова where), змінні вказуються у вигляді :<імя>';
COMMENT ON COLUMN BARS.INS_FILTERS.PARAMS IS 'Перелік змінних, імя змінної в url та їх тип (<імя>:<імя в url>:<тип S|N|D>;...)';
COMMENT ON COLUMN BARS.INS_FILTERS.COLS2HIDE IS 'Перелік колонок які треба сховати через ; (імя колонки береться з SortExpression)';




PROMPT *** Create  constraint CC_INSFILTERS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_FILTERS MODIFY (NAME CONSTRAINT CC_INSFILTERS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSFILTERS_WS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_FILTERS MODIFY (STMT CONSTRAINT CC_INSFILTERS_WS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_INSFILTERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_FILTERS ADD CONSTRAINT PK_INSFILTERS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INSFILTERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INSFILTERS ON BARS.INS_FILTERS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INS_FILTERS ***
grant SELECT                                                                 on INS_FILTERS     to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_FILTERS.sql =========*** End *** =
PROMPT ===================================================================================== 
