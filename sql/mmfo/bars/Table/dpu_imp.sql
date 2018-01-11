

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPU_IMP.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPU_IMP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPU_IMP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPU_IMP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPU_IMP ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPU_IMP 
   (	NLSD VARCHAR2(14), 
	NLSN VARCHAR2(14), 
	NLS7 VARCHAR2(14), 
	PR NUMBER(20,4), 
	FREQ NUMBER(3,0), 
	COMMPROC NUMBER(1,0), 
	SUM NUMBER(22,2), 
	KV NUMBER(3,0), 
	VIDD NUMBER(38,0), 
	NMK VARCHAR2(70), 
	OKPO VARCHAR2(10), 
	MFO_D VARCHAR2(6), 
	NLS_D VARCHAR2(14), 
	MFO_P VARCHAR2(6), 
	NLS_P VARCHAR2(14), 
	DAT_BEG DATE, 
	DAT_END DATE, 
	DATZ DATE, 
	DATV DATE, 
	BRANCH VARCHAR2(30), 
	NMS_P VARCHAR2(38), 
	OKPO_P VARCHAR2(10), 
	DAT_INT DATE, 
	STATUS NUMBER(1,0), 
	OUT_MSG VARCHAR2(250)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPU_IMP ***
 exec bpa.alter_policies('DPU_IMP');


COMMENT ON TABLE BARS.DPU_IMP IS '������� ��� ������� ������� �� � �������� ��������';
COMMENT ON COLUMN BARS.DPU_IMP.NLSD IS '������� ��� ��������';
COMMENT ON COLUMN BARS.DPU_IMP.NLSN IS '������� %% ��������';
COMMENT ON COLUMN BARS.DPU_IMP.NLS7 IS '������� ������';
COMMENT ON COLUMN BARS.DPU_IMP.PR IS '������ %';
COMMENT ON COLUMN BARS.DPU_IMP.FREQ IS '����������� �������';
COMMENT ON COLUMN BARS.DPU_IMP.COMMPROC IS '������ ����������� %%';
COMMENT ON COLUMN BARS.DPU_IMP.SUM IS '���� ��������';
COMMENT ON COLUMN BARS.DPU_IMP.KV IS '������ ��������';
COMMENT ON COLUMN BARS.DPU_IMP.VIDD IS '��� ��������';
COMMENT ON COLUMN BARS.DPU_IMP.NMK IS '';
COMMENT ON COLUMN BARS.DPU_IMP.OKPO IS '';
COMMENT ON COLUMN BARS.DPU_IMP.MFO_D IS '��� ���������� ��������';
COMMENT ON COLUMN BARS.DPU_IMP.NLS_D IS '������� ���������� ��������';
COMMENT ON COLUMN BARS.DPU_IMP.MFO_P IS '��� ��� ������������� %%';
COMMENT ON COLUMN BARS.DPU_IMP.NLS_P IS '������� ��� ������������� %%';
COMMENT ON COLUMN BARS.DPU_IMP.DAT_BEG IS '���� �������';
COMMENT ON COLUMN BARS.DPU_IMP.DAT_END IS '���� ���������';
COMMENT ON COLUMN BARS.DPU_IMP.DATZ IS '���� ����������(����������) ��������';
COMMENT ON COLUMN BARS.DPU_IMP.DATV IS '���� ����������(�������) ��������';
COMMENT ON COLUMN BARS.DPU_IMP.BRANCH IS '��� �������� ��������';
COMMENT ON COLUMN BARS.DPU_IMP.NMS_P IS '';
COMMENT ON COLUMN BARS.DPU_IMP.OKPO_P IS '';
COMMENT ON COLUMN BARS.DPU_IMP.DAT_INT IS '���� �� ��� ������� ���������� %%';
COMMENT ON COLUMN BARS.DPU_IMP.STATUS IS '������ (1 - ������������)';
COMMENT ON COLUMN BARS.DPU_IMP.OUT_MSG IS '������� �����������';



PROMPT *** Create  grants  DPU_IMP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_IMP         to ABS_ADMIN;
grant SELECT                                                                 on DPU_IMP         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_IMP         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPU_IMP         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_IMP         to DPT_ADMIN;
grant SELECT                                                                 on DPU_IMP         to START1;
grant SELECT                                                                 on DPU_IMP         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPU_IMP.sql =========*** End *** =====
PROMPT ===================================================================================== 
