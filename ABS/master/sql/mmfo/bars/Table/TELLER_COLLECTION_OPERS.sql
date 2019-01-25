PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TELLER_COLLECTION_OPERS.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TELLER_COLLECTION_OPERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TELLER_COLLECTION_OPERS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TELLER_COLLECTION_OPERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.TELLER_COLLECTION_OPERS 
   (	ID NUMBER, 
	OPER_REF VARCHAR2(1000), 
	STATE VARCHAR2(2), 
	AMOUNT NUMBER, 
	CUR VARCHAR2(3), 
	PURPOSE VARCHAR2(160), 
	DOC_REF NUMBER, 
	LAST_DT DATE, 
	DIRECTION VARCHAR2(1), 
	USER_ID VARCHAR2(38), 
	CANDELETE NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TELLER_COLLECTION_OPERS ***
 exec bpa.alter_policies('TELLER_COLLECTION_OPERS');


COMMENT ON TABLE BARS.TELLER_COLLECTION_OPERS IS '�������� �� ���������';
COMMENT ON COLUMN BARS.TELLER_COLLECTION_OPERS.ID IS 'ID �������� ���������';
COMMENT ON COLUMN BARS.TELLER_COLLECTION_OPERS.OPER_REF IS '��������� �� teller_opers.id (������)';
COMMENT ON COLUMN BARS.TELLER_COLLECTION_OPERS.STATE IS '������ ��������';
COMMENT ON COLUMN BARS.TELLER_COLLECTION_OPERS.AMOUNT IS '���� ��������';
COMMENT ON COLUMN BARS.TELLER_COLLECTION_OPERS.CUR IS '��� ������ ��������';
COMMENT ON COLUMN BARS.TELLER_COLLECTION_OPERS.PURPOSE IS '����������� �������';
COMMENT ON COLUMN BARS.TELLER_COLLECTION_OPERS.DOC_REF IS '����������� �������� � ���';
COMMENT ON COLUMN BARS.TELLER_COLLECTION_OPERS.LAST_DT IS '����+��� �����������';
COMMENT ON COLUMN BARS.TELLER_COLLECTION_OPERS.DIRECTION IS 'ϳ��������� (�) / ��������� (�)';
COMMENT ON COLUMN BARS.TELLER_COLLECTION_OPERS.USER_ID IS '����������';
COMMENT ON COLUMN BARS.TELLER_COLLECTION_OPERS.CANDELETE IS '��������� ��������� (1/0)';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TELLER_COLLECTION_OPERS.sql =========*
PROMPT ===================================================================================== 
