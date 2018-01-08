

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/LOCPAY_FEE_LOG.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to LOCPAY_FEE_LOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''LOCPAY_FEE_LOG'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''LOCPAY_FEE_LOG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table LOCPAY_FEE_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.LOCPAY_FEE_LOG 
   (	REF NUMBER(38,0), 
	S NUMBER(24,0), 
	NLSTR VARCHAR2(15), 
	DAT DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to LOCPAY_FEE_LOG ***
 exec bpa.alter_policies('LOCPAY_FEE_LOG');


COMMENT ON TABLE BARS.LOCPAY_FEE_LOG IS '';
COMMENT ON COLUMN BARS.LOCPAY_FEE_LOG.REF IS '';
COMMENT ON COLUMN BARS.LOCPAY_FEE_LOG.S IS '';
COMMENT ON COLUMN BARS.LOCPAY_FEE_LOG.NLSTR IS '';
COMMENT ON COLUMN BARS.LOCPAY_FEE_LOG.DAT IS '';
COMMENT ON COLUMN BARS.LOCPAY_FEE_LOG.KF IS '';




PROMPT *** Create  constraint PK_LOCPAYFEELOG ***
begin   
 execute immediate '
  ALTER TABLE BARS.LOCPAY_FEE_LOG ADD CONSTRAINT PK_LOCPAYFEELOG PRIMARY KEY (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_LOCPAYFEELOG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_LOCPAYFEELOG ON BARS.LOCPAY_FEE_LOG (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  LOCPAY_FEE_LOG ***
grant DELETE,INSERT,SELECT                                                   on LOCPAY_FEE_LOG  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on LOCPAY_FEE_LOG  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/LOCPAY_FEE_LOG.sql =========*** End **
PROMPT ===================================================================================== 
