

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OBPC_ACCT_IMP.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OBPC_ACCT_IMP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OBPC_ACCT_IMP'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''OBPC_ACCT_IMP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OBPC_ACCT_IMP'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OBPC_ACCT_IMP ***
begin 
  execute immediate '
  CREATE TABLE BARS.OBPC_ACCT_IMP 
   (	BRANCH VARCHAR2(5), 
	MFO VARCHAR2(6), 
	CARD_ACCT VARCHAR2(10), 
	ACC_TYPE VARCHAR2(2), 
	CURRENCY VARCHAR2(3), 
	LACCT VARCHAR2(25), 
	CLIENT_N VARCHAR2(40), 
	CARD_TYPE NUMBER(38,0), 
	STATUS VARCHAR2(1), 
	TIP CHAR(3)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OBPC_ACCT_IMP ***
 exec bpa.alter_policies('OBPC_ACCT_IMP');


COMMENT ON TABLE BARS.OBPC_ACCT_IMP IS '';
COMMENT ON COLUMN BARS.OBPC_ACCT_IMP.BRANCH IS '';
COMMENT ON COLUMN BARS.OBPC_ACCT_IMP.MFO IS '';
COMMENT ON COLUMN BARS.OBPC_ACCT_IMP.CARD_ACCT IS '';
COMMENT ON COLUMN BARS.OBPC_ACCT_IMP.ACC_TYPE IS '';
COMMENT ON COLUMN BARS.OBPC_ACCT_IMP.CURRENCY IS '';
COMMENT ON COLUMN BARS.OBPC_ACCT_IMP.LACCT IS '';
COMMENT ON COLUMN BARS.OBPC_ACCT_IMP.CLIENT_N IS '';
COMMENT ON COLUMN BARS.OBPC_ACCT_IMP.CARD_TYPE IS '';
COMMENT ON COLUMN BARS.OBPC_ACCT_IMP.STATUS IS '';
COMMENT ON COLUMN BARS.OBPC_ACCT_IMP.TIP IS '';




PROMPT *** Create  index I_OBPCACCTIMP_LACCT ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_OBPCACCTIMP_LACCT ON BARS.OBPC_ACCT_IMP (LACCT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_OBPCACCTIMP_CARDACCT ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_OBPCACCTIMP_CARDACCT ON BARS.OBPC_ACCT_IMP (CARD_ACCT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OBPC_ACCT_IMP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_ACCT_IMP   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OBPC_ACCT_IMP   to OBPC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OBPC_ACCT_IMP.sql =========*** End ***
PROMPT ===================================================================================== 
