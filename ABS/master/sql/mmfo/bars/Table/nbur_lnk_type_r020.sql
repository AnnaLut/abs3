

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_LNK_TYPE_R020.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_LNK_TYPE_R020 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_LNK_TYPE_R020'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_LNK_TYPE_R020'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''NBUR_LNK_TYPE_R020'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_LNK_TYPE_R020 ***
begin 
  execute immediate '
  CREATE TABLE BARS.NBUR_LNK_TYPE_R020 
   (	ACC_TYPE VARCHAR2(3), 
	ACC_R020 VARCHAR2(4), 
	START_DATE DATE, 
	FINISH_DATE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_LNK_TYPE_R020 ***
 exec bpa.alter_policies('NBUR_LNK_TYPE_R020');


COMMENT ON TABLE BARS.NBUR_LNK_TYPE_R020 IS '������� ��� ���������� ������� R020 �� ����������� ���� ��� �������';
COMMENT ON COLUMN BARS.NBUR_LNK_TYPE_R020.ACC_TYPE IS '��� ������� ��� �������';
COMMENT ON COLUMN BARS.NBUR_LNK_TYPE_R020.ACC_R020 IS '�������� R020 �������';
COMMENT ON COLUMN BARS.NBUR_LNK_TYPE_R020.START_DATE IS '���� ������� 䳿';
COMMENT ON COLUMN BARS.NBUR_LNK_TYPE_R020.FINISH_DATE IS '���� ��������� 䳿';




PROMPT *** Create  constraint ��_NBURLNKTYPER020_TYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LNK_TYPE_R020 MODIFY (ACC_TYPE CONSTRAINT ��_NBURLNKTYPER020_TYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint ��_NBURLNKTYPER020_R020_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LNK_TYPE_R020 MODIFY (ACC_R020 CONSTRAINT ��_NBURLNKTYPER020_R020_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint ��_NBURLNKTYPER020_DATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LNK_TYPE_R020 MODIFY (START_DATE CONSTRAINT ��_NBURLNKTYPER020_DATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_NBURLNKTYPER020 ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_LNK_TYPE_R020 ADD CONSTRAINT PK_NBURLNKTYPER020 PRIMARY KEY (ACC_TYPE, ACC_R020, START_DATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NBURLNKTYPER020 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NBURLNKTYPER020 ON BARS.NBUR_LNK_TYPE_R020 (ACC_TYPE, ACC_R020, START_DATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_LNK_TYPE_R020 ***
grant SELECT                                                                 on NBUR_LNK_TYPE_R020 to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_LNK_TYPE_R020.sql =========*** En
PROMPT ===================================================================================== 
