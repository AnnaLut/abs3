

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_CREDITDATA_BASE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_CREDITDATA_BASE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_CREDITDATA_BASE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_CREDITDATA_BASE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_CREDITDATA_BASE ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_CREDITDATA_BASE 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255), 
	TYPE_ID VARCHAR2(100), 
	STATE_ID VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_CREDITDATA_BASE ***
 exec bpa.alter_policies('WCS_CREDITDATA_BASE');


COMMENT ON TABLE BARS.WCS_CREDITDATA_BASE IS '������� ��������� ������ �������';
COMMENT ON COLUMN BARS.WCS_CREDITDATA_BASE.ID IS '�������������';
COMMENT ON COLUMN BARS.WCS_CREDITDATA_BASE.NAME IS '������������';
COMMENT ON COLUMN BARS.WCS_CREDITDATA_BASE.TYPE_ID IS '���';
COMMENT ON COLUMN BARS.WCS_CREDITDATA_BASE.STATE_ID IS '���� �����';




PROMPT *** Create  constraint FK_CRDDTBASE_TID_QTYPES_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_CREDITDATA_BASE ADD CONSTRAINT FK_CRDDTBASE_TID_QTYPES_ID FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.WCS_QUESTION_TYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSCRDDATABASE_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_CREDITDATA_BASE ADD CONSTRAINT CC_WCSCRDDATABASE_TYPEID_NN CHECK (TYPE_ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSCRDDATABASE_STID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_CREDITDATA_BASE ADD CONSTRAINT CC_WCSCRDDATABASE_STID_NN CHECK (STATE_ID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSCRDDATABASE_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_CREDITDATA_BASE ADD CONSTRAINT CC_WCSCRDDATABASE_NAME_NN CHECK (NAME IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_WCSCRDDATABASE ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_CREDITDATA_BASE ADD CONSTRAINT PK_WCSCRDDATABASE PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177050 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_CREDITDATA_BASE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSCRDDATABASE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSCRDDATABASE ON BARS.WCS_CREDITDATA_BASE (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_CREDITDATA_BASE ***
grant SELECT                                                                 on WCS_CREDITDATA_BASE to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_CREDITDATA_BASE.sql =========*** E
PROMPT ===================================================================================== 
