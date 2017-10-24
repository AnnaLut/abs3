

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CP_UA.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CP_UA ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CP_UA ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_CP_UA 
   (	ID NUMBER, 
	EMI NUMBER, 
	DOX NUMBER(38,0), 
	CP_ID VARCHAR2(20), 
	KV NUMBER, 
	DATP DATE, 
	IR NUMBER, 
	DAT_EM DATE, 
	CENA NUMBER, 
	BASEY NUMBER, 
	DOK DATE, 
	DNK DATE, 
	RNK NUMBER(*,0), 
	PERIOD_KUP NUMBER, 
	CENA_KUP NUMBER(10,2), 
	KY NUMBER, 
	AMORT NUMBER, 
	DCP NUMBER, 
	KOL NUMBER(*,0), 
	NOM NUMBER, 
	K_NAR NUMBER, 
	K_NARQ NUMBER, 
	K_SPL NUMBER, 
	K_SPLQ NUMBER, 
	DN NUMBER(*,0), 
	S_NAR NUMBER, 
	S_NARQ NUMBER, 
	S_SPL NUMBER, 
	S_SPLQ NUMBER, 
	DAT_R DATE, 
	REF NUMBER(*,0), 
	ND VARCHAR2(10), 
	DAT_K DATE, 
	BAL VARCHAR2(4), 
	VIDD NUMBER, 
	PF NUMBER(*,0), 
	PFNAME VARCHAR2(70), 
	RYN NUMBER(*,0), 
	RYN_NAME VARCHAR2(35), 
	ERR VARCHAR2(50), 
	ID_U NUMBER(*,0), 
	FRM VARCHAR2(5), 
	GR_Z VARCHAR2(2), 
	ORD_Z NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_CP_UA ***
 exec bpa.alter_policies('TMP_CP_UA');


COMMENT ON TABLE BARS.TMP_CP_UA IS '������� ��� ���� �� �� UA';
COMMENT ON COLUMN BARS.TMP_CP_UA.ID IS '�����. ��� ��';
COMMENT ON COLUMN BARS.TMP_CP_UA.EMI IS '��� ���� �������';
COMMENT ON COLUMN BARS.TMP_CP_UA.DOX IS '��� ���������';
COMMENT ON COLUMN BARS.TMP_CP_UA.CP_ID IS 'ISIN-��� ��';
COMMENT ON COLUMN BARS.TMP_CP_UA.KV IS '��� ������';
COMMENT ON COLUMN BARS.TMP_CP_UA.DATP IS '���� ���������';
COMMENT ON COLUMN BARS.TMP_CP_UA.IR IS '%-������ ������';
COMMENT ON COLUMN BARS.TMP_CP_UA.DAT_EM IS '���� ���';
COMMENT ON COLUMN BARS.TMP_CP_UA.CENA IS '������ 1 ��';
COMMENT ON COLUMN BARS.TMP_CP_UA.BASEY IS '��� �������� ����';
COMMENT ON COLUMN BARS.TMP_CP_UA.DOK IS '���� ���������� ������';
COMMENT ON COLUMN BARS.TMP_CP_UA.DNK IS '���� ���������� ������';
COMMENT ON COLUMN BARS.TMP_CP_UA.RNK IS '���';
COMMENT ON COLUMN BARS.TMP_CP_UA.PERIOD_KUP IS '';
COMMENT ON COLUMN BARS.TMP_CP_UA.CENA_KUP IS 'ֳ�� ������ 1 ��';
COMMENT ON COLUMN BARS.TMP_CP_UA.KY IS 'ʳ������ ������ � ��';
COMMENT ON COLUMN BARS.TMP_CP_UA.AMORT IS '��� ���� �����������';
COMMENT ON COLUMN BARS.TMP_CP_UA.DCP IS '������� ����� A � ���';
COMMENT ON COLUMN BARS.TMP_CP_UA.KOL IS 'ʳ������ �� � ����� (��.)';
COMMENT ON COLUMN BARS.TMP_CP_UA.NOM IS '���� ������� ������';
COMMENT ON COLUMN BARS.TMP_CP_UA.K_NAR IS '���� ...';
COMMENT ON COLUMN BARS.TMP_CP_UA.K_NARQ IS '';
COMMENT ON COLUMN BARS.TMP_CP_UA.K_SPL IS '';
COMMENT ON COLUMN BARS.TMP_CP_UA.K_SPLQ IS '';
COMMENT ON COLUMN BARS.TMP_CP_UA.DN IS '��� ���� ��';
COMMENT ON COLUMN BARS.TMP_CP_UA.S_NAR IS '���� ...';
COMMENT ON COLUMN BARS.TMP_CP_UA.S_NARQ IS '';
COMMENT ON COLUMN BARS.TMP_CP_UA.S_SPL IS '���� ...';
COMMENT ON COLUMN BARS.TMP_CP_UA.S_SPLQ IS '';
COMMENT ON COLUMN BARS.TMP_CP_UA.DAT_R IS '������������/����� ����';
COMMENT ON COLUMN BARS.TMP_CP_UA.REF IS 'ref �����';
COMMENT ON COLUMN BARS.TMP_CP_UA.ND IS '';
COMMENT ON COLUMN BARS.TMP_CP_UA.DAT_K IS '���� �����';
COMMENT ON COLUMN BARS.TMP_CP_UA.BAL IS '�/�';
COMMENT ON COLUMN BARS.TMP_CP_UA.VIDD IS '��� �����';
COMMENT ON COLUMN BARS.TMP_CP_UA.PF IS '';
COMMENT ON COLUMN BARS.TMP_CP_UA.PFNAME IS '';
COMMENT ON COLUMN BARS.TMP_CP_UA.RYN IS '';
COMMENT ON COLUMN BARS.TMP_CP_UA.RYN_NAME IS '';
COMMENT ON COLUMN BARS.TMP_CP_UA.ERR IS '���� ������� �������';
COMMENT ON COLUMN BARS.TMP_CP_UA.ID_U IS '��� �����������';
COMMENT ON COLUMN BARS.TMP_CP_UA.FRM IS '��� �����';
COMMENT ON COLUMN BARS.TMP_CP_UA.GR_Z IS '����� ������';
COMMENT ON COLUMN BARS.TMP_CP_UA.ORD_Z IS '������� ������ � ����';




PROMPT *** Create  constraint SYS_C002685975 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CP_UA MODIFY (DAT_EM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002685974 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CP_UA MODIFY (KV NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002685973 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CP_UA MODIFY (CP_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C002685972 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_CP_UA MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_CP_UA ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_CP_UA       to START1;



PROMPT *** Create SYNONYM  to TMP_CP_UA ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_CP_UA FOR BARS.TMP_CP_UA;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CP_UA.sql =========*** End *** ===
PROMPT ===================================================================================== 
