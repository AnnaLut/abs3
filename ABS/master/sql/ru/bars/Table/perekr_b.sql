

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PEREKR_B.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PEREKR_B ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PEREKR_B'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PEREKR_B'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PEREKR_B ***
begin 
  execute immediate '
  CREATE TABLE BARS.PEREKR_B 
   (	IDS NUMBER(38,0), 
	TT CHAR(3), 
	MFOB VARCHAR2(12), 
	NLSB VARCHAR2(14), 
	POLU VARCHAR2(38), 
	NAZN VARCHAR2(160), 
	KV NUMBER(3,0), 
	S VARCHAR2(100), 
	OKPO VARCHAR2(14), 
	IDR NUMBER(38,0), 
	KOEF NUMBER, 
	VOB NUMBER(38,0), 
	ID NUMBER(38,0), 
	FORMULA VARCHAR2(255), 
	KOD NUMBER(1,0), 
	ORD NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PEREKR_B ***
 exec bpa.alter_policies('PEREKR_B');


COMMENT ON TABLE BARS.PEREKR_B IS '����������. ������ ����������';
COMMENT ON COLUMN BARS.PEREKR_B.IDS IS '������������� �����';
COMMENT ON COLUMN BARS.PEREKR_B.TT IS '��� ��������';
COMMENT ON COLUMN BARS.PEREKR_B.MFOB IS '��� ����� ����������';
COMMENT ON COLUMN BARS.PEREKR_B.NLSB IS '����� ����� ����������';
COMMENT ON COLUMN BARS.PEREKR_B.POLU IS '������������ ����������';
COMMENT ON COLUMN BARS.PEREKR_B.NAZN IS '���������� �������';
COMMENT ON COLUMN BARS.PEREKR_B.KV IS '��� ������';
COMMENT ON COLUMN BARS.PEREKR_B.S IS '������� ��� ������� �����';
COMMENT ON COLUMN BARS.PEREKR_B.OKPO IS '��� ���� ����������';
COMMENT ON COLUMN BARS.PEREKR_B.IDR IS '����� ����������';
COMMENT ON COLUMN BARS.PEREKR_B.KOEF IS '����������� ��� ������� �����';
COMMENT ON COLUMN BARS.PEREKR_B.VOB IS '��� ���������';
COMMENT ON COLUMN BARS.PEREKR_B.ID IS '������������� ������';
COMMENT ON COLUMN BARS.PEREKR_B.FORMULA IS '';
COMMENT ON COLUMN BARS.PEREKR_B.KOD IS '';
COMMENT ON COLUMN BARS.PEREKR_B.ORD IS '';




PROMPT *** Create  constraint FK_PEREKRB_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B ADD CONSTRAINT FK_PEREKRB_BANKS FOREIGN KEY (MFOB)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PEREKRB_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B ADD CONSTRAINT FK_PEREKRB_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PEREKRB_PEREKRR ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B ADD CONSTRAINT FK_PEREKRB_PEREKRR FOREIGN KEY (IDR)
	  REFERENCES BARS.PEREKR_R (IDR) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PEREKRB_PEREKRS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B ADD CONSTRAINT FK_PEREKRB_PEREKRS FOREIGN KEY (IDS)
	  REFERENCES BARS.PEREKR_S (IDS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PEREKRB_VOB ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B ADD CONSTRAINT FK_PEREKRB_VOB FOREIGN KEY (VOB)
	  REFERENCES BARS.VOB (VOB) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_PEREKRB_TTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B ADD CONSTRAINT FK_PEREKRB_TTS FOREIGN KEY (TT)
	  REFERENCES BARS.TTS (TT) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PEREKRB ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B ADD CONSTRAINT PK_PEREKRB PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PEREKRB_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B MODIFY (ID CONSTRAINT CC_PEREKRB_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PEREKRB_VOB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B MODIFY (VOB CONSTRAINT CC_PEREKRB_VOB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PEREKRB_IDR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B MODIFY (IDR CONSTRAINT CC_PEREKRB_IDR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PEREKRB_OKPO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B MODIFY (OKPO CONSTRAINT CC_PEREKRB_OKPO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PEREKRB_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B MODIFY (KV CONSTRAINT CC_PEREKRB_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PEREKRB_NAZN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B MODIFY (NAZN CONSTRAINT CC_PEREKRB_NAZN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PEREKRB_POLU_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B MODIFY (POLU CONSTRAINT CC_PEREKRB_POLU_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PEREKRB_NLSB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B MODIFY (NLSB CONSTRAINT CC_PEREKRB_NLSB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PEREKRB_MFOB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B MODIFY (MFOB CONSTRAINT CC_PEREKRB_MFOB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PEREKRB_TT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B MODIFY (TT CONSTRAINT CC_PEREKRB_TT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PEREKRB_IDS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B MODIFY (IDS CONSTRAINT CC_PEREKRB_IDS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PEREKRB_NLSB ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B ADD CONSTRAINT CC_PEREKRB_NLSB CHECK (regexp_like(NLSB,''^[0-9]*$'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_PEREKRB ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_PEREKRB ON BARS.PEREKR_B (IDS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PEREKRB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PEREKRB ON BARS.PEREKR_B (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PEREKR_B ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PEREKR_B        to ABS_ADMIN;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on PEREKR_B        to BARS015;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PEREKR_B        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PEREKR_B        to R_KP;
grant SELECT                                                                 on PEREKR_B        to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PEREKR_B        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on PEREKR_B        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PEREKR_B.sql =========*** End *** ====
PROMPT ===================================================================================== 
