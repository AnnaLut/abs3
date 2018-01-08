

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BRANCH_OPELOT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BRANCH_OPELOT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BRANCH_OPELOT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BRANCH_OPELOT'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''BRANCH_OPELOT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BRANCH_OPELOT ***
begin 
  execute immediate '
  CREATE TABLE BARS.BRANCH_OPELOT 
   (	BRANCH VARCHAR2(15), 
	OB22 CHAR(2), 
	NAME VARCHAR2(25), 
	PR1 NUMBER(6,4), 
	BS1 CHAR(4), 
	OB1 CHAR(2), 
	PR2 NUMBER(6,4), 
	BS2 CHAR(4), 
	OB2 CHAR(2), 
	PR3 NUMBER(6,4), 
	BS3 CHAR(4), 
	OB3 CHAR(2), 
	MFO VARCHAR2(6), 
	NLS VARCHAR2(14), 
	OKPO VARCHAR2(8), 
	NAZN1 VARCHAR2(160), 
	NAZN2 VARCHAR2(160), 
	DATP DATE, 
	REZ_OB22 CHAR(2), 
	REZ_SUM NUMBER(10,2), 
	PRZ NUMBER(*,0), 
	REF1 NUMBER(*,0), 
	REF2 NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BRANCH_OPELOT ***
 exec bpa.alter_policies('BRANCH_OPELOT');


COMMENT ON TABLE BARS.BRANCH_OPELOT IS '���������� � �i�i��� ��������i� �������';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.REF1 IS '���.������������� ���������';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.REF2 IS '';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.BRANCH IS '����� ��';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.OB22 IS '��� ���������~��22';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.NAME IS '�����~�i�i�~���������';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.PR1 IS '���� 1~%';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.BS1 IS '���� 1~���.���';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.OB1 IS '���� 1~��22';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.PR2 IS '���� 2~%';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.BS2 IS '���� 2~���.���';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.OB2 IS '���� 2~��22';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.PR3 IS '���� 3~%';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.BS3 IS '���� 3~���.���';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.OB3 IS '���� 3~��22';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.MFO IS '��� �����~�i�i�~���������';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.NLS IS '�������~�i�i�~���������';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.OKPO IS 'I�.���~�i�i�~���������';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.NAZN1 IS '����������� ��. ��� ���-1(�����������)';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.NAZN2 IS '����������� ��. ��� ���-2(������������� ����i�)';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.DATP IS '���� ������������ ����������';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.REZ_OB22 IS '��22 ��� 2905 �� ������.�������';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.REZ_SUM IS '����� ������.������a';
COMMENT ON COLUMN BARS.BRANCH_OPELOT.PRZ IS '������� �������� ������ ���(0- �� ����.����, 1 - �� ����)';



PROMPT *** Create  grants  BRANCH_OPELOT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BRANCH_OPELOT   to ABS_ADMIN;
grant SELECT                                                                 on BRANCH_OPELOT   to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BRANCH_OPELOT   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BRANCH_OPELOT   to BARS_DM;
grant SELECT,UPDATE                                                          on BRANCH_OPELOT   to PYOD001;
grant SELECT                                                                 on BRANCH_OPELOT   to UPLD;
grant FLASHBACK,SELECT                                                       on BRANCH_OPELOT   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BRANCH_OPELOT.sql =========*** End ***
PROMPT ===================================================================================== 
