

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML_REFLIST.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML_REFLIST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XML_REFLIST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''XML_REFLIST'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''XML_REFLIST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML_REFLIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML_REFLIST 
   (	KLTABLE_NAME VARCHAR2(100), 
	DESCRIPT VARCHAR2(200), 
	PARTSIZE NUMBER, 
	SELECT_ORDER NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XML_REFLIST ***
 exec bpa.alter_policies('XML_REFLIST');


COMMENT ON TABLE BARS.XML_REFLIST IS 'Список таблиц для синхронизации с оффлайн отделением';
COMMENT ON COLUMN BARS.XML_REFLIST.KLTABLE_NAME IS 'Имя справочника в offline отделении';
COMMENT ON COLUMN BARS.XML_REFLIST.DESCRIPT IS 'Описание';
COMMENT ON COLUMN BARS.XML_REFLIST.PARTSIZE IS 'Размер партиции(кол-во строк выгрузки для одного файла)';
COMMENT ON COLUMN BARS.XML_REFLIST.SELECT_ORDER IS 'Последовательность выгрузки';




PROMPT *** Create  constraint XPK_XMLREFLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_REFLIST ADD CONSTRAINT XPK_XMLREFLIST PRIMARY KEY (KLTABLE_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008650 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_REFLIST MODIFY (SELECT_ORDER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_XMLREFLIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_XMLREFLIST ON BARS.XML_REFLIST (KLTABLE_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XML_REFLIST ***
grant SELECT                                                                 on XML_REFLIST     to BARS_DM;
grant SELECT                                                                 on XML_REFLIST     to KLBX;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on XML_REFLIST     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML_REFLIST.sql =========*** End *** =
PROMPT ===================================================================================== 
