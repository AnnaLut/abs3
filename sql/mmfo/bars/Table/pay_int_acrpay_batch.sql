

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PAY_INT_ACRPAY_BATCH.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PAY_INT_ACRPAY_BATCH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PAY_INT_ACRPAY_BATCH'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PAY_INT_ACRPAY_BATCH'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PAY_INT_ACRPAY_BATCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.PAY_INT_ACRPAY_BATCH 
   (	BATCH_ID NUMBER, 
	USER_LOGIN VARCHAR2(30), 
	CREATE_DATE DATE DEFAULT sysdate, 
	INFO VARCHAR2(4000), 
	FILTER VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PAY_INT_ACRPAY_BATCH ***
 exec bpa.alter_policies('PAY_INT_ACRPAY_BATCH');


COMMENT ON TABLE BARS.PAY_INT_ACRPAY_BATCH IS 'Запуск виплати процентів по депозитах';
COMMENT ON COLUMN BARS.PAY_INT_ACRPAY_BATCH.BATCH_ID IS '';
COMMENT ON COLUMN BARS.PAY_INT_ACRPAY_BATCH.USER_LOGIN IS '';
COMMENT ON COLUMN BARS.PAY_INT_ACRPAY_BATCH.CREATE_DATE IS '';
COMMENT ON COLUMN BARS.PAY_INT_ACRPAY_BATCH.INFO IS '';
COMMENT ON COLUMN BARS.PAY_INT_ACRPAY_BATCH.FILTER IS '';




PROMPT *** Create  constraint PK_PAY_INT_ACRPAY_BATCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.PAY_INT_ACRPAY_BATCH ADD CONSTRAINT PK_PAY_INT_ACRPAY_BATCH PRIMARY KEY (BATCH_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PAY_INT_ACRPAY_BATCH ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PAY_INT_ACRPAY_BATCH ON BARS.PAY_INT_ACRPAY_BATCH (BATCH_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PAY_INT_ACRPAY_BATCH ***
grant SELECT                                                                 on PAY_INT_ACRPAY_BATCH to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PAY_INT_ACRPAY_BATCH.sql =========*** 
PROMPT ===================================================================================== 
