

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML_IMPDOCSW.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML_IMPDOCSW ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XML_IMPDOCSW'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''XML_IMPDOCSW'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML_IMPDOCSW ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML_IMPDOCSW 
   (	IMPREF NUMBER, 
	TAG VARCHAR2(5), 
	VALUE VARCHAR2(200)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XML_IMPDOCSW ***
 exec bpa.alter_policies('XML_IMPDOCSW');


COMMENT ON TABLE BARS.XML_IMPDOCSW IS '��� ��������� ��������������� ����������';
COMMENT ON COLUMN BARS.XML_IMPDOCSW.IMPREF IS '';
COMMENT ON COLUMN BARS.XML_IMPDOCSW.TAG IS '';
COMMENT ON COLUMN BARS.XML_IMPDOCSW.VALUE IS '';




PROMPT *** Create  constraint XFK_XMLIMPDOCSW ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_IMPDOCSW ADD CONSTRAINT XFK_XMLIMPDOCSW FOREIGN KEY (IMPREF)
	  REFERENCES BARS.XML_IMPDOCS (IMPREF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_IMPDOCSW_IMPREF ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_IMPDOCSW_IMPREF ON BARS.XML_IMPDOCSW (IMPREF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XML_IMPDOCSW ***
grant DELETE,INSERT,SELECT,UPDATE                                            on XML_IMPDOCSW    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on XML_IMPDOCSW    to OPER000;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on XML_IMPDOCSW    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML_IMPDOCSW.sql =========*** End *** 
PROMPT ===================================================================================== 
