

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_DEBT_KLB.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAY_DEBT_KLB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAY_DEBT_KLB'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ZAY_DEBT_KLB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAY_DEBT_KLB ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAY_DEBT_KLB 
   (	RNK NUMBER, 
	DATZ DATE, 
	KV2 NUMBER, 
	S2 NUMBER, 
	KURS_Z NUMBER(10,8), 
	ACC0 NUMBER, 
	MFO0 VARCHAR2(12), 
	NLS0 VARCHAR2(15), 
	OKPO0 VARCHAR2(10), 
	FNAMEKB VARCHAR2(12), 
	IDENTKB VARCHAR2(16), 
	TIPKB NUMBER(*,0), 
	DATEDOKKB DATE, 
	ND VARCHAR2(10), 
	DATT DATE, 
	FL_KURSZ NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAY_DEBT_KLB ***
 exec bpa.alter_policies('ZAY_DEBT_KLB');


COMMENT ON TABLE BARS.ZAY_DEBT_KLB IS '';
COMMENT ON COLUMN BARS.ZAY_DEBT_KLB.RNK IS '���.� �������';
COMMENT ON COLUMN BARS.ZAY_DEBT_KLB.DATZ IS '���� ������';
COMMENT ON COLUMN BARS.ZAY_DEBT_KLB.KV2 IS '������ ������';
COMMENT ON COLUMN BARS.ZAY_DEBT_KLB.S2 IS '����� ������';
COMMENT ON COLUMN BARS.ZAY_DEBT_KLB.KURS_Z IS '���� ���������� (�������)';
COMMENT ON COLUMN BARS.ZAY_DEBT_KLB.ACC0 IS '���� ������� � ����� ����� ��� ���������� ���������� ���';
COMMENT ON COLUMN BARS.ZAY_DEBT_KLB.MFO0 IS '��� ����� ��� ���������� ���';
COMMENT ON COLUMN BARS.ZAY_DEBT_KLB.NLS0 IS '���� ������� � ����� ����� ��� ���������� ���������� ���';
COMMENT ON COLUMN BARS.ZAY_DEBT_KLB.OKPO0 IS '���� ������� ��� ���������� ���������� ���';
COMMENT ON COLUMN BARS.ZAY_DEBT_KLB.FNAMEKB IS '��� ����� ������, �������� �� ������-�����';
COMMENT ON COLUMN BARS.ZAY_DEBT_KLB.IDENTKB IS '������������� ������, �������� �� ������-�����';
COMMENT ON COLUMN BARS.ZAY_DEBT_KLB.TIPKB IS '��� ��������� �� ������-�����';
COMMENT ON COLUMN BARS.ZAY_DEBT_KLB.DATEDOKKB IS '���� ������ ��������� �� ������-�����';
COMMENT ON COLUMN BARS.ZAY_DEBT_KLB.ND IS '����� ���������, ������������ �� ������-�����';
COMMENT ON COLUMN BARS.ZAY_DEBT_KLB.DATT IS '��������� ���� �������� ������';
COMMENT ON COLUMN BARS.ZAY_DEBT_KLB.FL_KURSZ IS '';



PROMPT *** Create  grants  ZAY_DEBT_KLB ***
grant DELETE,INSERT,SELECT                                                   on ZAY_DEBT_KLB    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAY_DEBT_KLB    to START1;
grant INSERT                                                                 on ZAY_DEBT_KLB    to TECH_MOM1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ZAY_DEBT_KLB    to WR_ALL_RIGHTS;
grant DELETE,SELECT                                                          on ZAY_DEBT_KLB    to ZAY;



PROMPT *** Create SYNONYM  to ZAY_DEBT_KLB ***

  CREATE OR REPLACE PUBLIC SYNONYM ZAY_DEBT_KLB FOR BARS.ZAY_DEBT_KLB;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAY_DEBT_KLB.sql =========*** End *** 
PROMPT ===================================================================================== 
