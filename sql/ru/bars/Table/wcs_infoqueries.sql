

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_INFOQUERIES.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_INFOQUERIES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_INFOQUERIES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_INFOQUERIES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_INFOQUERIES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_INFOQUERIES 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255), 
	TYPE_ID VARCHAR2(100), 
	RESULT_QID VARCHAR2(100), 
	RESULT_MSG_QID VARCHAR2(100), 
	PLSQL CLOB
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD 
 LOB (PLSQL) STORE AS BASICFILE (
  TABLESPACE BRSSMLD ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_INFOQUERIES ***
 exec bpa.alter_policies('WCS_INFOQUERIES');


COMMENT ON TABLE BARS.WCS_INFOQUERIES IS '�������������� �������';
COMMENT ON COLUMN BARS.WCS_INFOQUERIES.ID IS '�������������';
COMMENT ON COLUMN BARS.WCS_INFOQUERIES.NAME IS '������������';
COMMENT ON COLUMN BARS.WCS_INFOQUERIES.TYPE_ID IS '��� ����-�������';
COMMENT ON COLUMN BARS.WCS_INFOQUERIES.RESULT_QID IS '������������� �������-���������� ����������';
COMMENT ON COLUMN BARS.WCS_INFOQUERIES.RESULT_MSG_QID IS '������������� �������-������ ���������� ����������';
COMMENT ON COLUMN BARS.WCS_INFOQUERIES.PLSQL IS 'plsql ���� ����������� ������';




PROMPT *** Create  constraint FK_INFOQUERIES_�ID_IQTYPES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_INFOQUERIES ADD CONSTRAINT FK_INFOQUERIES_�ID_IQTYPES_ID FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.WCS_INFOQUERY_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INFOQUERIES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_INFOQUERIES ADD CONSTRAINT CC_INFOQUERIES_NAME_NN CHECK (NAME IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_INFOQUERIES ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_INFOQUERIES ADD CONSTRAINT PK_INFOQUERIES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177104 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_INFOQUERIES MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INFOQUERIES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INFOQUERIES ON BARS.WCS_INFOQUERIES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_INFOQUERIES.sql =========*** End *
PROMPT ===================================================================================== 
