

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DBF_IMP_TABS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DBF_IMP_TABS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DBF_IMP_TABS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DBF_IMP_TABS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DBF_IMP_TABS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DBF_IMP_TABS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DBF_IMP_TABS 
   (	TABNAME VARCHAR2(30), 
	IMPMOD VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DBF_IMP_TABS ***
 exec bpa.alter_policies('DBF_IMP_TABS');


COMMENT ON TABLE BARS.DBF_IMP_TABS IS 'Справочник допустимых таблиц для импорта';
COMMENT ON COLUMN BARS.DBF_IMP_TABS.TABNAME IS 'Имя таблицы';
COMMENT ON COLUMN BARS.DBF_IMP_TABS.IMPMOD IS 'Режим импорта (C-drop+create+insert, I-delete+insert, A-insert)';




PROMPT *** Create  constraint PK_DBFIMPTABS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DBF_IMP_TABS ADD CONSTRAINT PK_DBFIMPTABS PRIMARY KEY (TABNAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DBFIMPTABS_TABNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DBF_IMP_TABS MODIFY (TABNAME CONSTRAINT CC_DBFIMPTABS_TABNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DBFIMPTABS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DBFIMPTABS ON BARS.DBF_IMP_TABS (TABNAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DBF_IMP_TABS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DBF_IMP_TABS    to ABS_ADMIN;
grant SELECT                                                                 on DBF_IMP_TABS    to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DBF_IMP_TABS    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DBF_IMP_TABS    to BARS_DM;
grant SELECT                                                                 on DBF_IMP_TABS    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DBF_IMP_TABS    to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DBF_IMP_TABS    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DBF_IMP_TABS.sql =========*** End *** 
PROMPT ===================================================================================== 
