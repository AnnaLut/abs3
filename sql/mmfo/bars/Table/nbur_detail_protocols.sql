

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NBUR_DETAIL_PROTOCOLS.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NBUR_DETAIL_PROTOCOLS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NBUR_DETAIL_PROTOCOLS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NBUR_DETAIL_PROTOCOLS ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.NBUR_DETAIL_PROTOCOLS 
   (	REPORT_DATE DATE, 
	KF CHAR(6), 
	REPORT_CODE CHAR(3), 
	NBUC VARCHAR2(20), 
	FIELD_CODE VARCHAR2(35), 
	FIELD_VALUE VARCHAR2(256), 
	DESCRIPTION VARCHAR2(250), 
	ACC_ID NUMBER(38,0), 
	ACC_NUM VARCHAR2(20), 
	KV NUMBER(3,0), 
	MATURITY_DATE DATE, 
	CUST_ID NUMBER(38,0), 
	REF NUMBER(38,0), 
	ND NUMBER(38,0), 
	BRANCH VARCHAR2(30)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NBUR_DETAIL_PROTOCOLS ***
 exec bpa.alter_policies('NBUR_DETAIL_PROTOCOLS');


COMMENT ON TABLE BARS.NBUR_DETAIL_PROTOCOLS IS '��������� �������� ������������ �����';
COMMENT ON COLUMN BARS.NBUR_DETAIL_PROTOCOLS.REPORT_DATE IS '����� ����';
COMMENT ON COLUMN BARS.NBUR_DETAIL_PROTOCOLS.KF IS '��� �i�i��� (���)';
COMMENT ON COLUMN BARS.NBUR_DETAIL_PROTOCOLS.REPORT_CODE IS '��� ����';
COMMENT ON COLUMN BARS.NBUR_DETAIL_PROTOCOLS.NBUC IS '��� ������ ����� � ������� ���� (Code section data)';
COMMENT ON COLUMN BARS.NBUR_DETAIL_PROTOCOLS.FIELD_CODE IS '��� ���������';
COMMENT ON COLUMN BARS.NBUR_DETAIL_PROTOCOLS.FIELD_VALUE IS '�������� ���������';
COMMENT ON COLUMN BARS.NBUR_DETAIL_PROTOCOLS.DESCRIPTION IS '���� (��������)';
COMMENT ON COLUMN BARS.NBUR_DETAIL_PROTOCOLS.ACC_ID IS '��. �������';
COMMENT ON COLUMN BARS.NBUR_DETAIL_PROTOCOLS.ACC_NUM IS '����� �������';
COMMENT ON COLUMN BARS.NBUR_DETAIL_PROTOCOLS.KV IS '��. ������';
COMMENT ON COLUMN BARS.NBUR_DETAIL_PROTOCOLS.MATURITY_DATE IS '���� ���������';
COMMENT ON COLUMN BARS.NBUR_DETAIL_PROTOCOLS.CUST_ID IS '��. �볺���';
COMMENT ON COLUMN BARS.NBUR_DETAIL_PROTOCOLS.REF IS '��. ��������� ���������';
COMMENT ON COLUMN BARS.NBUR_DETAIL_PROTOCOLS.ND IS '��. ��������';
COMMENT ON COLUMN BARS.NBUR_DETAIL_PROTOCOLS.BRANCH IS '��� ��������';




PROMPT *** Create  constraint CC_DTLPROTOCOLS_REPORTDT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DETAIL_PROTOCOLS MODIFY (REPORT_DATE CONSTRAINT CC_DTLPROTOCOLS_REPORTDT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DTLPROTOCOLS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DETAIL_PROTOCOLS MODIFY (KF CONSTRAINT CC_DTLPROTOCOLS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DTLPROTOCOLS_REPORTCD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DETAIL_PROTOCOLS MODIFY (REPORT_CODE CONSTRAINT CC_DTLPROTOCOLS_REPORTCD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DTLPROTOCOLS_NBUC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DETAIL_PROTOCOLS MODIFY (NBUC CONSTRAINT CC_DTLPROTOCOLS_NBUC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DTLPROTOCOLS_FIELDCOD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DETAIL_PROTOCOLS MODIFY (FIELD_CODE CONSTRAINT CC_DTLPROTOCOLS_FIELDCOD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DTLPROTOCOLS_FIELDVAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.NBUR_DETAIL_PROTOCOLS MODIFY (FIELD_VALUE CONSTRAINT CC_DTLPROTOCOLS_FIELDVAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NBUR_DETAIL_PROTOCOLS ***
grant SELECT                                                                 on NBUR_DETAIL_PROTOCOLS to BARSREADER_ROLE;
grant SELECT                                                                 on NBUR_DETAIL_PROTOCOLS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NBUR_DETAIL_PROTOCOLS.sql =========***
PROMPT ===================================================================================== 
