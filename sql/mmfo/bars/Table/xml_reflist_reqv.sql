

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML_REFLIST_REQV.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML_REFLIST_REQV ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XML_REFLIST_REQV'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''XML_REFLIST_REQV'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''XML_REFLIST_REQV'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML_REFLIST_REQV ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML_REFLIST_REQV 
   (	KLTABLE_NAME VARCHAR2(100), 
	INSERT_STMT CLOB, 
	SELECT_STMT CLOB, 
	BEFORE_PROC VARCHAR2(500), 
	ISACTIVE NUMBER(*,0), 
	REQV_MESS VARCHAR2(10)
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




PROMPT *** ALTER_POLICIES to XML_REFLIST_REQV ***
 exec bpa.alter_policies('XML_REFLIST_REQV');


COMMENT ON TABLE BARS.XML_REFLIST_REQV IS 'Список таблиц и описание паремтров для выгрузки данных справочника по запросу с параемтрами';
COMMENT ON COLUMN BARS.XML_REFLIST_REQV.KLTABLE_NAME IS 'Имя справочника в off linr отделении';
COMMENT ON COLUMN BARS.XML_REFLIST_REQV.INSERT_STMT IS 'Запрос на вставку в tmp_refsync_* таблицу';
COMMENT ON COLUMN BARS.XML_REFLIST_REQV.SELECT_STMT IS 'Запрос на выгрузку из tmp_refsync_* таблицы';
COMMENT ON COLUMN BARS.XML_REFLIST_REQV.BEFORE_PROC IS 'Процедура до выполнения insert_stmt';
COMMENT ON COLUMN BARS.XML_REFLIST_REQV.ISACTIVE IS '';
COMMENT ON COLUMN BARS.XML_REFLIST_REQV.REQV_MESS IS 'Тип сообщения от ТВБВ для синхр данного справочника';




PROMPT *** Create  constraint FK_XMLREFREQV_TABLE ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_REFLIST_REQV ADD CONSTRAINT FK_XMLREFREQV_TABLE FOREIGN KEY (KLTABLE_NAME)
	  REFERENCES BARS.XML_REFLIST (KLTABLE_NAME) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_XMLREFREQV_TABLE ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_REFLIST_REQV ADD CONSTRAINT NN_XMLREFREQV_TABLE UNIQUE (KLTABLE_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index NN_XMLREFREQV_TABLE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.NN_XMLREFREQV_TABLE ON BARS.XML_REFLIST_REQV (KLTABLE_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XML_REFLIST_REQV ***
grant SELECT                                                                 on XML_REFLIST_REQV to BARS_DM;
grant SELECT                                                                 on XML_REFLIST_REQV to KLBX;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on XML_REFLIST_REQV to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML_REFLIST_REQV.sql =========*** End 
PROMPT ===================================================================================== 
