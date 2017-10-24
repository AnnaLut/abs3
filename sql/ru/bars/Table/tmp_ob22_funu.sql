

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OB22_FUNU.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OB22_FUNU ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OB22_FUNU ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_OB22_FUNU 
   (	PRIZN CHAR(1), 
	PRIZN_D CHAR(1), 
	ACCD NUMBER, 
	NLSN_D VARCHAR2(15), 
	OB22_D VARCHAR2(2), 
	PRIZN_K CHAR(1), 
	ACCK NUMBER, 
	NLSN_K VARCHAR2(15), 
	OB22_K VARCHAR2(2), 
	FDAT DATE, 
	REF NUMBER, 
	NLSD VARCHAR2(15), 
	NLSK VARCHAR2(15), 
	S NUMBER, 
	NAZN VARCHAR2(160), 
	NMSN VARCHAR2(70), 
	VOB NUMBER, 
	VDAT DATE, 
	STMT NUMBER, 
	OTM NUMBER(*,0), 
	TT CHAR(3), 
	P080_D VARCHAR2(4), 
	P080_K VARCHAR2(4)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OB22_FUNU ***
 exec bpa.alter_policies('TMP_OB22_FUNU');


COMMENT ON TABLE BARS.TMP_OB22_FUNU IS '';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.P080_D IS '';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.P080_K IS '';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.PRIZN IS '������ ���� ��������_ ��������';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.PRIZN_D IS '������ ���� ��������_ ��';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.ACCD IS 'ID ������� �� ��';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.NLSN_D IS '������� �� ��';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.OB22_D IS '��22 ��';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.PRIZN_K IS '������ ���� ��������_ ��';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.ACCK IS 'ID ������� �� ��';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.NLSN_K IS '������� �� ��';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.OB22_K IS '��22 ��';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.FDAT IS '���� ������';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.REF IS '��������';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.NLSD IS '������� �� ��';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.NLSK IS '������� �� ��';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.S IS '����';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.NAZN IS '����������� �������';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.NMSN IS '����� ���������';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.VOB IS '��� ���������';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.VDAT IS '���� ����������� (�� Oper)';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.STMT IS '�� ��������';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.OTM IS '�_��_��� �������';
COMMENT ON COLUMN BARS.TMP_OB22_FUNU.TT IS '��� ������_�';




PROMPT *** Create  index UK_TMP_OB22_FUNU ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_TMP_OB22_FUNU ON BARS.TMP_OB22_FUNU (REF, STMT) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_OB22_FUNU ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_OB22_FUNU   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_OB22_FUNU   to NALOG;



PROMPT *** Create SYNONYM  to TMP_OB22_FUNU ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_OB22_FUNU FOR BARS.TMP_OB22_FUNU;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OB22_FUNU.sql =========*** End ***
PROMPT ===================================================================================== 
