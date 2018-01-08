

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_HIERARCHY_IDS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_HIERARCHY_IDS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_HIERARCHY_IDS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_HIERARCHY_IDS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_HIERARCHY_IDS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_HIERARCHY_IDS 
   (	ID NUMBER(*,0), 
	DATE_START DATE, 
	DATE_FINISH DATE, 
	HIERARCHY_REP NUMBER(*,0), 
	H1 NUMBER(*,0), 
	H2 NUMBER(*,0), 
	COUNT_START NUMBER, 
	COUNT_END NUMBER, 
	N NUMBER, 
	DP NUMBER, 
	R NUMBER, 
	R2 NUMBER, 
	S NUMBER, 
	BV NUMBER, 
	N_END NUMBER, 
	DP_END NUMBER, 
	R_END NUMBER, 
	R2_END NUMBER, 
	S_END NUMBER, 
	BV_END NUMBER, 
	R_PAY NUMBER, 
	R_INT NUMBER, 
	TR NUMBER, 
	RESERVED NUMBER, 
	OVERPRICED NUMBER, 
	BOUGHT NUMBER, 
	SOLD NUMBER, 
	SETTLED NUMBER, 
	RECLASS_FROM NUMBER, 
	RECLASS_INTO NUMBER, 
	RANSOM NUMBER, 
	PAYEDINT NUMBER, 
	RNK NUMBER, 
	NBS VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_HIERARCHY_IDS ***
 exec bpa.alter_policies('CP_HIERARCHY_IDS');


COMMENT ON TABLE BARS.CP_HIERARCHY_IDS IS '����� �� ������� �������� � ������� ����� ��';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.NBS IS '';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.RANSOM IS '�����';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.PAYEDINT IS '�������� �����';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.RNK IS '';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.ID IS 'ID ��';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.DATE_START IS '���� ������ ������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.DATE_FINISH IS '���� ��������� ������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.HIERARCHY_REP IS '������� �������� ��� �����������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.H1 IS '������� �������� �� ������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.H2 IS '������� �������� �� �����';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.COUNT_START IS '���������� ����� �� ������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.COUNT_END IS '���������� ����� �� �����';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.N IS '������� �� ������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.DP IS '�������/������ �� ������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.R IS '����� �� ������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.R2 IS '�����2 �� ������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.S IS '���������� �� ������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.BV IS '���������� ��������� �� ������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.N_END IS '������� �� �����';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.DP_END IS '�������/������ �� �����';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.R_END IS '����� �� �����';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.R2_END IS '�����2 �� �����';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.S_END IS '���������� �� �����';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.BV_END IS '���������� ��������� �� �����';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.R_PAY IS '���������� ����� � �������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.R_INT IS '���������� ������ � �������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.TR IS '�������� ��������� � �������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.RESERVED IS '������� � �������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.OVERPRICED IS '���������� � �������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.BOUGHT IS '������� � �������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.SOLD IS '������� � �������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.SETTLED IS '�������� � �������';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.RECLASS_FROM IS '��������������� �� ������ (���.���������)';
COMMENT ON COLUMN BARS.CP_HIERARCHY_IDS.RECLASS_INTO IS '��������������� � ������� (���.���������)';



PROMPT *** Create  grants  CP_HIERARCHY_IDS ***
grant SELECT                                                                 on CP_HIERARCHY_IDS to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CP_HIERARCHY_IDS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_HIERARCHY_IDS to BARS_DM;
grant SELECT                                                                 on CP_HIERARCHY_IDS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_HIERARCHY_IDS.sql =========*** End 
PROMPT ===================================================================================== 
