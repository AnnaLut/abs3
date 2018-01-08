

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML_ADDHDRTAGS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML_ADDHDRTAGS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XML_ADDHDRTAGS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''XML_ADDHDRTAGS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''XML_ADDHDRTAGS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML_ADDHDRTAGS ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML_ADDHDRTAGS 
   (	MESSAGE VARCHAR2(20), 
	TAG VARCHAR2(20), 
	TAGFUNC VARCHAR2(1000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XML_ADDHDRTAGS ***
 exec bpa.alter_policies('XML_ADDHDRTAGS');


COMMENT ON TABLE BARS.XML_ADDHDRTAGS IS 'Дополнительные теги для заголовка';
COMMENT ON COLUMN BARS.XML_ADDHDRTAGS.MESSAGE IS 'Код сообщения';
COMMENT ON COLUMN BARS.XML_ADDHDRTAGS.TAG IS 'Наименование тега';
COMMENT ON COLUMN BARS.XML_ADDHDRTAGS.TAGFUNC IS 'Функция с параметрами :1,:2,:3,:4 возвращающая значение тега';




PROMPT *** Create  constraint FK_XMLADDHDR_MESS ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_ADDHDRTAGS ADD CONSTRAINT FK_XMLADDHDR_MESS FOREIGN KEY (MESSAGE)
	  REFERENCES BARS.XML_MESSTYPES (MESSAGE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_XMLADDHDR_MESSTAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_ADDHDRTAGS ADD CONSTRAINT PK_XMLADDHDR_MESSTAG PRIMARY KEY (MESSAGE, TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_XMLADDHDR_MESSTAG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_XMLADDHDR_MESSTAG ON BARS.XML_ADDHDRTAGS (MESSAGE, TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XML_ADDHDRTAGS ***
grant SELECT                                                                 on XML_ADDHDRTAGS  to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on XML_ADDHDRTAGS  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML_ADDHDRTAGS.sql =========*** End **
PROMPT ===================================================================================== 
