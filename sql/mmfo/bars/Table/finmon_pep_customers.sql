

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FINMON_PEP_CUSTOMERS.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FINMON_PEP_CUSTOMERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FINMON_PEP_CUSTOMERS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FINMON_PEP_CUSTOMERS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FINMON_PEP_CUSTOMERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.FINMON_PEP_CUSTOMERS 
   (	ID NUMBER, 
	RNK NUMBER, 
	NMK VARCHAR2(150), 
	PERMIT NUMBER(1,0), 
	CRISK VARCHAR2(50), 
	CUST_RISK VARCHAR2(50), 
	CHECK_DATE DATE DEFAULT TRUNC(SYSDATE), 
	RNK_REEL NUMBER, 
	NMK_REEL VARCHAR2(150), 
	NUM_REEL NUMBER(*,0), 
	COMMENTS VARCHAR2(200)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FINMON_PEP_CUSTOMERS ***
 exec bpa.alter_policies('FINMON_PEP_CUSTOMERS');


COMMENT ON TABLE BARS.FINMON_PEP_CUSTOMERS IS '��. ��� ��� �˲����';
COMMENT ON COLUMN BARS.FINMON_PEP_CUSTOMERS.ID IS '��������� ���';
COMMENT ON COLUMN BARS.FINMON_PEP_CUSTOMERS.RNK IS '������������ ����� �볺��� � ��';
COMMENT ON COLUMN BARS.FINMON_PEP_CUSTOMERS.NMK IS '������������ �볺��� � ��';
COMMENT ON COLUMN BARS.FINMON_PEP_CUSTOMERS.PERMIT IS '������������ �볺��� � ��';
COMMENT ON COLUMN BARS.FINMON_PEP_CUSTOMERS.CRISK IS '�������� ������ �볺��� �� ���� ��������';
COMMENT ON COLUMN BARS.FINMON_PEP_CUSTOMERS.CUST_RISK IS '������ ������ �볺��� �� ���� ��������';
COMMENT ON COLUMN BARS.FINMON_PEP_CUSTOMERS.CHECK_DATE IS '���� ��������';
COMMENT ON COLUMN BARS.FINMON_PEP_CUSTOMERS.RNK_REEL IS 'RNK ���'����� �����';
COMMENT ON COLUMN BARS.FINMON_PEP_CUSTOMERS.NMK_REEL IS 'ϲ�/����� ���'����� �����';
COMMENT ON COLUMN BARS.FINMON_PEP_CUSTOMERS.NUM_REEL IS '� ���'��. ����� � (�������� �����)';
COMMENT ON COLUMN BARS.FINMON_PEP_CUSTOMERS.COMMENTS IS '��������';



PROMPT *** Create  grants  FINMON_PEP_CUSTOMERS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on FINMON_PEP_CUSTOMERS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FINMON_PEP_CUSTOMERS to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FINMON_PEP_CUSTOMERS.sql =========*** 
PROMPT ===================================================================================== 
