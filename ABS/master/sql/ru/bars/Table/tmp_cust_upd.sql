

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_CUST_UPD.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_CUST_UPD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_CUST_UPD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_CUST_UPD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_CUST_UPD ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_CUST_UPD 
   (	RNK NUMBER(38,0), 
	NMK VARCHAR2(70), 
	NMK_NEW VARCHAR2(70), 
	CUSW_SN_FN VARCHAR2(500), 
	CUSW_SN_LN VARCHAR2(500), 
	CUSW_SN_MN VARCHAR2(500), 
	CUSW_SN_FN_NEW VARCHAR2(500), 
	CUSW_SN_LN_NEW VARCHAR2(500), 
	CUSW_SN_MN_NEW VARCHAR2(500)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_CUST_UPD ***
 exec bpa.alter_policies('TMP_CUST_UPD');


COMMENT ON TABLE BARS.TMP_CUST_UPD IS '������� ������� RNK i NMK+����������� NMK';
COMMENT ON COLUMN BARS.TMP_CUST_UPD.RNK IS '��������������� �����';
COMMENT ON COLUMN BARS.TMP_CUST_UPD.NMK IS '������� NMK';
COMMENT ON COLUMN BARS.TMP_CUST_UPD.NMK_NEW IS '������� NMK';
COMMENT ON COLUMN BARS.TMP_CUST_UPD.CUSW_SN_FN IS '�������� ���� SN_FN ���. CUSTOMER (��� �볺���)';
COMMENT ON COLUMN BARS.TMP_CUST_UPD.CUSW_SN_LN IS '�������� ���� SN_LN ���. CUSTOMER (������� �볺���)';
COMMENT ON COLUMN BARS.TMP_CUST_UPD.CUSW_SN_MN IS '�������� ���� SN_MN ���. CUSTOMER (��-������� �볺���)';
COMMENT ON COLUMN BARS.TMP_CUST_UPD.CUSW_SN_FN_NEW IS '������������ �������� ���� SN_FN ���. CUSTOMER (��� �볺��� ����)';
COMMENT ON COLUMN BARS.TMP_CUST_UPD.CUSW_SN_LN_NEW IS '������������ �������� ���� SN_LN ���. CUSTOMER (������� �볺��� ����)';
COMMENT ON COLUMN BARS.TMP_CUST_UPD.CUSW_SN_MN_NEW IS '������������ �������� ���� SN_MN ���. CUSTOMER (��-������� �볺��� ����)';




PROMPT *** Create  index RNK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.RNK ON BARS.TMP_CUST_UPD (RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_CUST_UPD.sql =========*** End *** 
PROMPT ===================================================================================== 
