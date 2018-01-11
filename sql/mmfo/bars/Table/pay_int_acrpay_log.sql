

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PAY_INT_ACRPAY_LOG.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PAY_INT_ACRPAY_LOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PAY_INT_ACRPAY_LOG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PAY_INT_ACRPAY_LOG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PAY_INT_ACRPAY_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.PAY_INT_ACRPAY_LOG 
   (	BATCH_ID NUMBER, 
	ACC NUMBER, 
	ID NUMBER, 
	NLS VARCHAR2(30), 
	SUMR NUMBER, 
	TTS VARCHAR2(3), 
	INFO VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PAY_INT_ACRPAY_LOG ***
 exec bpa.alter_policies('PAY_INT_ACRPAY_LOG');


COMMENT ON TABLE BARS.PAY_INT_ACRPAY_LOG IS 'Лог по запуску виплат процентів по депозитах';
COMMENT ON COLUMN BARS.PAY_INT_ACRPAY_LOG.BATCH_ID IS '';
COMMENT ON COLUMN BARS.PAY_INT_ACRPAY_LOG.ACC IS '';
COMMENT ON COLUMN BARS.PAY_INT_ACRPAY_LOG.ID IS '';
COMMENT ON COLUMN BARS.PAY_INT_ACRPAY_LOG.NLS IS '';
COMMENT ON COLUMN BARS.PAY_INT_ACRPAY_LOG.SUMR IS '';
COMMENT ON COLUMN BARS.PAY_INT_ACRPAY_LOG.TTS IS '';
COMMENT ON COLUMN BARS.PAY_INT_ACRPAY_LOG.INFO IS '';




PROMPT *** Create  index I1_PAY_INT_ACRPAY_LOG ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_PAY_INT_ACRPAY_LOG ON BARS.PAY_INT_ACRPAY_LOG (BATCH_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PAY_INT_ACRPAY_LOG ***
grant SELECT                                                                 on PAY_INT_ACRPAY_LOG to BARSREADER_ROLE;
grant SELECT                                                                 on PAY_INT_ACRPAY_LOG to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PAY_INT_ACRPAY_LOG to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PAY_INT_ACRPAY_LOG.sql =========*** En
PROMPT ===================================================================================== 
