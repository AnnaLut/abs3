

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_HIERARCHY_IDSREFS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_HIERARCHY_IDSREFS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_HIERARCHY_IDSREFS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_HIERARCHY_IDSREFS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_HIERARCHY_IDSREFS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_HIERARCHY_IDSREFS 
   (	ID NUMBER(*,0), 
	DATE_START DATE, 
	DATE_FINISH DATE, 
	HIERARCHY_REP NUMBER(*,0), 
	H1 NUMBER(*,0), 
	H2 NUMBER(*,0), 
	COUNT_START NUMBER, 
	COUNT_END NUMBER, 
	N VARCHAR2(4000), 
	DP VARCHAR2(4000), 
	R VARCHAR2(4000), 
	R2 VARCHAR2(4000), 
	S VARCHAR2(4000), 
	BV VARCHAR2(4000), 
	N_END VARCHAR2(4000), 
	DP_END VARCHAR2(4000), 
	R_END VARCHAR2(4000), 
	R2_END VARCHAR2(4000), 
	S_END VARCHAR2(4000), 
	BV_END VARCHAR2(4000), 
	R_PAY VARCHAR2(4000), 
	R_INT VARCHAR2(4000), 
	TR VARCHAR2(4000), 
	RESERVED VARCHAR2(4000), 
	OVERPRICED VARCHAR2(4000), 
	BOUGHT VARCHAR2(4000), 
	SOLD VARCHAR2(4000), 
	SETTLED VARCHAR2(4000), 
	RECLASS_FROM VARCHAR2(4000), 
	RECLASS_INTO VARCHAR2(4000), 
	PAYEDINT VARCHAR2(4000), 
	RANSOM VARCHAR2(1000), 
	RNK NUMBER, 
	NBS VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_HIERARCHY_IDSREFS ***
 exec bpa.alter_policies('CP_HIERARCHY_IDSREFS');


COMMENT ON TABLE BARS.CP_HIERARCHY_IDSREFS IS '����� �� ������� �������� � ������� ����� ��';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.ID IS 'ID ��';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.DATE_START IS '���� ������ ������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.DATE_FINISH IS '���� ��������� ������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.HIERARCHY_REP IS '������� �������� ��� �����������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.H1 IS '������� �������� �� ������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.H2 IS '������� �������� �� �����';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.COUNT_START IS '���������� ����� �� ������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.COUNT_END IS '���������� ����� �� �����';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.N IS '������� �� ������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.DP IS '�������/������ �� ������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.R IS '����� �� ������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.R2 IS '�����2 �� ������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.S IS '���������� �� ������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.BV IS '���������� ��������� �� ������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.N_END IS '������� �� �����';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.DP_END IS '�������/������ �� �����';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.R_END IS '����� �� �����';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.R2_END IS '�����2 �� �����';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.S_END IS '���������� �� �����';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.BV_END IS '���������� ��������� �� �����';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.R_PAY IS '���������� ����� � �������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.R_INT IS '���������� ������ � �������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.TR IS '�������� ��������� � �������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.RESERVED IS '������� � �������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.OVERPRICED IS '���������� � �������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.BOUGHT IS '������� � �������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.SOLD IS '������� � �������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.SETTLED IS '�������� � �������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.RECLASS_FROM IS '��������������� �� ������ (���.���������)';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.RECLASS_INTO IS '��������������� � ������� (���.���������)';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.PAYEDINT IS '�������� �����';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.RANSOM IS '�����';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.RNK IS '';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDSREFS.NBS IS '';



PROMPT *** Create  grants  CP_HIERARCHY_IDSREFS ***
grant SELECT                                                                 on CP_HIERARCHY_IDSREFS to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CP_HIERARCHY_IDSREFS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_HIERARCHY_IDSREFS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_HIERARCHY_IDSREFS.sql =========*** 
PROMPT ===================================================================================== 
