

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML_SERVLIST.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML_SERVLIST ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML_SERVLIST ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML_SERVLIST 
   (	SNAM VARCHAR2(20), 
	STXT VARCHAR2(2000), 
	SPRC VARCHAR2(100), 
	DESCRIPT VARCHAR2(200), 
	PARTSIZE NUMBER, 
	AUTO_GEN NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XML_SERVLIST ***
 exec bpa.alter_policies('XML_SERVLIST');


COMMENT ON TABLE BARS.XML_SERVLIST IS 'Список сервiсiв (сервiс-це просте виконнаяння запиту та процедури та генерування вiдповiдi)';
COMMENT ON COLUMN BARS.XML_SERVLIST.SNAM IS 'тип';
COMMENT ON COLUMN BARS.XML_SERVLIST.STXT IS 'Запит';
COMMENT ON COLUMN BARS.XML_SERVLIST.SPRC IS 'Процедура перед виконанням запиту';
COMMENT ON COLUMN BARS.XML_SERVLIST.DESCRIPT IS 'Опис сервісу';
COMMENT ON COLUMN BARS.XML_SERVLIST.PARTSIZE IS 'Размер партиции ответа';
COMMENT ON COLUMN BARS.XML_SERVLIST.AUTO_GEN IS 'Автогенерация сервиса';




PROMPT *** Create  constraint PK_XML_SERVLIST ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_SERVLIST ADD CONSTRAINT PK_XML_SERVLIST PRIMARY KEY (SNAM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_XML_SERVLIST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_XML_SERVLIST ON BARS.XML_SERVLIST (SNAM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XML_SERVLIST ***
grant SELECT                                                                 on XML_SERVLIST    to BARSREADER_ROLE;
grant SELECT                                                                 on XML_SERVLIST    to BARS_DM;
grant SELECT                                                                 on XML_SERVLIST    to KLBX;
grant SELECT                                                                 on XML_SERVLIST    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on XML_SERVLIST    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML_SERVLIST.sql =========*** End *** 
PROMPT ===================================================================================== 
