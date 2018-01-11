

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CASHPAYED.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CASHPAYED ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_CASHPAYED'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_CASHPAYED'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_CASHPAYED'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CASHPAYED ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_CASHPAYED 
   (	DATATYPE CHAR(1), 
	REF NUMBER, 
	ACC NUMBER, 
	NLS VARCHAR2(14), 
	KV NUMBER, 
	NMS VARCHAR2(70), 
	OPTYPE NUMBER, 
	S NUMBER, 
	SQ NUMBER, 
	ND VARCHAR2(10), 
	DK NUMBER, 
	SK NUMBER, 
	TT CHAR(3), 
	NAZN VARCHAR2(160), 
	NLSK VARCHAR2(14), 
	KV2 NUMBER, 
	NMSK VARCHAR2(70), 
	LASTVISADAT DATE, 
	LASTVISA_USERID NUMBER, 
	POSTDAT DATE, 
	POST_USERID NUMBER, 
	OSTF NUMBER, 
	OSTFQ NUMBER, 
	OBDB NUMBER, 
	OBKR NUMBER, 
	OBDB_DPT NUMBER, 
	OBKR_DPT NUMBER, 
	OBDBK NUMBER, 
	OBKRK NUMBER, 
	OBDB_DPTK NUMBER, 
	OBKR_DPTK NUMBER, 
	OST NUMBER, 
	STIME DATE, 
	ETIME DATE, 
	IS_OURVISA NUMBER(1,0), 
	IS_DPTDOC NUMBER(1,0), 
	BRANCH VARCHAR2(30), 
	OBDBQ NUMBER, 
	OBKRQ NUMBER, 
	OBDBQ_DPT NUMBER, 
	OBKRQ_DPT NUMBER, 
	OBDBQK NUMBER, 
	OBKRQK NUMBER, 
	OBDBQ_DPTK NUMBER, 
	OBKRQ_DPTK NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_CASHPAYED ***
 exec bpa.alter_policies('TMP_CASHPAYED');


COMMENT ON TABLE BARS.TMP_CASHPAYED IS '��������� ������� ��� ������� ���';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.POSTDAT IS '����� ����� ���������';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.POST_USERID IS '����������, �� ������ ��������';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.OSTF IS '������� �������';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.OSTFQ IS '';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.OBDB IS '������� ������� �� ������� ������i��';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.OBKR IS '������� ���������� �� ������� ������i��';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.OBDB_DPT IS '������� ������� �� ���������� ������i��';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.OBKR_DPT IS '������� ���������� �� ���������� ������i��';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.OBDBK IS '������� ������� �� ������� ������i�� �� ������';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.OBKRK IS '������� ���������� �� ������� ������i�� �� ������';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.OBDB_DPTK IS '������� ������� �� ���������� ������i�� �� ������';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.OBKR_DPTK IS '������� ���������� �� ���������� ������i��';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.OST IS '�������';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.STIME IS '���� ����� ����';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.ETIME IS '���� ���� ����';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.IS_OURVISA IS '1(0)-������� ��� ������ ���� � ������ �������(�� � ������ �������)';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.IS_DPTDOC IS '1-�������� �� ��������, 0 - �������� ��������';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.BRANCH IS '';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.OBDBQ IS '������� ��� ������� �� ������� ������i��';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.OBKRQ IS '������� ��� ���������� �� ������� ������i��';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.OBDBQ_DPT IS '������� ��� ������� �� ���������� ������i��';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.OBKRQ_DPT IS '������� ��� ���������� �� ���������� ������i��';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.OBDBQK IS '������� ��� ������� �� ������� ������i�� �� ������';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.OBKRQK IS '������� ��� ���������� �� ������� ������i�� �� ������';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.OBDBQ_DPTK IS '������� ��� ������� �� ���������� ������i�� �� ������';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.OBKRQ_DPTK IS '������� ��� ���������� �� ���������� ������i��';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.DATATYPE IS '��� ����� 0- ����� ����������, 1-�������, 2 - ������� �� ��������';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.REF IS '';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.ACC IS '';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.NLS IS '';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.KV IS '';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.NMS IS '';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.OPTYPE IS '��� �������� 1-�����������, 0-�������';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.S IS '';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.SQ IS '';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.ND IS '';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.DK IS '';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.SK IS '';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.TT IS '';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.NAZN IS '';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.NLSK IS '�������������� �������';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.KV2 IS '';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.NMSK IS '';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.LASTVISADAT IS '���� �������� ���';
COMMENT ON COLUMN BARS.TMP_CASHPAYED.LASTVISA_USERID IS '����������, �� ��������� ������� ���';



PROMPT *** Create  grants  TMP_CASHPAYED ***
grant SELECT                                                                 on TMP_CASHPAYED   to BARSREADER_ROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on TMP_CASHPAYED   to BARS_ACCESS_DEFROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on TMP_CASHPAYED   to RPBN001;
grant SELECT                                                                 on TMP_CASHPAYED   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_CASHPAYED   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CASHPAYED.sql =========*** End ***
PROMPT ===================================================================================== 
