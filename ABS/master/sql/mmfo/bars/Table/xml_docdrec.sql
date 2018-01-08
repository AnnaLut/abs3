

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML_DOCDREC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML_DOCDREC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XML_DOCDREC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''XML_DOCDREC'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''XML_DOCDREC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML_DOCDREC ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML_DOCDREC 
   (	TAG CHAR(5), 
	 CONSTRAINT XPK_XMLDOCDREC PRIMARY KEY (TAG) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLD 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XML_DOCDREC ***
 exec bpa.alter_policies('XML_DOCDREC');


COMMENT ON TABLE BARS.XML_DOCDREC IS 'таблица доп реквизитов, которые должны быть помещены в поле d_rec при оплате';
COMMENT ON COLUMN BARS.XML_DOCDREC.TAG IS '';




PROMPT *** Create  constraint XPK_XMLDOCDREC ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_DOCDREC ADD CONSTRAINT XPK_XMLDOCDREC PRIMARY KEY (TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_XMLDOCDREC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_XMLDOCDREC ON BARS.XML_DOCDREC (TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XML_DOCDREC ***
grant SELECT                                                                 on XML_DOCDREC     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on XML_DOCDREC     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on XML_DOCDREC     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML_DOCDREC.sql =========*** End *** =
PROMPT ===================================================================================== 
