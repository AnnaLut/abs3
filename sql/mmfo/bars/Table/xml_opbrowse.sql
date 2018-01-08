

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML_OPBROWSE.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML_OPBROWSE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML_OPBROWSE ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML_OPBROWSE 
   (	TAG CHAR(5), 
	BROWSER VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XML_OPBROWSE ***
 exec bpa.alter_policies('XML_OPBROWSE');


COMMENT ON TABLE BARS.XML_OPBROWSE IS 'Функции выбора доп. реквизитов из справочника для оффлана (аналог tts.browser)';
COMMENT ON COLUMN BARS.XML_OPBROWSE.TAG IS '';
COMMENT ON COLUMN BARS.XML_OPBROWSE.BROWSER IS '';




PROMPT *** Create  constraint XPK_XMLOPBROWSE ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_OPBROWSE ADD CONSTRAINT XPK_XMLOPBROWSE PRIMARY KEY (TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_XMLOPBROWSE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_XMLOPBROWSE ON BARS.XML_OPBROWSE (TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XML_OPBROWSE ***
grant SELECT                                                                 on XML_OPBROWSE    to BARSREADER_ROLE;
grant SELECT                                                                 on XML_OPBROWSE    to BARS_DM;
grant SELECT                                                                 on XML_OPBROWSE    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on XML_OPBROWSE    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML_OPBROWSE.sql =========*** End *** 
PROMPT ===================================================================================== 
