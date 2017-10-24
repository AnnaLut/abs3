

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_SSP_V.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_SSP_V ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_SSP_V ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_SSP_V 
   (	MFOA VARCHAR2(12), 
	NLSA VARCHAR2(15), 
	MFOB VARCHAR2(12), 
	NLSB VARCHAR2(15), 
	DK NUMBER, 
	S NUMBER, 
	VOB NUMBER, 
	ND CHAR(10), 
	KV NUMBER, 
	DATD DATE, 
	DATP DATE, 
	NAM_A VARCHAR2(38), 
	NAM_B VARCHAR2(38), 
	NAZN VARCHAR2(160), 
	D_REC VARCHAR2(60), 
	NAZNK CHAR(3), 
	NAZNS CHAR(2), 
	ID_A VARCHAR2(14), 
	ID_B VARCHAR2(14), 
	REF_A VARCHAR2(9), 
	ID_O VARCHAR2(6), 
	BIS NUMBER, 
	RESERVED VARCHAR2(8), 
	SIGN RAW(128), 
	TRANS_ID VARCHAR2(12), 
	TRANS_LN NUMBER(*,0), 
	SRC CHAR(1)
   ) ON COMMIT DELETE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_SSP_V ***
 exec bpa.alter_policies('TMP_SSP_V');


COMMENT ON TABLE BARS.TMP_SSP_V IS '������� ��� ��_��� ������_� � ������� ���';
COMMENT ON COLUMN BARS.TMP_SSP_V.MFOA IS '��� ����� �';
COMMENT ON COLUMN BARS.TMP_SSP_V.NLSA IS '������� ��_���� ����� �';
COMMENT ON COLUMN BARS.TMP_SSP_V.MFOB IS '��� ����� �';
COMMENT ON COLUMN BARS.TMP_SSP_V.NLSB IS '������� ��_���� ����� �';
COMMENT ON COLUMN BARS.TMP_SSP_V.DK IS '������ "�����-������" ���������';
COMMENT ON COLUMN BARS.TMP_SSP_V.S IS '���� �������';
COMMENT ON COLUMN BARS.TMP_SSP_V.VOB IS '������� �������� ��� ���������';
COMMENT ON COLUMN BARS.TMP_SSP_V.ND IS '����� (������_����) �������';
COMMENT ON COLUMN BARS.TMP_SSP_V.KV IS '������ �������';
COMMENT ON COLUMN BARS.TMP_SSP_V.DATD IS '���� ����_����� ���������';
COMMENT ON COLUMN BARS.TMP_SSP_V.DATP IS '���� ����������� ����_����� ��������� �� ����� �';
COMMENT ON COLUMN BARS.TMP_SSP_V.NAM_A IS '������������ ��_���� �';
COMMENT ON COLUMN BARS.TMP_SSP_V.NAM_B IS '������������ ��_���� �';
COMMENT ON COLUMN BARS.TMP_SSP_V.NAZN IS '����������� �������';
COMMENT ON COLUMN BARS.TMP_SSP_V.D_REC IS '�����_��_ ����_����';
COMMENT ON COLUMN BARS.TMP_SSP_V.NAZNK IS '������';
COMMENT ON COLUMN BARS.TMP_SSP_V.NAZNS IS '����_� ���������� ����_���_� 14-15';
COMMENT ON COLUMN BARS.TMP_SSP_V.ID_A IS '_������_���_���� ��� ��_���� �';
COMMENT ON COLUMN BARS.TMP_SSP_V.ID_B IS '_������_���_���� ��� ��_���� �';
COMMENT ON COLUMN BARS.TMP_SSP_V.REF_A IS '��_������� _������_����� ��������� � ���';
COMMENT ON COLUMN BARS.TMP_SSP_V.ID_O IS '_������_����� ������_��_��� ����� �';
COMMENT ON COLUMN BARS.TMP_SSP_V.BIS IS '����� ����� �_�';
COMMENT ON COLUMN BARS.TMP_SSP_V.RESERVED IS '������';
COMMENT ON COLUMN BARS.TMP_SSP_V.SIGN IS '��� �������� ����_���_� �������';
COMMENT ON COLUMN BARS.TMP_SSP_V.TRANS_ID IS '_������_����� ��������_�';
COMMENT ON COLUMN BARS.TMP_SSP_V.TRANS_LN IS '���������� ����� _� � �����_ 1.08';
COMMENT ON COLUMN BARS.TMP_SSP_V.SRC IS '������ ������� ���������: A-���.���.,B-�_��.���.,a-���.�_�.,b-�_��.�_�.';




PROMPT *** Create  constraint CC_TMP_SSP_V_SRC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SSP_V MODIFY (SRC CONSTRAINT CC_TMP_SSP_V_SRC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMP_SSP_V_TRANS_LN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SSP_V MODIFY (TRANS_LN CONSTRAINT CC_TMP_SSP_V_TRANS_LN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMP_SSP_V_TRANS_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_SSP_V MODIFY (TRANS_ID CONSTRAINT CC_TMP_SSP_V_TRANS_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_SSP_V ***
grant INSERT                                                                 on TMP_SSP_V       to BARS_ACCESS_DEFROLE;
grant INSERT                                                                 on TMP_SSP_V       to TOSS;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_SSP_V       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_SSP_V.sql =========*** End *** ===
PROMPT ===================================================================================== 
