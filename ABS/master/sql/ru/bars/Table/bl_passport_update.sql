

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BL_PASSPORT_UPDATE.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BL_PASSPORT_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BL_PASSPORT_UPDATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BL_PASSPORT_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BL_PASSPORT_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.BL_PASSPORT_UPDATE 
   (	PASSPORT_ID NUMBER, 
	PERSON_ID NUMBER, 
	PASS_SER VARCHAR2(10), 
	PASS_NUM VARCHAR2(6), 
	PASS_DATE DATE, 
	PASS_OFFICE VARCHAR2(300), 
	PASS_REGION VARCHAR2(30), 
	INS_DATE DATE, 
	USER_ID NUMBER, 
	BASE_ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BL_PASSPORT_UPDATE ***
 exec bpa.alter_policies('BL_PASSPORT_UPDATE');


COMMENT ON TABLE BARS.BL_PASSPORT_UPDATE IS '��������� � ���������� ������ ������';
COMMENT ON COLUMN BARS.BL_PASSPORT_UPDATE.PASSPORT_ID IS '���������� �������������';
COMMENT ON COLUMN BARS.BL_PASSPORT_UPDATE.PERSON_ID IS 'Link to BL_PERSON. �� ���������� �������������.';
COMMENT ON COLUMN BARS.BL_PASSPORT_UPDATE.PASS_SER IS '����� ��������. ��������� � ������� ��������.';
COMMENT ON COLUMN BARS.BL_PASSPORT_UPDATE.PASS_NUM IS '����� ��������, � �������� ������.';
COMMENT ON COLUMN BARS.BL_PASSPORT_UPDATE.PASS_DATE IS '���� ������ ��������';
COMMENT ON COLUMN BARS.BL_PASSPORT_UPDATE.PASS_OFFICE IS '��� ����� �������';
COMMENT ON COLUMN BARS.BL_PASSPORT_UPDATE.PASS_REGION IS '������ ������ ��������';
COMMENT ON COLUMN BARS.BL_PASSPORT_UPDATE.INS_DATE IS '���� ���������� ������.';
COMMENT ON COLUMN BARS.BL_PASSPORT_UPDATE.USER_ID IS '��� ������������';
COMMENT ON COLUMN BARS.BL_PASSPORT_UPDATE.BASE_ID IS '';




PROMPT *** Create  constraint NN_BL_PASSPORT_USER_UPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_PASSPORT_UPDATE MODIFY (USER_ID CONSTRAINT NN_BL_PASSPORT_USER_UPD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_PASSPORT_PASS_NUM_UPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_PASSPORT_UPDATE MODIFY (PASS_NUM CONSTRAINT NN_BL_PASSPORT_PASS_NUM_UPD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_PASSPORT_PASS_SER_UPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_PASSPORT_UPDATE MODIFY (PASS_SER CONSTRAINT NN_BL_PASSPORT_PASS_SER_UPD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_PASSPORT_PERSON_ID_UPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_PASSPORT_UPDATE MODIFY (PERSON_ID CONSTRAINT NN_BL_PASSPORT_PERSON_ID_UPD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_PASSPORT_ID_UPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_PASSPORT_UPDATE MODIFY (PASSPORT_ID CONSTRAINT NN_BL_PASSPORT_ID_UPD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index BL_PASSPORT_PERS_UPD ***
begin   
 execute immediate '
  CREATE INDEX BARS.BL_PASSPORT_PERS_UPD ON BARS.BL_PASSPORT_UPDATE (PERSON_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index BL_PASSPORT_PASS_UPD ***
begin   
 execute immediate '
  CREATE INDEX BARS.BL_PASSPORT_PASS_UPD ON BARS.BL_PASSPORT_UPDATE (PASSPORT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BL_PASSPORT_UPDATE ***
grant INSERT,SELECT                                                          on BL_PASSPORT_UPDATE to RBL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BL_PASSPORT_UPDATE.sql =========*** En
PROMPT ===================================================================================== 
