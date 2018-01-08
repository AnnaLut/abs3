

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TABLE_COL_ALIAS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TABLE_COL_ALIAS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TABLE_COL_ALIAS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TABLE_COL_ALIAS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''TABLE_COL_ALIAS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TABLE_COL_ALIAS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TABLE_COL_ALIAS 
   (	TABLE_NAME VARCHAR2(30), 
	COLUMN_NAME VARCHAR2(30), 
	COLUMN_ALIAS VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TABLE_COL_ALIAS ***
 exec bpa.alter_policies('TABLE_COL_ALIAS');


COMMENT ON TABLE BARS.TABLE_COL_ALIAS IS '"Алиас" столбцов таблиц';
COMMENT ON COLUMN BARS.TABLE_COL_ALIAS.TABLE_NAME IS 'Название таблицы';
COMMENT ON COLUMN BARS.TABLE_COL_ALIAS.COLUMN_NAME IS 'Название столбцов';
COMMENT ON COLUMN BARS.TABLE_COL_ALIAS.COLUMN_ALIAS IS '"Алиас" столбцов';




PROMPT *** Create  constraint FK_TABCOLALIAS_TABALIAS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABLE_COL_ALIAS ADD CONSTRAINT FK_TABCOLALIAS_TABALIAS FOREIGN KEY (TABLE_NAME)
	  REFERENCES BARS.TABLE_ALIAS (TABLE_NAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TABCOLALIAS_TABNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABLE_COL_ALIAS MODIFY (TABLE_NAME CONSTRAINT CC_TABCOLALIAS_TABNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TABCOLALIAS_COLNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABLE_COL_ALIAS MODIFY (COLUMN_NAME CONSTRAINT CC_TABCOLALIAS_COLNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TABCOLALIAS_COLALIAS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABLE_COL_ALIAS MODIFY (COLUMN_ALIAS CONSTRAINT CC_TABCOLALIAS_COLALIAS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_TABCOLALIAS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABLE_COL_ALIAS ADD CONSTRAINT PK_TABCOLALIAS PRIMARY KEY (TABLE_NAME, COLUMN_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TABCOLALIAS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TABCOLALIAS ON BARS.TABLE_COL_ALIAS (TABLE_NAME, COLUMN_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TABLE_COL_ALIAS ***
grant SELECT                                                                 on TABLE_COL_ALIAS to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TABLE_COL_ALIAS to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TABLE_COL_ALIAS.sql =========*** End *
PROMPT ===================================================================================== 
