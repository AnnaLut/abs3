

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RKO_SIGNATORY.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RKO_SIGNATORY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RKO_SIGNATORY'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''RKO_SIGNATORY'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RKO_SIGNATORY ***
begin 
  execute immediate '
  CREATE TABLE BARS.RKO_SIGNATORY 
   (	ID NUMBER, 
	FULL_NM_NOM VARCHAR2(60), 
	FULL_NM_GEN VARCHAR2(60), 
	SHORT_NM_NOM VARCHAR2(60), 
	POSITION_PRSN_NOM VARCHAR2(60), 
	DIVISION_PRSN_GEN VARCHAR2(60), 
	POSITION_PRSN_GEN VARCHAR2(60), 
	DOC_NM_GEN VARCHAR2(100), 
	NOTARY_NM_GEN VARCHAR2(60), 
	NOTARY_TP_GEN VARCHAR2(60), 
	ATTORNEY_DT DATE, 
	ATTORNEY_NUM VARCHAR2(70), 
	NOTARIAL_DISTRICT_GEN VARCHAR2(60), 
	ACTIVE_F NUMBER, 
	BRANCH VARCHAR2(30), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to RKO_SIGNATORY ***
 exec bpa.alter_policies('RKO_SIGNATORY');


COMMENT ON TABLE BARS.RKO_SIGNATORY IS '������� ��������� ���';
COMMENT ON COLUMN BARS.RKO_SIGNATORY.ID IS '';
COMMENT ON COLUMN BARS.RKO_SIGNATORY.FULL_NM_NOM IS 'ϲ� ������������ ����� �� ����� ������� (��)';
COMMENT ON COLUMN BARS.RKO_SIGNATORY.FULL_NM_GEN IS 'ϲ� ������������ ����� �� ����� ������� (��)';
COMMENT ON COLUMN BARS.RKO_SIGNATORY.SHORT_NM_NOM IS 'ϲ� ������������ ����� �� ����� ��������� (��)';
COMMENT ON COLUMN BARS.RKO_SIGNATORY.POSITION_PRSN_NOM IS '������ ������������ ����� �� ����� (��)';
COMMENT ON COLUMN BARS.RKO_SIGNATORY.DIVISION_PRSN_GEN IS 'ϳ������ ������������ ����� �� ����� (��)';
COMMENT ON COLUMN BARS.RKO_SIGNATORY.POSITION_PRSN_GEN IS '������ ������������ ����� �� ����� (��)';
COMMENT ON COLUMN BARS.RKO_SIGNATORY.DOC_NM_GEN IS '����� ���������, �� ������ ����� 䳺 ������������ ����� �� ����� (��)';
COMMENT ON COLUMN BARS.RKO_SIGNATORY.NOTARY_NM_GEN IS 'ϲ� ��������, ���� �������� ��������� ������������ ����� �� ����� (��)';
COMMENT ON COLUMN BARS.RKO_SIGNATORY.NOTARY_TP_GEN IS '��� �������� (��������� / ���������) (��)';
COMMENT ON COLUMN BARS.RKO_SIGNATORY.ATTORNEY_DT IS '���� ���������';
COMMENT ON COLUMN BARS.RKO_SIGNATORY.ATTORNEY_NUM IS '� ���������';
COMMENT ON COLUMN BARS.RKO_SIGNATORY.NOTARIAL_DISTRICT_GEN IS '����������� ����� (��)';
COMMENT ON COLUMN BARS.RKO_SIGNATORY.ACTIVE_F IS '��������������� ��� ����� 0-ͳ,1-���';
COMMENT ON COLUMN BARS.RKO_SIGNATORY.BRANCH IS '';
COMMENT ON COLUMN BARS.RKO_SIGNATORY.KF IS '��� ������';




PROMPT *** Create  constraint CC_RKO_SIGNATORY_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_SIGNATORY MODIFY (BRANCH CONSTRAINT CC_RKO_SIGNATORY_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RKO_SIGNATORY_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_SIGNATORY MODIFY (KF CONSTRAINT CC_RKO_SIGNATORY_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CHECK_ACTIV ***
begin   
 execute immediate '
  ALTER TABLE BARS.RKO_SIGNATORY ADD CONSTRAINT CHECK_ACTIV CHECK (ACTIVE_F in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  RKO_SIGNATORY ***
grant SELECT                                                                 on RKO_SIGNATORY   to BARSREADER_ROLE;
grant SELECT                                                                 on RKO_SIGNATORY   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RKO_SIGNATORY.sql =========*** End ***
PROMPT ===================================================================================== 
