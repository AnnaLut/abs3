

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STO_PAYMENT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STO_PAYMENT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STO_PAYMENT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STO_PAYMENT'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''STO_PAYMENT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STO_PAYMENT ***
begin 
  execute immediate '
  CREATE TABLE BARS.STO_PAYMENT 
   (	ID NUMBER(10,0), 
	ORDER_ID NUMBER(10,0), 
	STATE NUMBER(5,0), 
	VALUE_DATE DATE, 
	DEBT_AMOUNT NUMBER(22,2), 
	PAYMENT_AMOUNT NUMBER(22,2), 
	FEE_AMOUNT NUMBER(22,2), 
	PURPOSE VARCHAR2(4000), 
	RECEIVER_MFO VARCHAR2(6 CHAR), 
	RECEIVER_ACCOUNT VARCHAR2(34 CHAR), 
	RECEIVER_EDRPOU VARCHAR2(12 CHAR), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STO_PAYMENT ***
 exec bpa.alter_policies('STO_PAYMENT');


COMMENT ON TABLE BARS.STO_PAYMENT IS '';
COMMENT ON COLUMN BARS.STO_PAYMENT.ID IS '';
COMMENT ON COLUMN BARS.STO_PAYMENT.ORDER_ID IS '';
COMMENT ON COLUMN BARS.STO_PAYMENT.STATE IS '';
COMMENT ON COLUMN BARS.STO_PAYMENT.VALUE_DATE IS 'Розрахункова дата платежу';
COMMENT ON COLUMN BARS.STO_PAYMENT.DEBT_AMOUNT IS '';
COMMENT ON COLUMN BARS.STO_PAYMENT.PAYMENT_AMOUNT IS '';
COMMENT ON COLUMN BARS.STO_PAYMENT.FEE_AMOUNT IS '';
COMMENT ON COLUMN BARS.STO_PAYMENT.PURPOSE IS '';
COMMENT ON COLUMN BARS.STO_PAYMENT.RECEIVER_MFO IS '';
COMMENT ON COLUMN BARS.STO_PAYMENT.RECEIVER_ACCOUNT IS '';
COMMENT ON COLUMN BARS.STO_PAYMENT.RECEIVER_EDRPOU IS '';
COMMENT ON COLUMN BARS.STO_PAYMENT.BRANCH IS 'Hierarchical Branch Code';
COMMENT ON COLUMN BARS.STO_PAYMENT.KF IS '';




PROMPT *** Create  constraint PK_STO_PAYMENT ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PAYMENT ADD CONSTRAINT PK_STO_PAYMENT PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006804 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PAYMENT MODIFY (STATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006802 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PAYMENT MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006803 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PAYMENT MODIFY (ORDER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STOPAYMENT_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PAYMENT MODIFY (BRANCH CONSTRAINT CC_STOPAYMENT_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STOPAYMENT_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_PAYMENT MODIFY (KF CONSTRAINT CC_STOPAYMENT_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STO_PAYMENT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STO_PAYMENT ON BARS.STO_PAYMENT (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index STO_PAYMENT_IDX ***
begin   
 execute immediate '
  CREATE INDEX BARS.STO_PAYMENT_IDX ON BARS.STO_PAYMENT (ORDER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STO_PAYMENT ***
grant SELECT                                                                 on STO_PAYMENT     to BARSREADER_ROLE;
grant SELECT                                                                 on STO_PAYMENT     to BARSUPL;
grant SELECT                                                                 on STO_PAYMENT     to SBON;
grant SELECT                                                                 on STO_PAYMENT     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STO_PAYMENT.sql =========*** End *** =
PROMPT ===================================================================================== 
