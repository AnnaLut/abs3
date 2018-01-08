

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_ADD.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_ADD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_ADD'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_ADD'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CC_ADD'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_ADD ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_ADD 
   (	ND NUMBER(30,0), 
	ADDS NUMBER(*,0), 
	AIM NUMBER(*,0), 
	S NUMBER(24,4), 
	KV NUMBER(*,0), 
	BDATE DATE DEFAULT SYSDATE, 
	WDATE DATE DEFAULT SYSDATE, 
	ACCS NUMBER(38,0), 
	ACCP NUMBER(38,0), 
	SOUR NUMBER(*,0), 
	ACCKRED VARCHAR2(34), 
	MFOKRED VARCHAR2(12), 
	FREQ NUMBER(*,0), 
	PDATE DATE, 
	REFV NUMBER(*,0), 
	REFP NUMBER(*,0), 
	ACCPERC VARCHAR2(34), 
	MFOPERC VARCHAR2(12), 
	SWI_BIC CHAR(11), 
	SWI_ACC VARCHAR2(34), 
	SWI_REF NUMBER(38,0), 
	SWO_BIC CHAR(11), 
	SWO_ACC VARCHAR2(34), 
	SWO_REF NUMBER(38,0), 
	INT_AMOUNT NUMBER(24,4), 
	ALT_PARTYB VARCHAR2(250), 
	INTERM_B VARCHAR2(250), 
	INT_PARTYA VARCHAR2(250), 
	INT_PARTYB VARCHAR2(250), 
	INT_INTERMA VARCHAR2(250), 
	INT_INTERMB VARCHAR2(250), 
	SSUDA NUMBER(12,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	OKPOKRED VARCHAR2(14), 
	NAMKRED VARCHAR2(38), 
	NAZNKRED VARCHAR2(160), 
	NLS_1819 VARCHAR2(14), 
	FIELD_58D VARCHAR2(250), 
	N_NBU VARCHAR2(300), 
	D_NBU DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_ADD ***
 exec bpa.alter_policies('CC_ADD');


COMMENT ON TABLE BARS.CC_ADD IS '���.����������';
COMMENT ON COLUMN BARS.CC_ADD.N_NBU IS '����� �������� ���';
COMMENT ON COLUMN BARS.CC_ADD.D_NBU IS '���� ��������� � ���';
COMMENT ON COLUMN BARS.CC_ADD.ND IS '����� �������� (��������)';
COMMENT ON COLUMN BARS.CC_ADD.ADDS IS 'N ���. ����������';
COMMENT ON COLUMN BARS.CC_ADD.AIM IS '������� ���������� ��������';
COMMENT ON COLUMN BARS.CC_ADD.S IS '����� ��������';
COMMENT ON COLUMN BARS.CC_ADD.KV IS '��� ���';
COMMENT ON COLUMN BARS.CC_ADD.BDATE IS '���� ������ ��������';
COMMENT ON COLUMN BARS.CC_ADD.WDATE IS '���� ������';
COMMENT ON COLUMN BARS.CC_ADD.ACCS IS 'ACC �������� �����';
COMMENT ON COLUMN BARS.CC_ADD.ACCP IS '���������� ����� ����� ����������� ���������';
COMMENT ON COLUMN BARS.CC_ADD.SOUR IS '�������� ������������';
COMMENT ON COLUMN BARS.CC_ADD.ACCKRED IS '���� ��� ������������';
COMMENT ON COLUMN BARS.CC_ADD.MFOKRED IS '��� ��� ������������';
COMMENT ON COLUMN BARS.CC_ADD.FREQ IS '������������� ������ ������� ';
COMMENT ON COLUMN BARS.CC_ADD.PDATE IS '';
COMMENT ON COLUMN BARS.CC_ADD.REFV IS '���������� ����� ��������� (�� "���������� ����")';
COMMENT ON COLUMN BARS.CC_ADD.REFP IS '���������� ����� ��������� (�� "���������� ����")';
COMMENT ON COLUMN BARS.CC_ADD.ACCPERC IS '';
COMMENT ON COLUMN BARS.CC_ADD.MFOPERC IS '';
COMMENT ON COLUMN BARS.CC_ADD.SWI_BIC IS '';
COMMENT ON COLUMN BARS.CC_ADD.SWI_ACC IS '';
COMMENT ON COLUMN BARS.CC_ADD.SWI_REF IS '';
COMMENT ON COLUMN BARS.CC_ADD.SWO_BIC IS '';
COMMENT ON COLUMN BARS.CC_ADD.SWO_ACC IS '';
COMMENT ON COLUMN BARS.CC_ADD.SWO_REF IS '';
COMMENT ON COLUMN BARS.CC_ADD.INT_AMOUNT IS '����� �������������� ������������ ���������';
COMMENT ON COLUMN BARS.CC_ADD.ALT_PARTYB IS '�������������� ���������� ��������� ������';
COMMENT ON COLUMN BARS.CC_ADD.INTERM_B IS '��������� ���������� �� ������� �';
COMMENT ON COLUMN BARS.CC_ADD.INT_PARTYA IS '������ ��������� ������� ��� ���������';
COMMENT ON COLUMN BARS.CC_ADD.INT_PARTYB IS '������ ���������� ������� ��� ���������';
COMMENT ON COLUMN BARS.CC_ADD.INT_INTERMA IS '��������� ���������� ��������� ������� ��� ���������';
COMMENT ON COLUMN BARS.CC_ADD.INT_INTERMB IS '��������� ���������� ���������� ������� ��� ���������';
COMMENT ON COLUMN BARS.CC_ADD.SSUDA IS '';
COMMENT ON COLUMN BARS.CC_ADD.KF IS '';
COMMENT ON COLUMN BARS.CC_ADD.OKPOKRED IS ' ��� ������ ����������';
COMMENT ON COLUMN BARS.CC_ADD.NAMKRED IS '������������ ����������';
COMMENT ON COLUMN BARS.CC_ADD.NAZNKRED IS '���������� �������';
COMMENT ON COLUMN BARS.CC_ADD.NLS_1819 IS '������� 1819 ��� ��������� ��������';
COMMENT ON COLUMN BARS.CC_ADD.FIELD_58D IS '���� 58D ��� ������';




PROMPT *** Create  constraint PK_CCADD ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD ADD CONSTRAINT PK_CCADD PRIMARY KEY (ND, ADDS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_ADD_ND ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD MODIFY (ND CONSTRAINT NK_CC_ADD_ND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_CC_ADD_ADDS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD MODIFY (ADDS CONSTRAINT NK_CC_ADD_ADDS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCADD_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_ADD MODIFY (KF CONSTRAINT CC_CCADD_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCADD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCADD ON BARS.CC_ADD (ND, ADDS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_CCADD_KFACC ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_CCADD_KFACC ON BARS.CC_ADD (KF, ACCS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_ADD ***
grant SELECT                                                                 on CC_ADD          to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on CC_ADD          to BARSREADER_ROLE;
grant SELECT                                                                 on CC_ADD          to BARSUPL;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on CC_ADD          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_ADD          to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CC_ADD          to FOREX;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CC_ADD          to RCC_DEAL;
grant SELECT                                                                 on CC_ADD          to RPBN001;
grant SELECT                                                                 on CC_ADD          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_ADD          to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CC_ADD          to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_ADD.sql =========*** End *** ======
PROMPT ===================================================================================== 
