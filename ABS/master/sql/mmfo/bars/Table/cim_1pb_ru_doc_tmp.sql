

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_1PB_RU_DOC_TMP.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_1PB_RU_DOC_TMP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_1PB_RU_DOC_TMP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_1PB_RU_DOC_TMP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_1PB_RU_DOC_TMP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_1PB_RU_DOC_TMP ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.CIM_1PB_RU_DOC_TMP 
   (	REF_CA NUMBER(38,0), 
	KF VARCHAR2(6), 
	REF_RU NUMBER(38,0), 
	VDAT DATE, 
	KV NUMBER(3,0), 
	S NUMBER(24,2), 
	MFOA VARCHAR2(6), 
	MFOB VARCHAR2(6), 
	NLSA VARCHAR2(15), 
	NLSB VARCHAR2(15), 
	NAZN_RU VARCHAR2(160), 
	KOD_N_CA VARCHAR2(12), 
	KOD_N_RU VARCHAR2(12), 
	CL_TYPE VARCHAR2(1), 
	CL_IPN VARCHAR2(14), 
	CL_NAME VARCHAR2(70)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_1PB_RU_DOC_TMP ***
 exec bpa.alter_policies('CIM_1PB_RU_DOC_TMP');


COMMENT ON TABLE BARS.CIM_1PB_RU_DOC_TMP IS '��������� ������� ��������� �� ����� �������� 2909 (��� 1��)';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC_TMP.REF_CA IS '';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC_TMP.KF IS '��� ��';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC_TMP.REF_RU IS '�������� ��';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC_TMP.VDAT IS '���� �����������';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC_TMP.KV IS '��� ������';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC_TMP.S IS '����';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC_TMP.MFOA IS '��� ������� �����������';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC_TMP.MFOB IS '��� ������� �����������';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC_TMP.NLSA IS '������� �����������';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC_TMP.NLSB IS '������� �����������';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC_TMP.NAZN_RU IS '����������� ������� (� ��)';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC_TMP.KOD_N_CA IS '��� ����������� (� ��)';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC_TMP.KOD_N_RU IS '��� ����������� (� ��)';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC_TMP.CL_TYPE IS '��� �볺���';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC_TMP.CL_IPN IS '��� �볺���';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC_TMP.CL_NAME IS '����� �볺���';



PROMPT *** Create  grants  CIM_1PB_RU_DOC_TMP ***
grant SELECT                                                                 on CIM_1PB_RU_DOC_TMP to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_1PB_RU_DOC_TMP to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_1PB_RU_DOC_TMP to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_1PB_RU_DOC_TMP to CIM_ROLE;
grant SELECT                                                                 on CIM_1PB_RU_DOC_TMP to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_1PB_RU_DOC_TMP.sql =========*** En
PROMPT ===================================================================================== 
