

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_ARC.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_VIDD_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_VIDD_ARC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_VIDD_ARC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_VIDD_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_VIDD_ARC 
   (	VIDD NUMBER(38,0), 
	DEPOSIT_COD VARCHAR2(4), 
	TYPE_NAME VARCHAR2(50), 
	BASEY NUMBER(*,0) DEFAULT 0, 
	BASEM NUMBER(*,0) DEFAULT 0, 
	BR_ID NUMBER(38,0), 
	FREQ_N NUMBER(3,0) DEFAULT 1, 
	FREQ_K NUMBER(3,0), 
	BSD CHAR(4), 
	BSN CHAR(4), 
	METR NUMBER(1,0) DEFAULT 0, 
	AMR_METR NUMBER DEFAULT 0, 
	DURATION NUMBER(10,0) DEFAULT 0, 
	TERM_TYPE NUMBER DEFAULT 1, 
	MIN_SUMM NUMBER(24,0), 
	COMMENTS VARCHAR2(128), 
	FLAG NUMBER(1,0) DEFAULT 0, 
	TYPE_COD VARCHAR2(4), 
	KV NUMBER(3,0), 
	TT CHAR(3), 
	SHABLON VARCHAR2(15), 
	IDG NUMBER(38,0), 
	IDS NUMBER(38,0), 
	NLS_K VARCHAR2(15), 
	DATN DATE, 
	DATK DATE, 
	BR_ID_L NUMBER(38,0), 
	FL_DUBL NUMBER(1,0) DEFAULT 0, 
	ACC7 NUMBER(38,0), 
	ID_STOP NUMBER(38,0) DEFAULT 0, 
	KODZ NUMBER(38,0), 
	FMT NUMBER(2,0), 
	FL_2620 NUMBER(1,0) DEFAULT 0, 
	COMPROC NUMBER(1,0) DEFAULT 0, 
	LIMIT NUMBER(24,0), 
	TERM_ADD NUMBER(7,2), 
	TERM_DUBL NUMBER(10,0) DEFAULT 0, 
	DURATION_DAYS NUMBER(10,0) DEFAULT 0, 
	EXTENSION_ID NUMBER(38,0), 
	TIP_OST NUMBER(1,0) DEFAULT 1, 
	BR_WD NUMBER(38,0), 
	NLSN_K VARCHAR2(14), 
	BSA CHAR(4), 
	MAX_LIMIT NUMBER(24,0), 
	BR_BONUS NUMBER(38,0) DEFAULT 0, 
	BR_OP NUMBER(38,0) DEFAULT 0, 
	AUTO_ADD NUMBER(1,0) DEFAULT 0, 
	TYPE_ID NUMBER(38,0) DEFAULT 0, 
	DISABLE_ADD NUMBER(1,0), 
	CODE_TARIFF NUMBER(38,0), 
	DURATION_MAX NUMBER(3,0), 
	DURATION_DAYS_MAX NUMBER(3,0), 
	IRREVOCABLE NUMBER(1,0) DEFAULT 1, 
	DATE_OFF DATE DEFAULT sysdate, 
	USER_OFF NUMBER(38,0) DEFAULT sys_context(''bars_context'',''user_id'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_VIDD_ARC ***
 exec bpa.alter_policies('DPT_VIDD_ARC');


COMMENT ON TABLE BARS.DPT_VIDD_ARC IS '���� ������ (�����)';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.VIDD IS '��� ���� ������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.DEPOSIT_COD IS '�� ���.';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.TYPE_NAME IS '������������ ���� ������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.BASEY IS '��� �������� ����';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.BASEM IS '������� ������.%-��� ������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.BR_ID IS '��� ������� ���������� ������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.FREQ_N IS '������������� ���������� %%';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.FREQ_K IS '������������� ������� %%';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.BSD IS '���������� ���� ��������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.BSN IS '���������� ���� ����������� ���������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.METR IS '��� ������ ���������� ���������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.AMR_METR IS '����� ����������� ���������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.DURATION IS '���� ���� ������ � �������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.TERM_TYPE IS '��� �����: 1-����, 0-����, 2-��������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.MIN_SUMM IS '����������� ����� ������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.COMMENTS IS '�����������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.FLAG IS '���� ����������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.TYPE_COD IS '���������� ��� ���� ������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.KV IS '������ ���� ������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.TT IS '��� ��������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.SHABLON IS '������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.IDG IS '��� ������ ��� ���������� ������ ���.%%';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.IDS IS '��� ����� ��� ���������� ������ ���.%%';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.NLS_K IS '���� ������������ ��������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.DATN IS '���� ������ �������� ���� ������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.DATK IS '���� ��������� �������� ���� ������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.BR_ID_L IS '��� ������ �����������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.FL_DUBL IS '���� ������������������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.ACC7 IS '�����.����� ����� ��������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.ID_STOP IS '��� ������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.KODZ IS '��� ������� ��� ������ �������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.FMT IS '������ �������� �������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.FL_2620 IS '������� �� ����� "�� �������������"';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.COMPROC IS '������� �������������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.LIMIT IS '����������� ����� ����������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.TERM_ADD IS '���� ����������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.TERM_DUBL IS '����.���-�� ������������������ ������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.DURATION_DAYS IS '���� ���� ������ � ����';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.EXTENSION_ID IS '��� ������� ������������������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.TIP_OST IS '��� ���������� �������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.BR_WD IS '��� ������ ��� ��������� ������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.NLSN_K IS '���� ������������ ������.%%';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.BSA IS '���������� ���� �����������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.MAX_LIMIT IS '������������ ����� ����������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.BR_BONUS IS '��� ������� �������� ������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.BR_OP IS '��� �����.�������� ����� ������� � �������� ��������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.AUTO_ADD IS '���� �������������� ������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.TYPE_ID IS '����.��� ���� ��������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.DISABLE_ADD IS '������ ��������������� ��������';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.CODE_TARIFF IS '��� ������ �� ������ ������ ��� ������.�����.';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.DURATION_MAX IS '������������ ����� ������ � ������ (��� TERM_TYPE = 2)';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.DURATION_DAYS_MAX IS '������������ ����� ������ � � ���� (��� TERM_TYPE = 2)';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.IRREVOCABLE IS '������������ ���������� ������ (���������� ���������� ���������)';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.DATE_OFF IS '���� ��������� � �����';
COMMENT ON COLUMN BARS.DPT_VIDD_ARC.USER_OFF IS '����������, ���������� ��� � �����';




PROMPT *** Create  constraint CC_DPTVIDDARCARC_VIDD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_ARC MODIFY (VIDD CONSTRAINT CC_DPTVIDDARCARC_VIDD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDARC_TYPENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_ARC MODIFY (TYPE_NAME CONSTRAINT CC_DPTVIDDARC_TYPENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDARC_BASEY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_ARC MODIFY (BASEY CONSTRAINT CC_DPTVIDDARC_BASEY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDARC_BASEM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_ARC MODIFY (BASEM CONSTRAINT CC_DPTVIDDARC_BASEM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDARC_FREQN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_ARC MODIFY (FREQ_N CONSTRAINT CC_DPTVIDDARC_FREQN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDARC_FREQK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_ARC MODIFY (FREQ_K CONSTRAINT CC_DPTVIDDARC_FREQK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDARC_BSD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_ARC MODIFY (BSD CONSTRAINT CC_DPTVIDDARC_BSD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDARC_BSN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_ARC MODIFY (BSN CONSTRAINT CC_DPTVIDDARC_BSN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDARC_METR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_ARC MODIFY (METR CONSTRAINT CC_DPTVIDDARC_METR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDARC_AMRMETR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_ARC MODIFY (AMR_METR CONSTRAINT CC_DPTVIDDARC_AMRMETR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDARC_DURATION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_ARC MODIFY (DURATION CONSTRAINT CC_DPTVIDDARC_DURATION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDARC_TERMTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_ARC MODIFY (TERM_TYPE CONSTRAINT CC_DPTVIDDARC_TERMTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDARC_FLAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_ARC MODIFY (FLAG CONSTRAINT CC_DPTVIDDARC_FLAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDARC_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_ARC MODIFY (KV CONSTRAINT CC_DPTVIDDARC_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDARC_FLDUBL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_ARC MODIFY (FL_DUBL CONSTRAINT CC_DPTVIDDARC_FLDUBL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDARC_IDSTOP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_ARC MODIFY (ID_STOP CONSTRAINT CC_DPTVIDDARC_IDSTOP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDARC_FL2620_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_ARC MODIFY (FL_2620 CONSTRAINT CC_DPTVIDDARC_FL2620_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDARC_COMPROC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_ARC MODIFY (COMPROC CONSTRAINT CC_DPTVIDDARC_COMPROC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDARC_TERMDUBL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_ARC MODIFY (TERM_DUBL CONSTRAINT CC_DPTVIDDARC_TERMDUBL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDARC_DURATIONDAYS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_ARC MODIFY (DURATION_DAYS CONSTRAINT CC_DPTVIDDARC_DURATIONDAYS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDARC_TIPOST_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_ARC MODIFY (TIP_OST CONSTRAINT CC_DPTVIDDARC_TIPOST_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDARC_BRBONUS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_ARC MODIFY (BR_BONUS CONSTRAINT CC_DPTVIDDARC_BRBONUS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDARC_BROP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_ARC MODIFY (BR_OP CONSTRAINT CC_DPTVIDDARC_BROP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDARC_AUTOADD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_ARC MODIFY (AUTO_ADD CONSTRAINT CC_DPTVIDDARC_AUTOADD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDARC_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_ARC MODIFY (TYPE_ID CONSTRAINT CC_DPTVIDDARC_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDARC_IRREVOCABLE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_ARC MODIFY (IRREVOCABLE CONSTRAINT CC_DPTVIDDARC_IRREVOCABLE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDARC_DATE_OFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_ARC MODIFY (DATE_OFF CONSTRAINT CC_DPTVIDDARC_DATE_OFF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDARC_USER_OFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_ARC MODIFY (USER_OFF CONSTRAINT CC_DPTVIDDARC_USER_OFF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_VIDD_ARC ***
grant SELECT                                                                 on DPT_VIDD_ARC    to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on DPT_VIDD_ARC    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_VIDD_ARC    to BARS_DM;
grant SELECT                                                                 on DPT_VIDD_ARC    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_ARC.sql =========*** End *** 
PROMPT ===================================================================================== 
