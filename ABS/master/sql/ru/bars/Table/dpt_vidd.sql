

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_VIDD.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_VIDD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_VIDD'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_VIDD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_VIDD ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_VIDD 
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
	IRREVOCABLE NUMBER(1,0) DEFAULT 1
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_VIDD ***
 exec bpa.alter_policies('DPT_VIDD');


COMMENT ON TABLE BARS.DPT_VIDD IS '���� �������';
COMMENT ON COLUMN BARS.DPT_VIDD.CODE_TARIFF IS '��� ������ �� ������ ������ ��� ������.�����.';
COMMENT ON COLUMN BARS.DPT_VIDD.DISABLE_ADD IS '������ ��������������� ��������';
COMMENT ON COLUMN BARS.DPT_VIDD.IRREVOCABLE IS '������������ ���������� ������ (���������� ���������� ���������)';
COMMENT ON COLUMN BARS.DPT_VIDD.DURATION_MAX IS '������������ ����� ������ � ������ (��� TERM_TYPE = 2)';
COMMENT ON COLUMN BARS.DPT_VIDD.DURATION_DAYS_MAX IS '������������ ����� ������ � � ���� (��� TERM_TYPE = 2)';
COMMENT ON COLUMN BARS.DPT_VIDD.TYPE_ID IS '����.��� ���� ��������';
COMMENT ON COLUMN BARS.DPT_VIDD.VIDD IS '��� ���� ������';
COMMENT ON COLUMN BARS.DPT_VIDD.DEPOSIT_COD IS '�� ���.';
COMMENT ON COLUMN BARS.DPT_VIDD.TYPE_NAME IS '������������ ���� ������';
COMMENT ON COLUMN BARS.DPT_VIDD.BASEY IS '��� �������� ����';
COMMENT ON COLUMN BARS.DPT_VIDD.BASEM IS '������� ������.%-��� ������';
COMMENT ON COLUMN BARS.DPT_VIDD.BR_ID IS '��� ������� ���������� ������';
COMMENT ON COLUMN BARS.DPT_VIDD.FREQ_N IS '������������� ���������� %%';
COMMENT ON COLUMN BARS.DPT_VIDD.FREQ_K IS '������������� ������� %%';
COMMENT ON COLUMN BARS.DPT_VIDD.BSD IS '���������� ���� ��������';
COMMENT ON COLUMN BARS.DPT_VIDD.BSN IS '���������� ���� ����������� ���������';
COMMENT ON COLUMN BARS.DPT_VIDD.METR IS '��� ������ ���������� ���������';
COMMENT ON COLUMN BARS.DPT_VIDD.AMR_METR IS '����� ����������� ���������';
COMMENT ON COLUMN BARS.DPT_VIDD.DURATION IS '���� ���� ������ � �������';
COMMENT ON COLUMN BARS.DPT_VIDD.TERM_TYPE IS '��� �����: 1-����, 0-����, 2-��������';
COMMENT ON COLUMN BARS.DPT_VIDD.MIN_SUMM IS '����������� ����� ������';
COMMENT ON COLUMN BARS.DPT_VIDD.COMMENTS IS '�����������';
COMMENT ON COLUMN BARS.DPT_VIDD.FLAG IS '���� ����������';
COMMENT ON COLUMN BARS.DPT_VIDD.TYPE_COD IS '���������� ��� ���� ������';
COMMENT ON COLUMN BARS.DPT_VIDD.KV IS '������ ���� ������';
COMMENT ON COLUMN BARS.DPT_VIDD.TT IS '��� ��������';
COMMENT ON COLUMN BARS.DPT_VIDD.SHABLON IS '������';
COMMENT ON COLUMN BARS.DPT_VIDD.IDG IS '��� ������ ��� ���������� ������ ���.%%';
COMMENT ON COLUMN BARS.DPT_VIDD.IDS IS '��� ����� ��� ���������� ������ ���.%%';
COMMENT ON COLUMN BARS.DPT_VIDD.NLS_K IS '���� ������������ ��������';
COMMENT ON COLUMN BARS.DPT_VIDD.DATN IS '���� ������ �������� ���� ������';
COMMENT ON COLUMN BARS.DPT_VIDD.DATK IS '���� ��������� �������� ���� ������';
COMMENT ON COLUMN BARS.DPT_VIDD.BR_ID_L IS '��� ������ �����������';
COMMENT ON COLUMN BARS.DPT_VIDD.FL_DUBL IS '���� ������������������';
COMMENT ON COLUMN BARS.DPT_VIDD.ACC7 IS '�����.����� ����� ��������';
COMMENT ON COLUMN BARS.DPT_VIDD.ID_STOP IS '��� ������';
COMMENT ON COLUMN BARS.DPT_VIDD.KODZ IS '��� ������� ��� ������ �������';
COMMENT ON COLUMN BARS.DPT_VIDD.FMT IS '������ �������� �������';
COMMENT ON COLUMN BARS.DPT_VIDD.FL_2620 IS '������� �� ����� "�� �������������"';
COMMENT ON COLUMN BARS.DPT_VIDD.COMPROC IS '������� �������������';
COMMENT ON COLUMN BARS.DPT_VIDD.LIMIT IS '����������� ����� ����������';
COMMENT ON COLUMN BARS.DPT_VIDD.TERM_ADD IS '���� ����������';
COMMENT ON COLUMN BARS.DPT_VIDD.TERM_DUBL IS '����.���-�� ������������������ ������';
COMMENT ON COLUMN BARS.DPT_VIDD.DURATION_DAYS IS '���� ���� ������ � ����';
COMMENT ON COLUMN BARS.DPT_VIDD.EXTENSION_ID IS '��� ������� ������������������';
COMMENT ON COLUMN BARS.DPT_VIDD.TIP_OST IS '��� ���������� �������';
COMMENT ON COLUMN BARS.DPT_VIDD.BR_WD IS '��� ������ ��� ��������� ������';
COMMENT ON COLUMN BARS.DPT_VIDD.NLSN_K IS '���� ������������ ������.%%';
COMMENT ON COLUMN BARS.DPT_VIDD.BSA IS '���������� ���� �����������';
COMMENT ON COLUMN BARS.DPT_VIDD.MAX_LIMIT IS '������������ ����� ����������';
COMMENT ON COLUMN BARS.DPT_VIDD.BR_BONUS IS '��� ������� �������� ������';
COMMENT ON COLUMN BARS.DPT_VIDD.BR_OP IS '��� �����.�������� ����� ������� � �������� ��������';
COMMENT ON COLUMN BARS.DPT_VIDD.AUTO_ADD IS '���� �������������� ������';




