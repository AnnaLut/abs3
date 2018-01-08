

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_PARTNERS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_PARTNERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_PARTNERS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''INS_PARTNERS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_PARTNERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_PARTNERS 
   (	ID NUMBER, 
	NAME VARCHAR2(300), 
	RNK NUMBER, 
	AGR_NO VARCHAR2(100), 
	AGR_SDATE DATE, 
	AGR_EDATE DATE, 
	TARIFF_ID VARCHAR2(100), 
	FEE_ID VARCHAR2(100), 
	LIMIT_ID VARCHAR2(100), 
	ACTIVE NUMBER, 
	CUSTTYPE NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_PARTNERS ***
 exec bpa.alter_policies('INS_PARTNERS');


COMMENT ON TABLE BARS.INS_PARTNERS IS '������������ ������� ��������';
COMMENT ON COLUMN BARS.INS_PARTNERS.KF IS '';
COMMENT ON COLUMN BARS.INS_PARTNERS.ID IS '�������������';
COMMENT ON COLUMN BARS.INS_PARTNERS.NAME IS '������������';
COMMENT ON COLUMN BARS.INS_PARTNERS.RNK IS '��� �����������-��������';
COMMENT ON COLUMN BARS.INS_PARTNERS.AGR_NO IS '����� �������� ��� �������������';
COMMENT ON COLUMN BARS.INS_PARTNERS.AGR_SDATE IS '���� ������� 䳿 �������� ��� �������������';
COMMENT ON COLUMN BARS.INS_PARTNERS.AGR_EDATE IS '���� ��������� 䳿 �������� ��� �������������';
COMMENT ON COLUMN BARS.INS_PARTNERS.TARIFF_ID IS '��. ������ �� ��������';
COMMENT ON COLUMN BARS.INS_PARTNERS.FEE_ID IS '��. ���� �� ��������';
COMMENT ON COLUMN BARS.INS_PARTNERS.LIMIT_ID IS '��. ���� �� ��������';
COMMENT ON COLUMN BARS.INS_PARTNERS.ACTIVE IS '���� ��������� �������';
COMMENT ON COLUMN BARS.INS_PARTNERS.CUSTTYPE IS '��� ����������';




PROMPT *** Create  constraint CC_INSPRTS_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNERS MODIFY (ID CONSTRAINT CC_INSPRTS_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_INSPRTS_ID_ACTIVE ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNERS MODIFY (ACTIVE CONSTRAINT CC_INSPRTS_ID_ACTIVE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_INSPARTNERS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNERS ADD CONSTRAINT PK_INSPARTNERS PRIMARY KEY (ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSPARTNERS_RNK_CUSTOMER ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNERS ADD CONSTRAINT FK_INSPARTNERS_RNK_CUSTOMER FOREIGN KEY (RNK)
	  REFERENCES BARS.CUSTOMER (RNK) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSPARTNERS_TID_TARIFFS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNERS ADD CONSTRAINT FK_INSPARTNERS_TID_TARIFFS FOREIGN KEY (TARIFF_ID, KF)
	  REFERENCES BARS.INS_TARIFFS (ID, KF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSPARTNERS_FID_FEES ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNERS ADD CONSTRAINT FK_INSPARTNERS_FID_FEES FOREIGN KEY (FEE_ID, KF)
	  REFERENCES BARS.INS_FEES (ID, KF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint ��_INSPARTNERS_ACTIVE ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNERS ADD CONSTRAINT ��_INSPARTNERS_ACTIVE CHECK (active in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_INSPARTNERS_LID_LIMITS ***
begin   
 execute immediate '
  ALTER TABLE BARS.INS_PARTNERS ADD CONSTRAINT FK_INSPARTNERS_LID_LIMITS FOREIGN KEY (LIMIT_ID, KF)
	  REFERENCES BARS.INS_LIMITS (ID, KF) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_INSPARTNERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_INSPARTNERS ON BARS.INS_PARTNERS (ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


-- Add/modify columns 
begin
    execute immediate 'alter table INS_PARTNERS add nls varchar2(15)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 


begin
    execute immediate 'alter table INS_PARTNERS add mfo varchar2(12)';
 exception when others then 
    if sqlcode = -1430 then null; else raise; 
    end if; 
end;
/ 

-- Add comments to the columns 
comment on column INS_PARTNERS.nls
  is '�������';
comment on column INS_PARTNERS.mfo
  is '��� �������';
/

PROMPT *** Create  grants  INS_PARTNERS ***
grant SELECT                                                                 on INS_PARTNERS    to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_PARTNERS.sql =========*** End *** 
PROMPT ===================================================================================== 
