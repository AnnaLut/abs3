

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WEB_WHERE_CLAUSE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WEB_WHERE_CLAUSE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WEB_WHERE_CLAUSE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WEB_WHERE_CLAUSE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''WEB_WHERE_CLAUSE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WEB_WHERE_CLAUSE ***
begin 
  execute immediate '
  CREATE TABLE BARS.WEB_WHERE_CLAUSE 
   (	ID_CLAUSE VARCHAR2(30), 
	NAME_CLAUSE VARCHAR2(30), 
	WHERE_CLAUSE VARCHAR2(512), 
	TYPE_CLAUSE NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WEB_WHERE_CLAUSE ***
 exec bpa.alter_policies('WEB_WHERE_CLAUSE');


COMMENT ON TABLE BARS.WEB_WHERE_CLAUSE IS 'Справочник доп. условий запросов';
COMMENT ON COLUMN BARS.WEB_WHERE_CLAUSE.ID_CLAUSE IS 'Идентификатор';
COMMENT ON COLUMN BARS.WEB_WHERE_CLAUSE.NAME_CLAUSE IS 'Описание';
COMMENT ON COLUMN BARS.WEB_WHERE_CLAUSE.WHERE_CLAUSE IS 'Уcловие sql хвоста';
COMMENT ON COLUMN BARS.WEB_WHERE_CLAUSE.TYPE_CLAUSE IS 'Тип: 1 - счета отделения, 2 - счета пользователя';




PROMPT *** Create  constraint PK_WEB_WHERE_CLAUSE ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_WHERE_CLAUSE ADD CONSTRAINT PK_WEB_WHERE_CLAUSE PRIMARY KEY (ID_CLAUSE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WHERECLAUSE_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_WHERE_CLAUSE MODIFY (ID_CLAUSE CONSTRAINT CC_WHERECLAUSE_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WHERECLAUSE_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_WHERE_CLAUSE MODIFY (NAME_CLAUSE CONSTRAINT CC_WHERECLAUSE_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WHERECLAUSE_WHERE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WEB_WHERE_CLAUSE MODIFY (WHERE_CLAUSE CONSTRAINT CC_WHERECLAUSE_WHERE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WEB_WHERE_CLAUSE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WEB_WHERE_CLAUSE ON BARS.WEB_WHERE_CLAUSE (ID_CLAUSE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WEB_WHERE_CLAUSE ***
grant SELECT                                                                 on WEB_WHERE_CLAUSE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WEB_WHERE_CLAUSE to BARS_DM;
grant SELECT                                                                 on WEB_WHERE_CLAUSE to BASIC_INFO;
grant SELECT                                                                 on WEB_WHERE_CLAUSE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WEB_WHERE_CLAUSE.sql =========*** End 
PROMPT ===================================================================================== 
