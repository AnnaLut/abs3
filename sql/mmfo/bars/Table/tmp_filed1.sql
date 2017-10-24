

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_FILED1.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_FILED1 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_FILED1 ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_FILED1 
   (	Z_DATE DATE, 
	N_SYSTEM NUMBER(*,0), 
	N_PP NUMBER(10,0), 
	RNK NUMBER(*,0), 
	ID_KOD NUMBER(12,0), 
	NMK VARCHAR2(35), 
	COUNTRY NUMBER(*,0), 
	RIZIK CHAR(1), 
	TK CHAR(1), 
	KODI CHAR(1), 
	NUMDOC CHAR(10), 
	KO NUMBER, 
	NLS VARCHAR2(15), 
	KV NUMBER, 
	DAT_PD DATE
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_FILED1 ***
 exec bpa.alter_policies('TMP_FILED1');


COMMENT ON TABLE BARS.TMP_FILED1 IS '��������� ������� ��� ������������� ������������ � ��������� �����';
COMMENT ON COLUMN BARS.TMP_FILED1.Z_DATE IS '��i��� ����';
COMMENT ON COLUMN BARS.TMP_FILED1.N_SYSTEM IS '��� �������';
COMMENT ON COLUMN BARS.TMP_FILED1.N_PP IS 'N �/�';
COMMENT ON COLUMN BARS.TMP_FILED1.RNK IS '��� �����������';
COMMENT ON COLUMN BARS.TMP_FILED1.ID_KOD IS '��� ����';
COMMENT ON COLUMN BARS.TMP_FILED1.NMK IS '����� �����������';
COMMENT ON COLUMN BARS.TMP_FILED1.COUNTRY IS '��� �����';
COMMENT ON COLUMN BARS.TMP_FILED1.RIZIK IS '��� ������';
COMMENT ON COLUMN BARS.TMP_FILED1.TK IS '��� �����������';
COMMENT ON COLUMN BARS.TMP_FILED1.KODI IS '��� i������i���i�';
COMMENT ON COLUMN BARS.TMP_FILED1.NUMDOC IS '����� ���������';
COMMENT ON COLUMN BARS.TMP_FILED1.KO IS '��� ������� (��� ����������)';
COMMENT ON COLUMN BARS.TMP_FILED1.NLS IS '�������� �������';
COMMENT ON COLUMN BARS.TMP_FILED1.KV IS '��� ������';
COMMENT ON COLUMN BARS.TMP_FILED1.DAT_PD IS '���� ���������� ����';



PROMPT *** Create  grants  TMP_FILED1 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_FILED1      to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_FILED1      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_FILED1      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_FILED1      to RPBN002;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_FILED1      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_FILED1.sql =========*** End *** ==
PROMPT ===================================================================================== 
