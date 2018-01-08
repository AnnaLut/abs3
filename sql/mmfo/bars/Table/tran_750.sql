

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TRAN_750.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TRAN_750 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TRAN_750'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TRAN_750'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TRAN_750'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TRAN_750 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TRAN_750 
   (	CARD_ACCT CHAR(10), 
	CURRENCY CHAR(3), 
	CCY CHAR(3), 
	TRAN_DATE DATE, 
	TRAN_TYPE CHAR(2), 
	CARD VARCHAR2(16), 
	SLIP_NR CHAR(7), 
	BATCH_NR CHAR(7), 
	ABVR_NAME VARCHAR2(27), 
	CITY VARCHAR2(15), 
	MERCHANT CHAR(7), 
	TRAN_AMT NUMBER(12,2), 
	AMOUNT NUMBER(12,2), 
	TRAN_NAME VARCHAR2(40), 
	TRAN_RUSS VARCHAR2(40), 
	POST_DATE DATE, 
	CARD_TYPE NUMBER(*,0), 
	COUNTRY CHAR(3), 
	MCC_CODE CHAR(4), 
	TERMINAL CHAR(1)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TRAN_750 ***
 exec bpa.alter_policies('TRAN_750');


COMMENT ON TABLE BARS.TRAN_750 IS '';
COMMENT ON COLUMN BARS.TRAN_750.CARD_ACCT IS '';
COMMENT ON COLUMN BARS.TRAN_750.CURRENCY IS '';
COMMENT ON COLUMN BARS.TRAN_750.CCY IS '';
COMMENT ON COLUMN BARS.TRAN_750.TRAN_DATE IS '';
COMMENT ON COLUMN BARS.TRAN_750.TRAN_TYPE IS '';
COMMENT ON COLUMN BARS.TRAN_750.CARD IS '';
COMMENT ON COLUMN BARS.TRAN_750.SLIP_NR IS '';
COMMENT ON COLUMN BARS.TRAN_750.BATCH_NR IS '';
COMMENT ON COLUMN BARS.TRAN_750.ABVR_NAME IS '';
COMMENT ON COLUMN BARS.TRAN_750.CITY IS '';
COMMENT ON COLUMN BARS.TRAN_750.MERCHANT IS '';
COMMENT ON COLUMN BARS.TRAN_750.TRAN_AMT IS '';
COMMENT ON COLUMN BARS.TRAN_750.AMOUNT IS '';
COMMENT ON COLUMN BARS.TRAN_750.TRAN_NAME IS '';
COMMENT ON COLUMN BARS.TRAN_750.TRAN_RUSS IS '';
COMMENT ON COLUMN BARS.TRAN_750.POST_DATE IS '';
COMMENT ON COLUMN BARS.TRAN_750.CARD_TYPE IS '';
COMMENT ON COLUMN BARS.TRAN_750.COUNTRY IS '';
COMMENT ON COLUMN BARS.TRAN_750.MCC_CODE IS '';
COMMENT ON COLUMN BARS.TRAN_750.TERMINAL IS '';



PROMPT *** Create  grants  TRAN_750 ***
grant SELECT                                                                 on TRAN_750        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TRAN_750        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TRAN_750        to START1;
grant SELECT                                                                 on TRAN_750        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TRAN_750.sql =========*** End *** ====
PROMPT ===================================================================================== 
