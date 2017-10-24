

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_DAT_UPDATE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_DAT_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_DAT_UPDATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_DAT_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_DAT_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_DAT_UPDATE 
   (	ID NUMBER, 
	NPP NUMBER, 
	DOK DATE, 
	KUP NUMBER, 
	CHG_DATE DATE, 
	ACTION CHAR(1), 
	NOM NUMBER(12,2), 
	IDUPD NUMBER(15,0), 
	DONEBY NUMBER(10,0), 
	EFFECTDATE DATE, 
	EXPIRY_DATE DATE, 
	IR NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_DAT_UPDATE ***
 exec bpa.alter_policies('CP_DAT_UPDATE');


COMMENT ON TABLE BARS.CP_DAT_UPDATE IS '������� ��������� ������ ����������� CP_DAT';
COMMENT ON COLUMN BARS.CP_DAT_UPDATE.EXPIRY_DATE IS '';
COMMENT ON COLUMN BARS.CP_DAT_UPDATE.IR IS '��������� ���� ��������� ������ � �����';
COMMENT ON COLUMN BARS.CP_DAT_UPDATE.ID IS '��������� ����� ������';
COMMENT ON COLUMN BARS.CP_DAT_UPDATE.NPP IS '����� ������';
COMMENT ON COLUMN BARS.CP_DAT_UPDATE.DOK IS '���� ���������';
COMMENT ON COLUMN BARS.CP_DAT_UPDATE.KUP IS '����� � ��������(������� ��������)';
COMMENT ON COLUMN BARS.CP_DAT_UPDATE.CHG_DATE IS '���� ��������� ���������';
COMMENT ON COLUMN BARS.CP_DAT_UPDATE.ACTION IS '��� ��������� - U(��������� �����), I(������� ������)';
COMMENT ON COLUMN BARS.CP_DAT_UPDATE.NOM IS '��������� �������';
COMMENT ON COLUMN BARS.CP_DAT_UPDATE.IDUPD IS '';
COMMENT ON COLUMN BARS.CP_DAT_UPDATE.DONEBY IS '����� ���';
COMMENT ON COLUMN BARS.CP_DAT_UPDATE.EFFECTDATE IS '��������� ���� ���';




PROMPT *** Create  constraint CC_CPDAT_IDUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DAT_UPDATE MODIFY (IDUPD CONSTRAINT CC_CPDAT_IDUPD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XUK_CPDATUPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_DAT_UPDATE ADD CONSTRAINT XUK_CPDATUPD UNIQUE (ID, DOK, KUP, CHG_DATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XUK_CPDATUPD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XUK_CPDATUPD ON BARS.CP_DAT_UPDATE (ID, DOK, KUP, CHG_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XAK_CPDATUPD ***
begin   
 execute immediate '
  CREATE INDEX BARS.XAK_CPDATUPD ON BARS.CP_DAT_UPDATE (ID, CHG_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_DAT_UPDATE.sql =========*** End ***
PROMPT ===================================================================================== 
