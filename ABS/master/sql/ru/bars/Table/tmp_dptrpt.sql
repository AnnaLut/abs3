

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_DPTRPT.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_DPTRPT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_DPTRPT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_DPTRPT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_DPTRPT ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.TMP_DPTRPT 
   (	RECID NUMBER(38,0), 
	CODE NUMBER(38,0), 
	DPTID NUMBER(38,0), 
	DPTNUM VARCHAR2(35), 
	DPTDAT DATE, 
	DATBEG DATE, 
	DATEND DATE, 
	DEPACCNUM VARCHAR2(15), 
	DEPACCNAME VARCHAR2(70), 
	INTACCNUM VARCHAR2(15), 
	INTACCNAME VARCHAR2(70), 
	CURID NUMBER(3,0), 
	CURCODE CHAR(3), 
	CURNAME VARCHAR2(35), 
	TYPEID NUMBER(38,0), 
	TYPENAME VARCHAR2(50), 
	CUSTID NUMBER(38,0), 
	CUSTNAME VARCHAR2(70), 
	DOCTYPE CHAR(3), 
	ISAL_GEN NUMBER(38,0), 
	OSAL_GEN NUMBER(38,0), 
	FDAT DATE, 
	PDAT DATE, 
	ISAL_DAT NUMBER(38,0), 
	OSAL_DAT NUMBER(38,0), 
	DOCREF NUMBER(38,0), 
	DOCNUM VARCHAR2(10), 
	DOCTT CHAR(3), 
	DOCDK NUMBER(1,0), 
	DOCSUM NUMBER(24,0), 
	DOCSK NUMBER(2,0), 
	DOCUSER NUMBER(38,0), 
	DOCDTL VARCHAR2(160), 
	CORRMFO VARCHAR2(12), 
	CORRACC VARCHAR2(15), 
	CORRNAME VARCHAR2(38), 
	CORRCODE VARCHAR2(14), 
	USERID NUMBER(38,0), 
	USERNAME VARCHAR2(60), 
	BRN4ID VARCHAR2(30), 
	BRN4NAME VARCHAR2(70)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_DPTRPT ***
 exec bpa.alter_policies('TMP_DPTRPT');


COMMENT ON TABLE BARS.TMP_DPTRPT IS '����.������� ��� ������� �� ������� ���.���';
COMMENT ON COLUMN BARS.TMP_DPTRPT.RECID IS '������������� ������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.CODE IS '��� ������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.DPTID IS '�������� ��������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.DPTNUM IS '����� ��������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.DPTDAT IS '���� ��������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.DATBEG IS '���� ������ ��������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.DATEND IS '���� ��������� ��������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.DEPACCNUM IS '����� ����������� �����';
COMMENT ON COLUMN BARS.TMP_DPTRPT.DEPACCNAME IS '�������� ����������� �����';
COMMENT ON COLUMN BARS.TMP_DPTRPT.INTACCNUM IS '����� ����������� �����';
COMMENT ON COLUMN BARS.TMP_DPTRPT.INTACCNAME IS '�������� ����������� �����';
COMMENT ON COLUMN BARS.TMP_DPTRPT.CURID IS '����.��� ������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.CURCODE IS '����.��� ������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.CURNAME IS '�������� ������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.TYPEID IS '��� ���� ��������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.TYPENAME IS '�������� ���� ��������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.CUSTID IS '�������.����� �������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.CUSTNAME IS '������������ �������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.DOCTYPE IS '��� �����: DEN/INT';
COMMENT ON COLUMN BARS.TMP_DPTRPT.ISAL_GEN IS '����.������� �� �������� ������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.OSAL_GEN IS '���.������� �� �������� ������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.FDAT IS '���� ��������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.PDAT IS '���� ����.��������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.ISAL_DAT IS '����.������� �� ���� ��������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.OSAL_DAT IS '���.������� �� ���� ��������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.DOCREF IS '�������� ���������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.DOCNUM IS '����� ���������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.DOCTT IS '��� ��������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.DOCDK IS '��� ��������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.DOCSUM IS '����� ���������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.DOCSK IS '������ ���������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.DOCUSER IS '��� �����������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.DOCDTL IS '���������� �������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.CORRMFO IS '��� ��������������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.CORRACC IS '���� ��������������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.CORRNAME IS '������������ ��������������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.CORRCODE IS '�������.��� ��������������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.USERID IS '��� �����.���.�� ��������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.USERNAME IS '��� �����.���.�� ��������';
COMMENT ON COLUMN BARS.TMP_DPTRPT.BRN4ID IS '��� ������������� �����';
COMMENT ON COLUMN BARS.TMP_DPTRPT.BRN4NAME IS '������������ ������������� �����';




PROMPT *** Create  constraint PK_TMPDPTRPT ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT ADD CONSTRAINT PK_TMPDPTRPT PRIMARY KEY (RECID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_DOCTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (DOCTYPE CONSTRAINT CC_TMPDPTRPT_DOCTYPE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_CUSTNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (CUSTNAME CONSTRAINT CC_TMPDPTRPT_CUSTNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_CUSTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (CUSTID CONSTRAINT CC_TMPDPTRPT_CUSTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_TYPENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (TYPENAME CONSTRAINT CC_TMPDPTRPT_TYPENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (TYPEID CONSTRAINT CC_TMPDPTRPT_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_CURNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (CURNAME CONSTRAINT CC_TMPDPTRPT_CURNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_CURCODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (CURCODE CONSTRAINT CC_TMPDPTRPT_CURCODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_CURID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (CURID CONSTRAINT CC_TMPDPTRPT_CURID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_INTACCNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (INTACCNAME CONSTRAINT CC_TMPDPTRPT_INTACCNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_INTACCNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (INTACCNUM CONSTRAINT CC_TMPDPTRPT_INTACCNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_DEPACCNAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (DEPACCNAME CONSTRAINT CC_TMPDPTRPT_DEPACCNAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_DEPACCNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (DEPACCNUM CONSTRAINT CC_TMPDPTRPT_DEPACCNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_DATBEG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (DATBEG CONSTRAINT CC_TMPDPTRPT_DATBEG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_DPTDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (DPTDAT CONSTRAINT CC_TMPDPTRPT_DPTDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_DPTNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (DPTNUM CONSTRAINT CC_TMPDPTRPT_DPTNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_DPTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (DPTID CONSTRAINT CC_TMPDPTRPT_DPTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_CODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (CODE CONSTRAINT CC_TMPDPTRPT_CODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPDPTRPT_RECID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_DPTRPT MODIFY (RECID CONSTRAINT CC_TMPDPTRPT_RECID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMPDPTRPT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMPDPTRPT ON BARS.TMP_DPTRPT (RECID) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_DPTRPT ***
grant SELECT                                                                 on TMP_DPTRPT      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_DPTRPT      to RPBN001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_DPTRPT      to WR_ALL_RIGHTS;
grant SELECT                                                                 on TMP_DPTRPT      to WR_CREPORTS;



PROMPT *** Create SYNONYM  to TMP_DPTRPT ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_DPTRPT FOR BARS.TMP_DPTRPT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_DPTRPT.sql =========*** End *** ==
PROMPT ===================================================================================== 
