

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAPROS_ATTR.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAPROS_ATTR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAPROS_ATTR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ZAPROS_ATTR'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ZAPROS_ATTR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAPROS_ATTR ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAPROS_ATTR 
   (	ID VARCHAR2(30), 
	NAME VARCHAR2(100), 
	SQL_TEXT VARCHAR2(244), 
	KODZ NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAPROS_ATTR ***
 exec bpa.alter_policies('ZAPROS_ATTR');


COMMENT ON TABLE BARS.ZAPROS_ATTR IS 'Переменные кат. запросов';
COMMENT ON COLUMN BARS.ZAPROS_ATTR.ID IS 'Код переменной';
COMMENT ON COLUMN BARS.ZAPROS_ATTR.NAME IS 'Наименование переменной';
COMMENT ON COLUMN BARS.ZAPROS_ATTR.SQL_TEXT IS 'Текст SQL-запроса для получения переменной';
COMMENT ON COLUMN BARS.ZAPROS_ATTR.KODZ IS 'Код запроса';




PROMPT *** Create  constraint PK_ZAPROSATTR ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAPROS_ATTR ADD CONSTRAINT PK_ZAPROSATTR PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAPROSATTR_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAPROS_ATTR MODIFY (NAME CONSTRAINT CC_ZAPROSATTR_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ZAPROSATTR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ZAPROSATTR ON BARS.ZAPROS_ATTR (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAPROS_ATTR ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAPROS_ATTR     to ABS_ADMIN;
grant SELECT                                                                 on ZAPROS_ATTR     to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZAPROS_ATTR     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAPROS_ATTR     to BARS_DM;
grant SELECT                                                                 on ZAPROS_ATTR     to START1;
grant SELECT                                                                 on ZAPROS_ATTR     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZAPROS_ATTR     to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on ZAPROS_ATTR     to WR_REFREAD;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAPROS_ATTR     to ZAPROS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAPROS_ATTR.sql =========*** End *** =
PROMPT ===================================================================================== 
