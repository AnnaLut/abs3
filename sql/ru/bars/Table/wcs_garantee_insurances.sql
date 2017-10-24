

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_GARANTEE_INSURANCES.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_GARANTEE_INSURANCES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_GARANTEE_INSURANCES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_GARANTEE_INSURANCES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_GARANTEE_INSURANCES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_GARANTEE_INSURANCES 
   (	GARANTEE_ID VARCHAR2(100), 
	INSURANCE_ID VARCHAR2(100), 
	IS_REQUIRED NUMBER DEFAULT 1, 
	ORD NUMBER, 
	WS_QID VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_GARANTEE_INSURANCES ***
 exec bpa.alter_policies('WCS_GARANTEE_INSURANCES');


COMMENT ON TABLE BARS.WCS_GARANTEE_INSURANCES IS '�������� ��������� � �������';
COMMENT ON COLUMN BARS.WCS_GARANTEE_INSURANCES.GARANTEE_ID IS '�����. ������������� ���� ������';
COMMENT ON COLUMN BARS.WCS_GARANTEE_INSURANCES.INSURANCE_ID IS '������������� ���� ���������';
COMMENT ON COLUMN BARS.WCS_GARANTEE_INSURANCES.IS_REQUIRED IS '����������� �� ��� ����������';
COMMENT ON COLUMN BARS.WCS_GARANTEE_INSURANCES.ORD IS '�������';
COMMENT ON COLUMN BARS.WCS_GARANTEE_INSURANCES.WS_QID IS '������������� ������� ��� �������� �������� ������������';




PROMPT *** Create  constraint FK_WCSGRTINS_INSID_WCSINS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_GARANTEE_INSURANCES ADD CONSTRAINT FK_WCSGRTINS_INSID_WCSINS_ID FOREIGN KEY (INSURANCE_ID)
	  REFERENCES BARS.WCS_INSURANCES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_WCSGRTINS_GRTID_GARANTEE_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_GARANTEE_INSURANCES ADD CONSTRAINT FK_WCSGRTINS_GRTID_GARANTEE_ID FOREIGN KEY (GARANTEE_ID)
	  REFERENCES BARS.WCS_GARANTEES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSGRTINS_WSID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_GARANTEE_INSURANCES ADD CONSTRAINT CC_WCSGRTINS_WSID_NN CHECK (WS_QID IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_WCSGRTINS_REQUIRED ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_GARANTEE_INSURANCES ADD CONSTRAINT CC_WCSGRTINS_REQUIRED CHECK (is_required in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_WCSGRTINS ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_GARANTEE_INSURANCES ADD CONSTRAINT PK_WCSGRTINS PRIMARY KEY (GARANTEE_ID, INSURANCE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177083 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_GARANTEE_INSURANCES MODIFY (INSURANCE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177082 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_GARANTEE_INSURANCES MODIFY (GARANTEE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_WCSGRTINS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_WCSGRTINS ON BARS.WCS_GARANTEE_INSURANCES (GARANTEE_ID, INSURANCE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_GARANTEE_INSURANCES ***
grant SELECT                                                                 on WCS_GARANTEE_INSURANCES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_GARANTEE_INSURANCES.sql =========*
PROMPT ===================================================================================== 
