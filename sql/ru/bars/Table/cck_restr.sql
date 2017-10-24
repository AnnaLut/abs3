

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CCK_RESTR.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CCK_RESTR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CCK_RESTR'', ''FILIAL'' , ''F'', ''F'', ''F'', null);
               bpa.alter_policy_info(''CCK_RESTR'', ''WHOLE'' , ''C'', ''C'', ''C'', null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CCK_RESTR ***
begin 
  execute immediate '
  CREATE TABLE BARS.CCK_RESTR 
   (	ND NUMBER, 
	FDAT DATE, 
	VID_RESTR NUMBER, 
	TXT VARCHAR2(250), 
	SUMR NUMBER DEFAULT 0, 
	FDAT_END DATE, 
	PR_NO NUMBER DEFAULT 1, 
	RESTR_ID NUMBER(38,0), 
	CC_ID VARCHAR2(50), 
	SDATE DATE, 
	WDATE DATE, 
	RNK NUMBER(*,0), 
	NMK VARCHAR2(70), 
	S_RESTR VARCHAR2(250), 
	N_DODATOK VARCHAR2(50), 
	CUSTTYPE NUMBER(1,0), 
	QTY_PAY NUMBER, 
	DEL_PV NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CCK_RESTR ***
 exec bpa.alter_policies('CCK_RESTR');


COMMENT ON TABLE BARS.CCK_RESTR IS '���� � ���� ���������������� ��� �� �� ��';
COMMENT ON COLUMN BARS.CCK_RESTR.CC_ID IS '����� ����. ��������';
COMMENT ON COLUMN BARS.CCK_RESTR.SDATE IS '���� ������� ����. ��������';
COMMENT ON COLUMN BARS.CCK_RESTR.WDATE IS '���� ������� ����. ��������';
COMMENT ON COLUMN BARS.CCK_RESTR.RNK IS '��� ������������';
COMMENT ON COLUMN BARS.CCK_RESTR.NMK IS '����� ������������';
COMMENT ON COLUMN BARS.CCK_RESTR.S_RESTR IS '���� ����������������';
COMMENT ON COLUMN BARS.CCK_RESTR.N_DODATOK IS '����� ��������� �����';
COMMENT ON COLUMN BARS.CCK_RESTR.CUSTTYPE IS '������� ������� 2-��.�.3-���.�.';
COMMENT ON COLUMN BARS.CCK_RESTR.QTY_PAY IS 'ʳ������ ������� ���� ����������������';
COMMENT ON COLUMN BARS.CCK_RESTR.DEL_PV IS '������� Delta_PV = PV_����� - PV_�� ���������������� �� ������ ���.���� ����� ����������������';
COMMENT ON COLUMN BARS.CCK_RESTR.SUMR IS '���� ����������������� �������������';
COMMENT ON COLUMN BARS.CCK_RESTR.FDAT_END IS '���� ��������� ����������������';
COMMENT ON COLUMN BARS.CCK_RESTR.PR_NO IS '������ ��������� � ���� #F8 (0 - �� ��������, 1 - ��������)';
COMMENT ON COLUMN BARS.CCK_RESTR.RESTR_ID IS '';
COMMENT ON COLUMN BARS.CCK_RESTR.ND IS '�������� ��';
COMMENT ON COLUMN BARS.CCK_RESTR.FDAT IS '���� ����������������';
COMMENT ON COLUMN BARS.CCK_RESTR.VID_RESTR IS '��� ����������������';
COMMENT ON COLUMN BARS.CCK_RESTR.TXT IS '��������';




PROMPT *** Create  constraint FK_CCKRESTR_VID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_RESTR ADD CONSTRAINT FK_CCKRESTR_VID FOREIGN KEY (VID_RESTR)
	  REFERENCES BARS.CCK_RESTR_VID (VID_RESTR) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CCKRESTR_ND ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_RESTR ADD CONSTRAINT FK_CCKRESTR_ND FOREIGN KEY (ND)
	  REFERENCES BARS.CC_DEAL (ND) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CCK_RESTR_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_RESTR ADD CONSTRAINT CCK_RESTR_PK PRIMARY KEY (RESTR_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CCK_RESTR_RESTRID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CCK_RESTR MODIFY (RESTR_ID CONSTRAINT CCK_RESTR_RESTRID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index CCK_RESTR_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.CCK_RESTR_PK ON BARS.CCK_RESTR (RESTR_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index CCK_RESTR_I ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.CCK_RESTR_I ON BARS.CCK_RESTR (ND, VID_RESTR, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CCK_RESTR ***
grant SELECT                                                                 on CCK_RESTR       to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_RESTR       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CCK_RESTR       to BARS_DM;
grant SELECT                                                                 on CCK_RESTR       to BARS_SUP;
grant DELETE,INSERT,SELECT,UPDATE                                            on CCK_RESTR       to RCC_DEAL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CCK_RESTR.sql =========*** End *** ===
PROMPT ===================================================================================== 
