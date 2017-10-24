

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_REF_SEL_TRANS.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_REF_SEL_TRANS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_REF_SEL_TRANS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_REF_SEL_TRANS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_REF_SEL_TRANS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_REF_SEL_TRANS ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_REF_SEL_TRANS 
   (	FILE_ID NUMBER(12,0), 
	ACC_NUM_DB VARCHAR2(15), 
	OB22_DB CHAR(2), 
	ACC_TYPE_DB CHAR(3), 
	ACC_NUM_CR VARCHAR2(15), 
	OB22_CR CHAR(2), 
	ACC_TYPE_CR CHAR(3), 
	KV NUMBER(3,0), 
	TT CHAR(3), 
	MFO VARCHAR2(6), 
	COMM VARCHAR2(250), 
	PR_DEL NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_REF_SEL_TRANS ***
 exec bpa.alter_policies('NBUR_REF_SEL_TRANS');


COMMENT ON TABLE BARS.NBUR_REF_SEL_TRANS IS '������� ��� ������ �������� ��� ��������� �����';
COMMENT ON COLUMN BARS.NBUR_REF_SEL_TRANS.FILE_ID IS 'I������i����� �����';
COMMENT ON COLUMN BARS.NBUR_REF_SEL_TRANS.ACC_NUM_DB IS '����� ������� �� ������';
COMMENT ON COLUMN BARS.NBUR_REF_SEL_TRANS.OB22_DB IS 'OB22 ������� �� ������';
COMMENT ON COLUMN BARS.NBUR_REF_SEL_TRANS.ACC_TYPE_DB IS '��� ������� �� ������';
COMMENT ON COLUMN BARS.NBUR_REF_SEL_TRANS.ACC_NUM_CR IS '����� ������� �� �������';
COMMENT ON COLUMN BARS.NBUR_REF_SEL_TRANS.OB22_CR IS 'OB22 ������� �� �������';
COMMENT ON COLUMN BARS.NBUR_REF_SEL_TRANS.ACC_TYPE_CR IS '��� ������� �� �������';
COMMENT ON COLUMN BARS.NBUR_REF_SEL_TRANS.KV IS '��� ������ ��������';
COMMENT ON COLUMN BARS.NBUR_REF_SEL_TRANS.TT IS '��� ��������';
COMMENT ON COLUMN BARS.NBUR_REF_SEL_TRANS.MFO IS '��� ���';
COMMENT ON COLUMN BARS.NBUR_REF_SEL_TRANS.COMM IS '��������';
COMMENT ON COLUMN BARS.NBUR_REF_SEL_TRANS.PR_DEL IS '������ ��������� (=1 - ����������� ������ � �������)';




PROMPT *** Create  constraint FK_REFSELTRANS_REFFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_SEL_TRANS ADD CONSTRAINT FK_REFSELTRANS_REFFILES FOREIGN KEY (FILE_ID)
	  REFERENCES BARS.NBUR_REF_FILES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0084972 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_REF_SEL_TRANS MODIFY (FILE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_NBUR_REF_SEL_TRANS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_NBUR_REF_SEL_TRANS ON BARS.NBUR_REF_SEL_TRANS (FILE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_REF_SEL_TRANS ***
grant SELECT                                                                 on NBUR_REF_SEL_TRANS to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_REF_SEL_TRANS.sql =========*** En
PROMPT ===================================================================================== 
