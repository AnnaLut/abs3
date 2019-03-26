

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_INSURANCES.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_INSURANCES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_INSURANCES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_INSURANCES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_INSURANCES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_INSURANCES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_INSURANCES 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255), 
	INS_TYPE_ID NUMBER, 
	SURVEY_ID VARCHAR2(100), 
	COUNT_QID VARCHAR2(100), 
	STATUS_QID VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_INSURANCES ***
 exec bpa.alter_policies('WCS_INSURANCES');


COMMENT ON TABLE BARS.WCS_INSURANCES IS '�����. ���� ���������';
COMMENT ON COLUMN BARS.WCS_INSURANCES.ID IS '�������������';
COMMENT ON COLUMN BARS.WCS_INSURANCES.NAME IS '������������';
COMMENT ON COLUMN BARS.WCS_INSURANCES.INS_TYPE_ID IS '������������� ���� ���������';
COMMENT ON COLUMN BARS.WCS_INSURANCES.SURVEY_ID IS '����� ������ ������';
COMMENT ON COLUMN BARS.WCS_INSURANCES.COUNT_QID IS '������ ���������� ��������� ����������� ������ ����';
COMMENT ON COLUMN BARS.WCS_INSURANCES.STATUS_QID IS '������ ��������� �������� ����������� ������ ����';




PROMPT *** Create  constraint PK_WCSINSURANCES ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_INSURANCES ADD CONSTRAINT PK_WCSINSURANCES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSINSURANCES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_INSURANCES MODIFY (NAME CONSTRAINT CC_WCSINSURANCES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSINSURANCES_INSTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_INSURANCES MODIFY (INS_TYPE_ID CONSTRAINT CC_WCSINSURANCES_INSTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSINSURANCES_CQID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_INSURANCES MODIFY (COUNT_QID CONSTRAINT CC_WCSINSURANCES_CQID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSINSURANCES_SQID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_INSURANCES MODIFY (STATUS_QID CONSTRAINT CC_WCSINSURANCES_SQID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSINSURANCES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSINSURANCES ON BARS.WCS_INSURANCES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_INSURANCES ***
grant SELECT                                                                 on WCS_INSURANCES  to BARSREADER_ROLE;
grant SELECT                                                                 on WCS_INSURANCES  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_INSURANCES  to BARS_DM;
grant SELECT                                                                 on WCS_INSURANCES  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_INSURANCES.sql =========*** End **
PROMPT ===================================================================================== 