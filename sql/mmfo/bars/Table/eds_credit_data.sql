PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EDS_CREDIT_DATA.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EDS_CREDIT_DATA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EDS_CREDIT_DATA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EDS_CREDIT_DATA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EDS_CREDIT_DATA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EDS_CREDIT_DATA ***
begin 
  execute immediate '
  CREATE TABLE BARS.EDS_CREDIT_DATA 
   (    REQ_ID VARCHAR2(36), 
    RNK NUMBER, 
    ACC NUMBER(38,0), 
    ND NUMBER(22,0), 
    VIDD NUMBER(10,0), 
    KV NUMBER(3,0), 
    OPEN_IN VARCHAR2(100), 
    SDATE DATE, 
    BALANCE_DEBT NUMBER(10,0), 
    AMOUNT_PAY_PROC NUMBER(10,0), 
    AMOUNT_PAY_PRINCIPAL NUMBER(10,0), 
    SUM_TOTALY_CREDIT NUMBER(10,0), 
    KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EDS_CREDIT_DATA ***
 exec bpa.alter_policies('EDS_CREDIT_DATA');


COMMENT ON TABLE BARS.EDS_CREDIT_DATA IS '��� �-���������� �������';
COMMENT ON COLUMN BARS.EDS_CREDIT_DATA.REQ_ID IS '�� ������';
COMMENT ON COLUMN BARS.EDS_CREDIT_DATA.RNK IS '�� �볺���';
COMMENT ON COLUMN BARS.EDS_CREDIT_DATA.ACC IS '�� �������';
COMMENT ON COLUMN BARS.EDS_CREDIT_DATA.ND IS '����� ���������';
COMMENT ON COLUMN BARS.EDS_CREDIT_DATA.VIDD IS '��� �������';
COMMENT ON COLUMN BARS.EDS_CREDIT_DATA.KV IS '��� ������';
COMMENT ON COLUMN BARS.EDS_CREDIT_DATA.OPEN_IN IS '³������� �� ������� �������';
COMMENT ON COLUMN BARS.EDS_CREDIT_DATA.SDATE IS '���� ���������� �������';
COMMENT ON COLUMN BARS.EDS_CREDIT_DATA.BALANCE_DEBT IS '������� ������������� �������';
COMMENT ON COLUMN BARS.EDS_CREDIT_DATA.AMOUNT_PAY_PROC IS 'ʳ������ ���������� ��������';
COMMENT ON COLUMN BARS.EDS_CREDIT_DATA.AMOUNT_PAY_PRINCIPAL IS '���� ���������� �������';
COMMENT ON COLUMN BARS.EDS_CREDIT_DATA.SUM_TOTALY_CREDIT IS '���� �������';
COMMENT ON COLUMN BARS.EDS_CREDIT_DATA.KF IS '';




PROMPT *** Create  index PK_EDS_CREDIT_DATA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_EDS_CREDIT_DATA ON BARS.EDS_CREDIT_DATA (REQ_ID, ND, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  constraint PK_EDS_CREDIT_DATA ***
begin   
 execute immediate '
  ALTER TABLE BARS.EDS_CREDIT_DATA ADD CONSTRAINT PK_EDS_CREDIT_DATA PRIMARY KEY (REQ_ID, ND, KF)
  USING INDEX PK_EDS_CREDIT_DATA ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  EDS_CREDIT_DATA ***
grant SELECT                                                                 on EDS_CREDIT_DATA to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EDS_CREDIT_DATA.sql =========*** End *
PROMPT ===================================================================================== 

