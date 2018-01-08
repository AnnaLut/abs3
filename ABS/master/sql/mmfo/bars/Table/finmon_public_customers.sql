

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FINMON_PUBLIC_CUSTOMERS.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FINMON_PUBLIC_CUSTOMERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FINMON_PUBLIC_CUSTOMERS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FINMON_PUBLIC_CUSTOMERS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''FINMON_PUBLIC_CUSTOMERS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FINMON_PUBLIC_CUSTOMERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.FINMON_PUBLIC_CUSTOMERS 
   (	ID NUMBER(6,0), 
	RNK NUMBER(38,0), 
	NMK VARCHAR2(70), 
	CRISK VARCHAR2(50), 
	CUST_RISK VARCHAR2(50), 
	CHECK_DATE DATE DEFAULT TRUNC(SYSDATE), 
	RNK_REEL NUMBER, 
	NMK_REEL VARCHAR2(150), 
	NUM_REEL NUMBER(*,0), 
	COMMENTS VARCHAR2(200), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'', ''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FINMON_PUBLIC_CUSTOMERS ***
 exec bpa.alter_policies('FINMON_PUBLIC_CUSTOMERS');


COMMENT ON TABLE BARS.FINMON_PUBLIC_CUSTOMERS IS '������ �������� �볺��� - �������� �����';
COMMENT ON COLUMN BARS.FINMON_PUBLIC_CUSTOMERS.ID IS '��������� ���';
COMMENT ON COLUMN BARS.FINMON_PUBLIC_CUSTOMERS.RNK IS '������������ ����� �볺��� � ��';
COMMENT ON COLUMN BARS.FINMON_PUBLIC_CUSTOMERS.NMK IS '������������ �볺��� � ��';
COMMENT ON COLUMN BARS.FINMON_PUBLIC_CUSTOMERS.CRISK IS '�������� ������ �볺��� �� ���� ��������';
COMMENT ON COLUMN BARS.FINMON_PUBLIC_CUSTOMERS.CUST_RISK IS '������ ������ �볺��� �� ���� ��������';
COMMENT ON COLUMN BARS.FINMON_PUBLIC_CUSTOMERS.CHECK_DATE IS '���� �������� �볺��� �� ���������� ������� �������� �����';
COMMENT ON COLUMN BARS.FINMON_PUBLIC_CUSTOMERS.RNK_REEL IS 'RNK ���'����� �����';
COMMENT ON COLUMN BARS.FINMON_PUBLIC_CUSTOMERS.NMK_REEL IS 'ϲ�/����� ���'����� �����';
COMMENT ON COLUMN BARS.FINMON_PUBLIC_CUSTOMERS.NUM_REEL IS '� ���'��. ����� � ������� �������� ���';
COMMENT ON COLUMN BARS.FINMON_PUBLIC_CUSTOMERS.COMMENTS IS '��������';
COMMENT ON COLUMN BARS.FINMON_PUBLIC_CUSTOMERS.KF IS '';



PROMPT *** Create  grants  FINMON_PUBLIC_CUSTOMERS ***
grant SELECT                                                                 on FINMON_PUBLIC_CUSTOMERS to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on FINMON_PUBLIC_CUSTOMERS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FINMON_PUBLIC_CUSTOMERS to BARS_DM;
grant SELECT                                                                 on FINMON_PUBLIC_CUSTOMERS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FINMON_PUBLIC_CUSTOMERS.sql =========*
PROMPT ===================================================================================== 
