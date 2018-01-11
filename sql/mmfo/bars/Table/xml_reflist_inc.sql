

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML_REFLIST_INC.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML_REFLIST_INC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XML_REFLIST_INC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''XML_REFLIST_INC'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''XML_REFLIST_INC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML_REFLIST_INC ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML_REFLIST_INC 
   (	KLTABLE_NAME VARCHAR2(100), 
	SELECT_STMT CLOB, 
	ISACTIVE NUMBER(*,0), 
	AQ_TABLES VARCHAR2(1000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD 
 LOB (SELECT_STMT) STORE AS BASICFILE (
  TABLESPACE BRSSMLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XML_REFLIST_INC ***
 exec bpa.alter_policies('XML_REFLIST_INC');


COMMENT ON TABLE BARS.XML_REFLIST_INC IS 'Список таблиц и описание паремтров для инкрементоной синхронизации, постоенной на AQ';
COMMENT ON COLUMN BARS.XML_REFLIST_INC.KLTABLE_NAME IS 'Имя справочника в off linr отделении';
COMMENT ON COLUMN BARS.XML_REFLIST_INC.SELECT_STMT IS 'Запрос на выгрузку из tmp_refsync_* таблицы';
COMMENT ON COLUMN BARS.XML_REFLIST_INC.ISACTIVE IS 'Активность выгрузки';
COMMENT ON COLUMN BARS.XML_REFLIST_INC.AQ_TABLES IS 'Таблицы для ORACLE STREAMS, которые участвуют для синхронизации справочника';




PROMPT *** Create  constraint NN_XMLREFINC_TABLE ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_REFLIST_INC ADD CONSTRAINT NN_XMLREFINC_TABLE UNIQUE (KLTABLE_NAME)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index NN_XMLREFINC_TABLE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.NN_XMLREFINC_TABLE ON BARS.XML_REFLIST_INC (KLTABLE_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XML_REFLIST_INC ***
grant SELECT                                                                 on XML_REFLIST_INC to BARSREADER_ROLE;
grant SELECT                                                                 on XML_REFLIST_INC to BARS_DM;
grant SELECT                                                                 on XML_REFLIST_INC to KLBX;
grant SELECT                                                                 on XML_REFLIST_INC to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on XML_REFLIST_INC to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML_REFLIST_INC.sql =========*** End *
PROMPT ===================================================================================== 
