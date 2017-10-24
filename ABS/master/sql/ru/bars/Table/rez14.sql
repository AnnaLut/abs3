

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ14.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ14 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ14'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REZ14'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ14 ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ14 
   (	MFO VARCHAR2(6), 
	RNK NUMBER, 
	ND NUMBER, 
	KV NUMBER(*,0), 
	Z14 NUMBER, 
	P14 NUMBER, 
	Z15 NUMBER, 
	P15 NUMBER, 
	EVENT NUMBER(*,0), 
	REF NUMBER, 
	P152 NUMBER, 
	Z14N NUMBER, 
	Z15N NUMBER, 
	PF NUMBER(*,0), 
	V14 NUMBER, 
	V15 NUMBER, 
	V14N NUMBER, 
	V15N NUMBER, 
	VIDD NUMBER, 
	NZ15 NUMBER, 
	NV15 NUMBER, 
	QZ15 NUMBER, 
	QV15 NUMBER, 
	NZ15U NUMBER, 
	NV15U NUMBER, 
	QZ15U NUMBER, 
	QV15U NUMBER, 
	Z14U NUMBER, 
	V14U NUMBER, 
	REF15 NUMBER, 
	BVQ14 NUMBER, 
	BVQ15 NUMBER, 
	B9Q14 NUMBER, 
	B9Q15 NUMBER, 
	REFP14 NUMBER, 
	REFP15 NUMBER, 
	REF152 NUMBER, 
	P153 NUMBER, 
	REF153 NUMBER, 
	TIPA NUMBER, 
	NLS VARCHAR2(15), 
	ID VARCHAR2(15)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZ14 ***
 exec bpa.alter_policies('REZ14');


COMMENT ON TABLE BARS.REZ14 IS '�������������� �������� �� ���� �� 2014 + 2015.1 ����';
COMMENT ON COLUMN BARS.REZ14.MFO IS '��� ��� ��';
COMMENT ON COLUMN BARS.REZ14.RNK IS '��� ��';
COMMENT ON COLUMN BARS.REZ14.ND IS '��� ��';
COMMENT ON COLUMN BARS.REZ14.KV IS '��� ���';
COMMENT ON COLUMN BARS.REZ14.Z14 IS '�����(���)-39 31.12.2014,���';
COMMENT ON COLUMN BARS.REZ14.P14 IS '��������~ %%~31.12.2014~���.~P14';
COMMENT ON COLUMN BARS.REZ14.Z15 IS '�����(���)-39 30.06.2015,���';
COMMENT ON COLUMN BARS.REZ14.P15 IS '��������~ %%~30.06.2015~���.~P15';
COMMENT ON COLUMN BARS.REZ14.EVENT IS '������.�����';
COMMENT ON COLUMN BARS.REZ14.REF IS '��� ��������~ � ���~���-2014';
COMMENT ON COLUMN BARS.REZ14.P152 IS '����.~����� %%~30.11.2015~���.~P152';
COMMENT ON COLUMN BARS.REZ14.Z14N IS '�����(���)-23 31.12.2014,���';
COMMENT ON COLUMN BARS.REZ14.Z15N IS '�����(���)-23 30.11.2015,���';
COMMENT ON COLUMN BARS.REZ14.PF IS '�����.�����';
COMMENT ON COLUMN BARS.REZ14.V14 IS '�����(9��)-39 31.12.2014,���';
COMMENT ON COLUMN BARS.REZ14.V15 IS '�����(9��)-39 30.06.2015,���';
COMMENT ON COLUMN BARS.REZ14.V14N IS '�����(9��)-23 31.12.2014,���';
COMMENT ON COLUMN BARS.REZ14.V15N IS '�����(9��)-23 30.11.2015,���';
COMMENT ON COLUMN BARS.REZ14.VIDD IS 'cc_deal.vidd';
COMMENT ON COLUMN BARS.REZ14.NZ15 IS '�����(���)-39 30.06.2015,���';
COMMENT ON COLUMN BARS.REZ14.NV15 IS '�����(9��)-39 30.06.2015,���';
COMMENT ON COLUMN BARS.REZ14.QZ15 IS '�����(���)-39 30.11.2015,���';
COMMENT ON COLUMN BARS.REZ14.QV15 IS '�����(9��)-39 30.11.2015,���';
COMMENT ON COLUMN BARS.REZ14.NZ15U IS '����.�����(���)-39 30.11.2015,���';
COMMENT ON COLUMN BARS.REZ14.NV15U IS '����.�����(9��)-39 30.11.2015,���';
COMMENT ON COLUMN BARS.REZ14.QZ15U IS '����.�����(���)-39 30.11.2015,���';
COMMENT ON COLUMN BARS.REZ14.QV15U IS '����.�����(9��)-39 30.11.2015,���';
COMMENT ON COLUMN BARS.REZ14.Z14U IS '����.�����(���)-39 31.12.2014,���';
COMMENT ON COLUMN BARS.REZ14.V14U IS '����.�����(9��)-39 31.12.2014,���';
COMMENT ON COLUMN BARS.REZ14.REF15 IS '��� ��������~ � ���~���-2015';
COMMENT ON COLUMN BARS.REZ14.BVQ14 IS 'BV (���) �� 31.12.2014,���';
COMMENT ON COLUMN BARS.REZ14.BVQ15 IS 'BV (���) �� 30.11.2015,���';
COMMENT ON COLUMN BARS.REZ14.B9Q14 IS 'BV (9��) �� 31.12.2014,���';
COMMENT ON COLUMN BARS.REZ14.B9Q15 IS 'BV (9��) �� 30.11.2015,���';
COMMENT ON COLUMN BARS.REZ14.REFP14 IS '��� ���~������~���~31.12.2014~REFP14';
COMMENT ON COLUMN BARS.REZ14.REFP15 IS '��� ���~������~���~30.06.2015~REFP15';
COMMENT ON COLUMN BARS.REZ14.REF152 IS '��� ���~������~���~30.11.2015~REF152';
COMMENT ON COLUMN BARS.REZ14.P153 IS '����.~����� %%~31.12.2015~���.~P153';
COMMENT ON COLUMN BARS.REZ14.REF153 IS '��� ���~������~���~31.12.2015~REF153';
COMMENT ON COLUMN BARS.REZ14.TIPA IS '���: 3-cc_deal, 4-bpk, 9 - cp, 8-mbk, 10-ovr, 17-debF';
COMMENT ON COLUMN BARS.REZ14.NLS IS '���.�������';
COMMENT ON COLUMN BARS.REZ14.ID IS 'nbu23_rez.ID';



PROMPT *** Create  grants  REZ14 ***
grant SELECT                                                                 on REZ14           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ14.sql =========*** End *** =======
PROMPT ===================================================================================== 
