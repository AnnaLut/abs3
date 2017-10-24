

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML_MESSTYPES.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML_MESSTYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XML_MESSTYPES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''XML_MESSTYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML_MESSTYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML_MESSTYPES 
   (	MESSAGE VARCHAR2(20), 
	TYPE VARCHAR2(20), 
	POST_SCHEM CLOB, 
	REPLY_SCHEM CLOB, 
	DESCRIPT VARCHAR2(200)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD 
 LOB (POST_SCHEM) STORE AS BASICFILE (
  TABLESPACE BRSSMLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) 
 LOB (REPLY_SCHEM) STORE AS BASICFILE (
  TABLESPACE BRSSMLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XML_MESSTYPES ***
 exec bpa.alter_policies('XML_MESSTYPES');


COMMENT ON TABLE BARS.XML_MESSTYPES IS '��� �����������(MessageType). ����������� ��������� ���������� �������, � �� ����� ��������� ������ �� ���������';
COMMENT ON COLUMN BARS.XML_MESSTYPES.MESSAGE IS '��� ���������';
COMMENT ON COLUMN BARS.XML_MESSTYPES.TYPE IS '��� ���������';
COMMENT ON COLUMN BARS.XML_MESSTYPES.POST_SCHEM IS 'xml c���� �������';
COMMENT ON COLUMN BARS.XML_MESSTYPES.REPLY_SCHEM IS 'xml c���� ������';
COMMENT ON COLUMN BARS.XML_MESSTYPES.DESCRIPT IS '����';




PROMPT *** Create  constraint XPK_XMLMESSTYPE_MESSAGE ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML_MESSTYPES ADD CONSTRAINT XPK_XMLMESSTYPE_MESSAGE PRIMARY KEY (MESSAGE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_XMLMESSTYPE_MESSAGE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_XMLMESSTYPE_MESSAGE ON BARS.XML_MESSTYPES (MESSAGE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XML_MESSTYPES ***
grant SELECT                                                                 on XML_MESSTYPES   to KLBX;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on XML_MESSTYPES   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML_MESSTYPES.sql =========*** End ***
PROMPT ===================================================================================== 