PROMPT *** Create  constraint FK_DPTVIDD_PS3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_PS3 FOREIGN KEY (BSA)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_INTMETR2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_INTMETR2 FOREIGN KEY (AMR_METR)
	  REFERENCES BARS.INT_METR (METR) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_DPTSTOP ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_DPTSTOP FOREIGN KEY (ID_STOP)
	  REFERENCES BARS.DPT_STOP (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_PEREKRG ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_PEREKRG FOREIGN KEY (IDG)
	  REFERENCES BARS.PEREKR_G (IDG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_PEREKRS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_PEREKRS FOREIGN KEY (IDS)
	  REFERENCES BARS.PEREKR_S (IDS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_ZAPROSFMT ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_ZAPROSFMT FOREIGN KEY (FMT)
	  REFERENCES BARS.ZAPROS_FMT (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_PS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_PS FOREIGN KEY (BSD)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_PS2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_PS2 FOREIGN KEY (BSN)
	  REFERENCES BARS.PS (NBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_ACCOUNTS FOREIGN KEY (ACC7)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_BRATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_BRATES FOREIGN KEY (BR_ID)
	  REFERENCES BARS.BRATES (BR_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_BRATES2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_BRATES2 FOREIGN KEY (BR_ID_L)
	  REFERENCES BARS.BRATES (BR_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_BRATES3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_BRATES3 FOREIGN KEY (BR_WD)
	  REFERENCES BARS.BRATES (BR_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_BRATES4 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_BRATES4 FOREIGN KEY (BR_BONUS)
	  REFERENCES BARS.BRATES (BR_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_BASEY ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_BASEY FOREIGN KEY (BASEY)
	  REFERENCES BARS.BASEY (BASEY) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_FREQ ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_FREQ FOREIGN KEY (FREQ_N)
	  REFERENCES BARS.FREQ (FREQ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_DOCSCHEME ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_DOCSCHEME FOREIGN KEY (SHABLON)
	  REFERENCES BARS.DOC_SCHEME (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_INTOP ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_INTOP FOREIGN KEY (BR_OP)
	  REFERENCES BARS.INT_OP (OP) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_INTMETR ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_INTMETR FOREIGN KEY (METR)
	  REFERENCES BARS.INT_METR (METR) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_FREQ2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_FREQ2 FOREIGN KEY (FREQ_K)
	  REFERENCES BARS.FREQ (FREQ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_INTION ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_INTION FOREIGN KEY (TIP_OST)
	  REFERENCES BARS.INT_ION (IO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_DPTVIDDEXTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_DPTVIDDEXTYPES FOREIGN KEY (EXTENSION_ID)
	  REFERENCES BARS.DPT_VIDD_EXTYPES (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDD_DPTTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT FK_DPTVIDD_DPTTYPES FOREIGN KEY (TYPE_ID)
	  REFERENCES BARS.DPT_TYPES (TYPE_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_FLAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT CC_DPTVIDD_FLAG CHECK (flag in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_BASEY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD MODIFY (BASEY CONSTRAINT CC_DPTVIDD_BASEY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_TYPENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD MODIFY (TYPE_NAME CONSTRAINT CC_DPTVIDD_TYPENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_VIDD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD MODIFY (VIDD CONSTRAINT CC_DPTVIDD_VIDD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_AUTOADD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT CC_DPTVIDD_AUTOADD CHECK (auto_add in(0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_TERMTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT CC_DPTVIDD_TERMTYPE CHECK (term_type in (0, 1, 2)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTVIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT PK_DPTVIDD PRIMARY KEY (VIDD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_FLDUBL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT CC_DPTVIDD_FLDUBL CHECK (fl_dubl in (0,1,2)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_FL2620 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT CC_DPTVIDD_FL2620 CHECK (fl_2620 in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_COMPROC ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT CC_DPTVIDD_COMPROC CHECK (comproc in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_AUTOADD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD MODIFY (AUTO_ADD CONSTRAINT CC_DPTVIDD_AUTOADD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_BROP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD MODIFY (BR_OP CONSTRAINT CC_DPTVIDD_BROP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_BRBONUS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD MODIFY (BR_BONUS CONSTRAINT CC_DPTVIDD_BRBONUS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_TIPOST_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD MODIFY (TIP_OST CONSTRAINT CC_DPTVIDD_TIPOST_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_DURATIONDAYS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD MODIFY (DURATION_DAYS CONSTRAINT CC_DPTVIDD_DURATIONDAYS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_TERMDUBL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD MODIFY (TERM_DUBL CONSTRAINT CC_DPTVIDD_TERMDUBL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_COMPROC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD MODIFY (COMPROC CONSTRAINT CC_DPTVIDD_COMPROC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_FL2620_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD MODIFY (FL_2620 CONSTRAINT CC_DPTVIDD_FL2620_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_IDSTOP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD MODIFY (ID_STOP CONSTRAINT CC_DPTVIDD_IDSTOP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_FLDUBL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD MODIFY (FL_DUBL CONSTRAINT CC_DPTVIDD_FLDUBL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD MODIFY (KV CONSTRAINT CC_DPTVIDD_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_FLAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD MODIFY (FLAG CONSTRAINT CC_DPTVIDD_FLAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_TERMTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD MODIFY (TERM_TYPE CONSTRAINT CC_DPTVIDD_TERMTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_DURATION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD MODIFY (DURATION CONSTRAINT CC_DPTVIDD_DURATION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_AMRMETR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD MODIFY (AMR_METR CONSTRAINT CC_DPTVIDD_AMRMETR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_METR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD MODIFY (METR CONSTRAINT CC_DPTVIDD_METR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_BSN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD MODIFY (BSN CONSTRAINT CC_DPTVIDD_BSN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_BSD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD MODIFY (BSD CONSTRAINT CC_DPTVIDD_BSD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_FREQK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD MODIFY (FREQ_K CONSTRAINT CC_DPTVIDD_FREQK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_FREQN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD MODIFY (FREQ_N CONSTRAINT CC_DPTVIDD_FREQN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_BASEM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD MODIFY (BASEM CONSTRAINT CC_DPTVIDD_BASEM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_IRREVOCABLE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT CC_DPTVIDD_IRREVOCABLE CHECK ( IRREVOCABLE = 0 OR IRREVOCABLE = 1 ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_IRREVOCABLE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD MODIFY (IRREVOCABLE CONSTRAINT CC_DPTVIDD_IRREVOCABLE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD MODIFY (TYPE_ID CONSTRAINT CC_DPTVIDD_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDD_DURATIONMAX ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD ADD CONSTRAINT CC_DPTVIDD_DURATIONMAX CHECK (DURATION_MAX = decode(TERM_TYPE, 2, DURATION_MAX, null)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_DPTVIDD_TYPEID_VIDD_FLAG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.IDX_DPTVIDD_TYPEID_VIDD_FLAG ON BARS.DPT_VIDD (TYPE_ID, VIDD, FLAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTVIDD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTVIDD ON BARS.DPT_VIDD (VIDD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_VIDD ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_VIDD        to ABS_ADMIN;
grant SELECT                                                                 on DPT_VIDD        to BARS;
grant REFERENCES,SELECT                                                      on DPT_VIDD        to BARSAQ with grant option;
grant REFERENCES,SELECT                                                      on DPT_VIDD        to BARSAQ_ADM with grant option;
grant SELECT                                                                 on DPT_VIDD        to BARSUPL;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on DPT_VIDD        to BARS_ACCESS_DEFROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on DPT_VIDD        to BARS_DM;
grant SELECT                                                                 on DPT_VIDD        to BARS_SUP;
grant SELECT                                                                 on DPT_VIDD        to CC_DOC;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on DPT_VIDD        to DPT;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_VIDD        to DPT_ADMIN;
grant SELECT                                                                 on DPT_VIDD        to DPT_ROLE;
grant SELECT                                                                 on DPT_VIDD        to RPBN001;
grant SELECT                                                                 on DPT_VIDD        to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_VIDD        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DPT_VIDD        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_VIDD.sql =========*** End *** ====
PROMPT ===================================================================================== 
