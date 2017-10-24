

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCT_CREDITDATA.sql ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SUBPRODUCT_CREDITDATA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SUBPRODUCT_CREDITDATA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SUBPRODUCT_CREDITDATA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SUBPRODUCT_CREDITDATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SUBPRODUCT_CREDITDATA 
   (	SUBPRODUCT_ID VARCHAR2(100), 
	CRDDATA_ID VARCHAR2(100), 
	QUESTION_ID VARCHAR2(100), 
	IS_VISIBLE NUMBER DEFAULT 1, 
	IS_CHECKABLE NUMBER DEFAULT 0, 
	CHECK_PROC VARCHAR2(4000), 
	IS_READONLY VARCHAR2(4000) DEFAULT 0, 
	DNSHOW_IF VARCHAR2(4000), 
	GROUP_ID VARCHAR2(100), 
	ORD NUMBER, 
	IS_REQUIRED NUMBER DEFAULT 1
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SUBPRODUCT_CREDITDATA ***
 exec bpa.alter_policies('WCS_SUBPRODUCT_CREDITDATA');


COMMENT ON TABLE BARS.WCS_SUBPRODUCT_CREDITDATA IS '��������� ������� ��� �����������';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_CREDITDATA.SUBPRODUCT_ID IS '������������� �����������';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_CREDITDATA.CRDDATA_ID IS '������������� ���������';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_CREDITDATA.QUESTION_ID IS '������������� �������';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_CREDITDATA.IS_VISIBLE IS '���������� ��� ���';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_CREDITDATA.IS_CHECKABLE IS '��������� ��� ���';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_CREDITDATA.CHECK_PROC IS '������������� �������';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_CREDITDATA.IS_READONLY IS '������ ������ (null/1/true - OK, 0/false - NOT OK)';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_CREDITDATA.DNSHOW_IF IS '������� �� �������� �� ���������� ������';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_CREDITDATA.GROUP_ID IS '';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_CREDITDATA.ORD IS '������� ����������';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_CREDITDATA.IS_REQUIRED IS '';




PROMPT *** Create  constraint FK_SBPCRDDATA_SBPID_SBPS_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_CREDITDATA ADD CONSTRAINT FK_SBPCRDDATA_SBPID_SBPS_ID FOREIGN KEY (SUBPRODUCT_ID)
	  REFERENCES BARS.WCS_SUBPRODUCTS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPCRDDATA_QUEST ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_CREDITDATA ADD CONSTRAINT FK_SBPCRDDATA_QUEST FOREIGN KEY (QUESTION_ID)
	  REFERENCES BARS.WCS_QUESTIONS (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SBPCRDDATA_CDID_CRDDATA_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_CREDITDATA ADD CONSTRAINT FK_SBPCRDDATA_CDID_CRDDATA_ID FOREIGN KEY (CRDDATA_ID)
	  REFERENCES BARS.WCS_CREDITDATA_BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SBPCRDDATA_ISVISIBLE ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_CREDITDATA ADD CONSTRAINT CC_SBPCRDDATA_ISVISIBLE CHECK (is_visible in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SBPCRDDATA_ISCHECKABLE ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_CREDITDATA ADD CONSTRAINT CC_SBPCRDDATA_ISCHECKABLE CHECK (is_checkable in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_SBPCRDORD ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_CREDITDATA ADD CONSTRAINT UK_SBPCRDORD UNIQUE (SUBPRODUCT_ID, CRDDATA_ID, ORD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SBPCRDDATA ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_CREDITDATA ADD CONSTRAINT PK_SBPCRDDATA PRIMARY KEY (SUBPRODUCT_ID, CRDDATA_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177302 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_CREDITDATA MODIFY (ORD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177301 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_CREDITDATA MODIFY (GROUP_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177300 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_CREDITDATA MODIFY (IS_READONLY NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177299 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_CREDITDATA MODIFY (IS_CHECKABLE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177298 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_CREDITDATA MODIFY (IS_VISIBLE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177297 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_CREDITDATA MODIFY (QUESTION_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177296 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_CREDITDATA MODIFY (CRDDATA_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003177295 ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_CREDITDATA MODIFY (SUBPRODUCT_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SBPCRDDATA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SBPCRDDATA ON BARS.WCS_SUBPRODUCT_CREDITDATA (SUBPRODUCT_ID, CRDDATA_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_SBPCRDORD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_SBPCRDORD ON BARS.WCS_SUBPRODUCT_CREDITDATA (SUBPRODUCT_ID, CRDDATA_ID, ORD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCT_CREDITDATA.sql ========
PROMPT ===================================================================================== 
