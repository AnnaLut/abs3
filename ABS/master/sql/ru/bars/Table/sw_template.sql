

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_TEMPLATE.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_TEMPLATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_TEMPLATE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SW_TEMPLATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_TEMPLATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_TEMPLATE 
   (	REC_ID NUMBER(38,0), 
	REF NUMBER(38,0), 
	ND VARCHAR2(10), 
	DATD DATE, 
	KV NUMBER(3,0), 
	S NUMBER(24,0), 
	SUMSTR VARCHAR2(200), 
	SW50NLS VARCHAR2(35), 
	SW50NAME VARCHAR2(140), 
	SW50ADDRESS VARCHAR2(140), 
	SW56BIC VARCHAR2(11), 
	SW56NAME VARCHAR2(254), 
	SW57NLS VARCHAR2(35), 
	SW57BIC VARCHAR2(11), 
	SW57NAME VARCHAR2(140), 
	SW57ADDRESS VARCHAR2(350), 
	SW59NLS VARCHAR2(35), 
	SW59NAME VARCHAR2(140), 
	SW59ADDRESS VARCHAR2(140), 
	SW70NAZN VARCHAR2(350), 
	SW70FLAG NUMBER(1,0), 
	SW71CHARGE NUMBER(1,0) DEFAULT 0, 
	TT CHAR(3), 
	KOD_G CHAR(3), 
	OKPO VARCHAR2(14), 
	SWBANKORD VARCHAR2(11), 
	SWBANKBEN VARCHAR2(35), 
	SWTERM VARCHAR2(100), 
	SWOTHER VARCHAR2(250), 
	USER_ID NUMBER(38,0), 
	TEMPLATE_NAME VARCHAR2(38), 
	DOC_ID NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_TEMPLATE ***
 exec bpa.alter_policies('SW_TEMPLATE');


COMMENT ON TABLE BARS.SW_TEMPLATE IS '������ �������� swift ������� �� �볺�� �����';
COMMENT ON COLUMN BARS.SW_TEMPLATE.REC_ID IS '';
COMMENT ON COLUMN BARS.SW_TEMPLATE.REF IS '�������� ���������';
COMMENT ON COLUMN BARS.SW_TEMPLATE.ND IS '����� ���������';
COMMENT ON COLUMN BARS.SW_TEMPLATE.DATD IS '���� ���������';
COMMENT ON COLUMN BARS.SW_TEMPLATE.KV IS '������ ��������';
COMMENT ON COLUMN BARS.SW_TEMPLATE.S IS '����� ��������';
COMMENT ON COLUMN BARS.SW_TEMPLATE.SUMSTR IS '';
COMMENT ON COLUMN BARS.SW_TEMPLATE.SW50NLS IS '�������: �������';
COMMENT ON COLUMN BARS.SW_TEMPLATE.SW50NAME IS '�������: �����';
COMMENT ON COLUMN BARS.SW_TEMPLATE.SW50ADDRESS IS '�������: ���������������';
COMMENT ON COLUMN BARS.SW_TEMPLATE.SW56BIC IS '����-����������: bic-���';
COMMENT ON COLUMN BARS.SW_TEMPLATE.SW56NAME IS '����-����������: �����';
COMMENT ON COLUMN BARS.SW_TEMPLATE.SW57NLS IS '���� �����������: ����������';
COMMENT ON COLUMN BARS.SW_TEMPLATE.SW57BIC IS '���� �����������: bic-���';
COMMENT ON COLUMN BARS.SW_TEMPLATE.SW57NAME IS '���� �����������: �����';
COMMENT ON COLUMN BARS.SW_TEMPLATE.SW57ADDRESS IS '���� �����������: ���������������';
COMMENT ON COLUMN BARS.SW_TEMPLATE.SW59NLS IS '����������: �������';
COMMENT ON COLUMN BARS.SW_TEMPLATE.SW59NAME IS '����������: �����';
COMMENT ON COLUMN BARS.SW_TEMPLATE.SW59ADDRESS IS '����������: ���������������';
COMMENT ON COLUMN BARS.SW_TEMPLATE.SW70NAZN IS '����������� �������';
COMMENT ON COLUMN BARS.SW_TEMPLATE.SW70FLAG IS '������/��������� ������';
COMMENT ON COLUMN BARS.SW_TEMPLATE.SW71CHARGE IS '����� 0-OUR,1-BEN';
COMMENT ON COLUMN BARS.SW_TEMPLATE.TT IS '��� ��������';
COMMENT ON COLUMN BARS.SW_TEMPLATE.KOD_G IS '��� ����� �����������';
COMMENT ON COLUMN BARS.SW_TEMPLATE.OKPO IS '���������������� ��� ��������';
COMMENT ON COLUMN BARS.SW_TEMPLATE.SWBANKORD IS '��� ����� ��������';
COMMENT ON COLUMN BARS.SW_TEMPLATE.SWBANKBEN IS 'IBAN �����������';
COMMENT ON COLUMN BARS.SW_TEMPLATE.SWTERM IS '������ ��������� ��������';
COMMENT ON COLUMN BARS.SW_TEMPLATE.SWOTHER IS '����';
COMMENT ON COLUMN BARS.SW_TEMPLATE.USER_ID IS '';
COMMENT ON COLUMN BARS.SW_TEMPLATE.TEMPLATE_NAME IS '';
COMMENT ON COLUMN BARS.SW_TEMPLATE.DOC_ID IS '����� ��������� � corp2';




PROMPT *** Create  constraint FK_SWTEMPLATE_TABVAL_KV ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_TEMPLATE ADD CONSTRAINT FK_SWTEMPLATE_TABVAL_KV FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SW_TEMPLATE_DATD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_TEMPLATE MODIFY (DATD CONSTRAINT SW_TEMPLATE_DATD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SW_TEMPLATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_TEMPLATE ADD CONSTRAINT PK_SW_TEMPLATE PRIMARY KEY (REC_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SW_TEMPLATE_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_TEMPLATE MODIFY (USER_ID CONSTRAINT SW_TEMPLATE_USERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SW_TEMPLATE_ND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_TEMPLATE MODIFY (ND CONSTRAINT SW_TEMPLATE_ND_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SW_TEMPLATE_RECID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_TEMPLATE MODIFY (REC_ID CONSTRAINT SW_TEMPLATE_RECID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SW_TEMPLATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SW_TEMPLATE ON BARS.SW_TEMPLATE (REC_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_SW_TEMPLATE_DATD ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_SW_TEMPLATE_DATD ON BARS.SW_TEMPLATE (DATD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_TEMPLATE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_TEMPLATE     to BARSAQ;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_TEMPLATE.sql =========*** End *** =
PROMPT ===================================================================================== 
