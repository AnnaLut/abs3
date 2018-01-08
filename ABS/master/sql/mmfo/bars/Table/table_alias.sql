

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TABLE_ALIAS.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TABLE_ALIAS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TABLE_ALIAS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TABLE_ALIAS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''TABLE_ALIAS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TABLE_ALIAS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TABLE_ALIAS 
   (	TABLE_NAME VARCHAR2(30), 
	TABLE_ALIAS VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TABLE_ALIAS ***
 exec bpa.alter_policies('TABLE_ALIAS');


COMMENT ON TABLE BARS.TABLE_ALIAS IS '"Алиас" таблиц';
COMMENT ON COLUMN BARS.TABLE_ALIAS.TABLE_NAME IS 'Название таблицы';
COMMENT ON COLUMN BARS.TABLE_ALIAS.TABLE_ALIAS IS '"Алиас" таблицы';




PROMPT *** Create  constraint PK_TABALIAS ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABLE_ALIAS ADD CONSTRAINT PK_TABALIAS PRIMARY KEY (TABLE_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TABALIAS_TABNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABLE_ALIAS MODIFY (TABLE_NAME CONSTRAINT CC_TABALIAS_TABNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TABALIAS_TABALIAS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TABLE_ALIAS MODIFY (TABLE_ALIAS CONSTRAINT CC_TABALIAS_TABALIAS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TABALIAS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TABALIAS ON BARS.TABLE_ALIAS (TABLE_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TABLE_ALIAS ***
grant SELECT                                                                 on TABLE_ALIAS     to BARSREADER_ROLE;
grant SELECT                                                                 on TABLE_ALIAS     to BARS_DM;
grant SELECT                                                                 on TABLE_ALIAS     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TABLE_ALIAS     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TABLE_ALIAS.sql =========*** End *** =
PROMPT ===================================================================================== 
