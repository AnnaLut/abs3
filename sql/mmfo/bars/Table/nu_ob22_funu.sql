

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NU_OB22_FUNU.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NU_OB22_FUNU ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NU_OB22_FUNU'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NU_OB22_FUNU'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NU_OB22_FUNU ***
begin 
  execute immediate '
  CREATE TABLE BARS.NU_OB22_FUNU 
   (	ID_USER NUMBER, 
	PRIZN CHAR(1), 
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
	VOB NUMBER, 
	VDAT DATE, 
	STMT NUMBER, 
	OTM NUMBER(*,0), 
	TT CHAR(3), 
	KSN_D VARCHAR2(15), 
	KSN_K VARCHAR2(15), 
	NMSN_D VARCHAR2(70), 
	NMSN_K VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NU_OB22_FUNU ***
 exec bpa.alter_policies('NU_OB22_FUNU');


COMMENT ON TABLE BARS.NU_OB22_FUNU IS '';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.ID_USER IS '';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.PRIZN IS '������ ���� ��������_ ��������';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.PRIZN_D IS '������ ���� ��������_ ��';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.ACCD IS 'ID ������� �� ��';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.NLSN_D IS '������� �� ��';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.OB22_D IS '��22 ��';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.PRIZN_K IS '������ ���� ��������_ ��';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.ACCK IS 'ID ������� �� ��';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.NLSN_K IS '������� �� ��';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.OB22_K IS '��22 ��';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.FDAT IS '���� ������';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.REF IS '��������';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.NLSD IS '������� �� ��';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.NLSK IS '������� �� ��';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.S IS '����';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.NAZN IS '����������� �������';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.VOB IS '��� ���������';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.VDAT IS '���� ����������� (�� Oper)';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.STMT IS '�� ��������';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.OTM IS '�_��_��� �������';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.TT IS '��� ������_�';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.KSN_D IS '';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.KSN_K IS '';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.NMSN_D IS '';
COMMENT ON COLUMN BARS.NU_OB22_FUNU.NMSN_K IS '';




PROMPT *** Create  index UK_NU_OB22_FUNU ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_NU_OB22_FUNU ON BARS.NU_OB22_FUNU (ID_USER, REF, STMT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NU_OB22_FUNU ***
grant DELETE,INSERT,SELECT,UPDATE                                            on NU_OB22_FUNU    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on NU_OB22_FUNU    to NALOG;



PROMPT *** Create SYNONYM  to NU_OB22_FUNU ***

  CREATE OR REPLACE PUBLIC SYNONYM NU_OB22_FUNU FOR BARS.NU_OB22_FUNU;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NU_OB22_FUNU.sql =========*** End *** 
PROMPT ===================================================================================== 
