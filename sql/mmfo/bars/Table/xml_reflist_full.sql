

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML_REFLIST_FULL.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML_REFLIST_FULL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XML_REFLIST_FULL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''XML_REFLIST_FULL'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''XML_REFLIST_FULL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML_REFLIST_FULL ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML_REFLIST_FULL 
   (	KLTABLE_NAME VARCHAR2(100), 
	INSERT_STMT CLOB, 
	SELECT_STMT CLOB, 
	BEFORE_PROC VARCHAR2(500), 
	ISACTIVE NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD 
 LOB (INSERT_STMT) STORE AS BASICFILE (
  TABLESPACE BRSSMLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (SELECT_STMT) STORE AS BASICFILE (
  TABLESPACE BRSSMLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XML_REFLIST_FULL ***
 exec bpa.alter_policies('XML_REFLIST_FULL');


COMMENT ON TABLE BARS.XML_REFLIST_FULL IS 'Список таблиц и описание паремтров для выгрузки полного справочника';
COMMENT ON COLUMN BARS.XML_REFLIST_FULL.KLTABLE_NAME IS 'Имя справочника в off linr отделении';
COMMENT ON COLUMN BARS.XML_REFLIST_FULL.INSERT_STMT IS 'Запрос на вставку в tmp_refsync_* таблицу';
COMMENT ON COLUMN BARS.XML_REFLIST_FULL.SELECT_STMT IS 'Запрос на выгрузку из tmp_refsync_* таблицы';
COMMENT ON COLUMN BARS.XML_REFLIST_FULL.BEFORE_PROC IS 'Процедура до выполнения insert_stmt';
COMMENT ON COLUMN BARS.XML_REFLIST_FULL.ISACTIVE IS 'Активность выгрузки';




PROMPT *** Create  constraint NN_XMLREFFULL_TABLE ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_REFLIST_FULL ADD CONSTRAINT NN_XMLREFFULL_TABLE UNIQUE (KLTABLE_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index NN_XMLREFFULL_TABLE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.NN_XMLREFFULL_TABLE ON BARS.XML_REFLIST_FULL (KLTABLE_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XML_REFLIST_FULL ***
grant SELECT                                                                 on XML_REFLIST_FULL to BARSREADER_ROLE;
grant SELECT                                                                 on XML_REFLIST_FULL to BARS_DM;
grant SELECT                                                                 on XML_REFLIST_FULL to KLBX;
grant SELECT                                                                 on XML_REFLIST_FULL to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on XML_REFLIST_FULL to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML_REFLIST_FULL.sql =========*** End 
PROMPT ===================================================================================== 
