

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML_DOCDREC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML_DOCDREC ***


BEGIN 
        execute immediate  
          'begin  
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


COMMENT ON TABLE BARS.XML_DOCDREC IS '������� ��� ����������, ������� ������ ���� �������� � ���� d_rec ��� ������';
COMMENT ON COLUMN BARS.XML_DOCDREC.TAG IS '';




PROMPT *** Create  constraint XFK_XMLDOCDREC ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_DOCDREC ADD CONSTRAINT XFK_XMLDOCDREC FOREIGN KEY (TAG)
	  REFERENCES BARS.OP_FIELD (TAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




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





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML_DOCDREC.sql =========*** End *** =
PROMPT ===================================================================================== 
