

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML_STORAGE.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML_STORAGE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XML_STORAGE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''XML_STORAGE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''XML_STORAGE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML_STORAGE ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML_STORAGE 
   (	URI VARCHAR2(255), 
	XML_DATA CLOB
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (XML_DATA) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XML_STORAGE ***
 exec bpa.alter_policies('XML_STORAGE');


COMMENT ON TABLE BARS.XML_STORAGE IS '';
COMMENT ON COLUMN BARS.XML_STORAGE.URI IS '';
COMMENT ON COLUMN BARS.XML_STORAGE.XML_DATA IS '';




PROMPT *** Create  constraint XPK_XML_STORAGE ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_STORAGE ADD CONSTRAINT XPK_XML_STORAGE PRIMARY KEY (URI)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_XML_STORAGE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_XML_STORAGE ON BARS.XML_STORAGE (URI) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XML_STORAGE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on XML_STORAGE     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on XML_STORAGE     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML_STORAGE.sql =========*** End *** =
PROMPT ===================================================================================== 
