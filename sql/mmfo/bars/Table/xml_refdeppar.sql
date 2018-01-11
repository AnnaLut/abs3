

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML_REFDEPPAR.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML_REFDEPPAR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XML_REFDEPPAR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''XML_REFDEPPAR'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''XML_REFDEPPAR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML_REFDEPPAR ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML_REFDEPPAR 
   (	KLTABLE_NAME VARCHAR2(100), 
	KLTABLE_DEPNAME VARCHAR2(100), 
	SRCPAR VARCHAR2(50), 
	DESTPAR VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XML_REFDEPPAR ***
 exec bpa.alter_policies('XML_REFDEPPAR');


COMMENT ON TABLE BARS.XML_REFDEPPAR IS 'Связь параметров для выгрузки связанных справочников';
COMMENT ON COLUMN BARS.XML_REFDEPPAR.KLTABLE_NAME IS 'Имя справочника';
COMMENT ON COLUMN BARS.XML_REFDEPPAR.KLTABLE_DEPNAME IS 'Имя справочника, который следует синхронизировать если синхронизировали справочник kltable_name';
COMMENT ON COLUMN BARS.XML_REFDEPPAR.SRCPAR IS 'Имя параметра главной таблицы';
COMMENT ON COLUMN BARS.XML_REFDEPPAR.DESTPAR IS 'Имя параметра связанной таблицы';




PROMPT *** Create  constraint XUK_XMLREFDEPPAR ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_REFDEPPAR ADD CONSTRAINT XUK_XMLREFDEPPAR UNIQUE (KLTABLE_NAME, KLTABLE_DEPNAME, SRCPAR, DESTPAR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XUK_XMLREFDEPPAR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XUK_XMLREFDEPPAR ON BARS.XML_REFDEPPAR (KLTABLE_NAME, KLTABLE_DEPNAME, SRCPAR, DESTPAR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XML_REFDEPPAR ***
grant SELECT                                                                 on XML_REFDEPPAR   to BARSREADER_ROLE;
grant SELECT                                                                 on XML_REFDEPPAR   to BARS_DM;
grant SELECT                                                                 on XML_REFDEPPAR   to KLBX;
grant SELECT                                                                 on XML_REFDEPPAR   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on XML_REFDEPPAR   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML_REFDEPPAR.sql =========*** End ***
PROMPT ===================================================================================== 
