

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_ACCC.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_ACCC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_ACCC'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CP_ACCC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_ACCC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_ACCC ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_ACCC 
   (	VIDD NUMBER, 
	RYN NUMBER, 
	NLSA VARCHAR2(15), 
	NLSD VARCHAR2(15), 
	NLSP VARCHAR2(15), 
	NLSR VARCHAR2(15), 
	NLSS VARCHAR2(15), 
	NLSZ VARCHAR2(15), 
	NLSN1 VARCHAR2(15), 
	NLSN2 VARCHAR2(15), 
	NLSN3 VARCHAR2(15), 
	NLSN4 VARCHAR2(15), 
	NLSE VARCHAR2(15), 
	NLSG VARCHAR2(15), 
	NLSR2 VARCHAR2(15), 
	EMI NUMBER, 
	PF NUMBER, 
	IDB NUMBER, 
	NLSZF VARCHAR2(15), 
	NLS_FXP VARCHAR2(15), 
	NLSSN VARCHAR2(15), 
	NLS71 VARCHAR2(15), 
	S605 VARCHAR2(15), 
	S605P VARCHAR2(15), 
	NLS_PR VARCHAR2(15), 
	NLS_FXR VARCHAR2(15), 
	S2VD VARCHAR2(15), 
	S2VP VARCHAR2(15), 
	S2VD0 VARCHAR2(15), 
	S2VP0 VARCHAR2(15), 
	S2VD1 VARCHAR2(15), 
	S2VP1 VARCHAR2(15), 
	B4621R VARCHAR2(15), 
	S6499 VARCHAR2(15), 
	S7499 VARCHAR2(15), 
	NLSS5 VARCHAR2(15), 
	NLS_5040 VARCHAR2(15), 
	S2VD2 VARCHAR2(15), 
	S2VP2 VARCHAR2(15), 
	NLS_5040_2 VARCHAR2(15), 
	NLS_5040_3 VARCHAR2(15), 
	NLSEXPN VARCHAR2(15), 
	NLSEXPR VARCHAR2(15), 
	NLSR3 VARCHAR2(15), 
	NLS_1819 VARCHAR2(15), 
	NLS_1919 VARCHAR2(15), 
	UNREC VARCHAR2(15), 
	NLSFD VARCHAR2(15),
        D_Close date
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

begin EXECUTE IMMEDIATE 'alter table bars.CP_ACCC add ( D_Close date) ';
exception when others then   if SQLCODE = -01430 then null;   else raise; end if;   -- ORA-01430: column being added already exists in table
end;
/





PROMPT *** ALTER_POLICIES to CP_ACCC ***
 exec bpa.alter_policies('CP_ACCC');


COMMENT ON TABLE BARS.CP_ACCC IS '���������� ��������.��. �� �� ��';
COMMENT ON COLUMN BARS.CP_ACCC.VIDD IS '��� ����� (��)';
COMMENT ON COLUMN BARS.CP_ACCC.RYN IS '�����������';
COMMENT ON COLUMN BARS.CP_ACCC.NLSA IS 'C��� ��������';
COMMENT ON COLUMN BARS.CP_ACCC.NLSD IS '���� ��������';
COMMENT ON COLUMN BARS.CP_ACCC.NLSP IS 'C��� ������';
COMMENT ON COLUMN BARS.CP_ACCC.NLSR IS '���� �����. %';
COMMENT ON COLUMN BARS.CP_ACCC.NLSS IS 'C��� ����������';
COMMENT ON COLUMN BARS.CP_ACCC.NLSZ IS '���� ���������� �����';
COMMENT ON COLUMN BARS.CP_ACCC.NLSN1 IS '����.��.9201-����.,�� �����.';
COMMENT ON COLUMN BARS.CP_ACCC.NLSN2 IS '����.��.9219-������ �� ��������';
COMMENT ON COLUMN BARS.CP_ACCC.NLSN3 IS '����.��.9211-�������,�� �������.';
COMMENT ON COLUMN BARS.CP_ACCC.NLSN4 IS '����.��.9209-������ �� ���������';
COMMENT ON COLUMN BARS.CP_ACCC.NLSE IS 'C��� �������';
COMMENT ON COLUMN BARS.CP_ACCC.NLSG IS '���� ����.����������';
COMMENT ON COLUMN BARS.CP_ACCC.NLSR2 IS '���� �����. %';
COMMENT ON COLUMN BARS.CP_ACCC.EMI IS '��� ��������';
COMMENT ON COLUMN BARS.CP_ACCC.PF IS '��������';
COMMENT ON COLUMN BARS.CP_ACCC.IDB IS '��� ��������� ����';
COMMENT ON COLUMN BARS.CP_ACCC.NLSZF IS '���� ....';
COMMENT ON COLUMN BARS.CP_ACCC.NLS_FXP IS '���.FXP~������i�.���~������';
COMMENT ON COLUMN BARS.CP_ACCC.NLSSN IS '���.3811~��� ������.�������';
COMMENT ON COLUMN BARS.CP_ACCC.NLS71 IS '���.���.~������i�';
COMMENT ON COLUMN BARS.CP_ACCC.S605 IS '���.�������~��������';
COMMENT ON COLUMN BARS.CP_ACCC.S605P IS '���.�������~����i�';
COMMENT ON COLUMN BARS.CP_ACCC.NLS_PR IS '���.����.~�����i�';
COMMENT ON COLUMN BARS.CP_ACCC.NLS_FXR IS '���.FXR~����I���.���~������';
COMMENT ON COLUMN BARS.CP_ACCC.S2VD IS '����.���� ������������ ��������';
COMMENT ON COLUMN BARS.CP_ACCC.S2VP IS '����.���� �����������  ������';
COMMENT ON COLUMN BARS.CP_ACCC.S2VD0 IS '����.���� �������� ����.��������';
COMMENT ON COLUMN BARS.CP_ACCC.S2VP0 IS '����.���� �������� ����.������';
COMMENT ON COLUMN BARS.CP_ACCC.S2VD1 IS '����.���� �������. ����.��������';
COMMENT ON COLUMN BARS.CP_ACCC.S2VP1 IS '����.���� �������. ����.������';
COMMENT ON COLUMN BARS.CP_ACCC.B4621R IS '���������� ���-�';
COMMENT ON COLUMN BARS.CP_ACCC.S6499 IS '�� ���.6499 ��� ������� �+� �/�';
COMMENT ON COLUMN BARS.CP_ACCC.S7499 IS '�� ����.7499 ��� ������� �+� �/�';
COMMENT ON COLUMN BARS.CP_ACCC.NLSS5 IS '���.���.���� 5121.';
COMMENT ON COLUMN BARS.CP_ACCC.NLS_5040 IS '���.���� �� 5040. ���������� ��� �������';
COMMENT ON COLUMN BARS.CP_ACCC.S2VD2 IS '����.���� ���-�� ������� ����.�/�';
COMMENT ON COLUMN BARS.CP_ACCC.S2VP2 IS '����.���� ���-�� ������� ����.�/�';
COMMENT ON COLUMN BARS.CP_ACCC.NLS_5040_2 IS '5040/2.������������� ��������� ���������� (6����� ��) ';
COMMENT ON COLUMN BARS.CP_ACCC.NLS_5040_3 IS '5040/3.������������� ��������� ���������� (6����� ��)';
COMMENT ON COLUMN BARS.CP_ACCC.NLSEXPN IS '�� ��������� ��������';
COMMENT ON COLUMN BARS.CP_ACCC.NLSEXPR IS '�� ��������� ������';
COMMENT ON COLUMN BARS.CP_ACCC.NLSR3 IS '���� "�������" �����. %';
COMMENT ON COLUMN BARS.CP_ACCC.NLS_1819 IS '���-� ���. �������������_';
COMMENT ON COLUMN BARS.CP_ACCC.NLS_1919 IS '���-� ����. �������������_';
COMMENT ON COLUMN BARS.CP_ACCC.UNREC IS '�� ���������� ������';
COMMENT ON COLUMN BARS.CP_ACCC.NLSFD IS '�� ������������ ��� �������� ��(-3)';
COMMENT ON COLUMN BARS.CP_ACCC.D_Close IS '���� ���� ���.�����';



PROMPT *** Create  constraint XPK_CP_ACCC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ACCC ADD CONSTRAINT XPK_CP_ACCC PRIMARY KEY (VIDD, EMI, PF, RYN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CP_ACCC_BYR ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ACCC ADD CONSTRAINT FK_CP_ACCC_BYR FOREIGN KEY (IDB)
	  REFERENCES BARS.CP_BYR (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005263 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ACCC MODIFY (VIDD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005264 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ACCC MODIFY (RYN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005265 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ACCC MODIFY (EMI NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005266 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_ACCC MODIFY (PF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CP_ACCC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CP_ACCC ON BARS.CP_ACCC (VIDD, EMI, PF, RYN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_ACCC ***
grant SELECT                                                                 on CP_ACCC         to BARSUPL;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CP_ACCC         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_ACCC         to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CP_ACCC         to CP_ROLE;
grant SELECT                                                                 on CP_ACCC         to RPBN001;
grant SELECT                                                                 on CP_ACCC         to UPLD;
grant FLASHBACK,SELECT                                                       on CP_ACCC         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_ACCC.sql =========*** End *** =====
PROMPT ===================================================================================== 
