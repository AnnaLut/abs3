

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_FINREZ.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_FINREZ ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_FINREZ ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_FINREZ 
   (	FONDID NUMBER, 
	S_OLDF1 NUMBER, 
	SQ_OLDF1 NUMBER, 
	S_OLDF2 NUMBER, 
	SQ_OLDF2 NUMBER, 
	SQ_OLDF3 NUMBER, 
	S_NEWF NUMBER, 
	SQ_NEWF NUMBER, 
	S_DEL NUMBER, 
	SQ_DEL NUMBER, 
	S_ISP NUMBER, 
	SQ_ISP NUMBER, 
	SQ_CURS NUMBER, 
	KV NUMBER, 
	ACC NUMBER, 
	TXT VARCHAR2(200), 
	BRANCH VARCHAR2(30), 
	OB22 CHAR(2), 
	NLS_R VARCHAR2(15), 
	NBSL VARCHAR2(4), 
	S080 NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_FINREZ ***
 exec bpa.alter_policies('TMP_FINREZ');


COMMENT ON TABLE BARS.TMP_FINREZ IS '��������� ���������� ����� � ����� �� �����';
COMMENT ON COLUMN BARS.TMP_FINREZ.SQ_OLDF3 IS '������� �� ������ ����� �� ������� ���� ���������� �� ����� ���������� ���� (��� ����������� ��������� ��������� � �������� ��������)';
COMMENT ON COLUMN BARS.TMP_FINREZ.S_NEWF IS '����� ���� �� ������� TMP_REZ_RISK �������';
COMMENT ON COLUMN BARS.TMP_FINREZ.SQ_NEWF IS '����� ���� �� ������� TMP_REZ_RISK ���������� �� ����� ������� �������� ����';
COMMENT ON COLUMN BARS.TMP_FINREZ.S_DEL IS '������������� ����� �������';
COMMENT ON COLUMN BARS.TMP_FINREZ.SQ_DEL IS '������������� ���� ����������';
COMMENT ON COLUMN BARS.TMP_FINREZ.S_ISP IS '������������ ����� �� ��������� ������������� �������';
COMMENT ON COLUMN BARS.TMP_FINREZ.SQ_ISP IS '������������ ����� �� ��������� ������������� ����������';
COMMENT ON COLUMN BARS.TMP_FINREZ.SQ_CURS IS '�������� ��������� ����������� ����� ��������� � �������� ��������';
COMMENT ON COLUMN BARS.TMP_FINREZ.KV IS '��� ������';
COMMENT ON COLUMN BARS.TMP_FINREZ.ACC IS '';
COMMENT ON COLUMN BARS.TMP_FINREZ.TXT IS '';
COMMENT ON COLUMN BARS.TMP_FINREZ.BRANCH IS '��� �������������� ���������';
COMMENT ON COLUMN BARS.TMP_FINREZ.OB22 IS 'OB22 ����� �������';
COMMENT ON COLUMN BARS.TMP_FINREZ.NLS_R IS '����� ����� �������';
COMMENT ON COLUMN BARS.TMP_FINREZ.NBSL IS '���.�������';
COMMENT ON COLUMN BARS.TMP_FINREZ.S080 IS '���.�����';
COMMENT ON COLUMN BARS.TMP_FINREZ.FONDID IS '��� ���������� (�� REZ_FONDNBS)';
COMMENT ON COLUMN BARS.TMP_FINREZ.S_OLDF1 IS '������� �� ������ ����� �� ���������� ���� �������';
COMMENT ON COLUMN BARS.TMP_FINREZ.SQ_OLDF1 IS '������� �� ������ ����� �� ���������� ���� ���������� �� ����� ���������� ����';
COMMENT ON COLUMN BARS.TMP_FINREZ.S_OLDF2 IS '������� �� ������ ����� �� ������� ���� �������';
COMMENT ON COLUMN BARS.TMP_FINREZ.SQ_OLDF2 IS '������� �� ������ ����� �� ������� ���� ���������� �� ����� ������� ����';



PROMPT *** Create  grants  TMP_FINREZ ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_FINREZ      to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_FINREZ      to RCC_DEAL;



PROMPT *** Create SYNONYM  to TMP_FINREZ ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_FINREZ FOR BARS.TMP_FINREZ;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_FINREZ.sql =========*** End *** ==
PROMPT ===================================================================================== 
