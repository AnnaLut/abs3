

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SEC_AUDIT_ARCH.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SEC_AUDIT_ARCH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SEC_AUDIT_ARCH'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SEC_AUDIT_ARCH'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SEC_AUDIT_ARCH'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SEC_AUDIT_ARCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.SEC_AUDIT_ARCH 
   (	REC_ID NUMBER(38,0), 
	REC_UID NUMBER(38,0), 
	REC_UNAME VARCHAR2(30), 
	REC_UPROXY VARCHAR2(30), 
	REC_DATE DATE, 
	REC_BDATE DATE, 
	REC_TYPE VARCHAR2(10), 
	REC_MODULE VARCHAR2(30), 
	REC_MESSAGE VARCHAR2(4000), 
	MACHINE VARCHAR2(255), 
	REC_OBJECT VARCHAR2(100), 
	REC_USERID NUMBER(38,0), 
	BRANCH VARCHAR2(30), 
	REC_STACK VARCHAR2(2000), 
	CLIENT_IDENTIFIER VARCHAR2(64)
   ) 
   ORGANIZATION EXTERNAL 
    ( TYPE ORACLE_DATAPUMP
      DEFAULT DIRECTORY UPLD
      ACCESS PARAMETERS
      ( nologfile      )
      LOCATION
       ( ''sec_audit_arch_2016-12-28'', 
         ''sec_audit_arch_2016-12-29'', 
         ''sec_audit_arch_2016-12-30'', 
         ''sec_audit_arch_2016-12-31'', 
         ''sec_audit_arch_2017-01-01'', 
         ''sec_audit_arch_2017-01-02'', 
         ''sec_audit_arch_2017-01-03'', 
         ''sec_audit_arch_2017-01-04'', 
         ''sec_audit_arch_2017-01-05'', 
         ''sec_audit_arch_2017-01-06'', 
         ''sec_audit_arch_2017-01-07'', 
         ''sec_audit_arch_2017-01-08'', 
         ''sec_audit_arch_2017-01-09'', 
         ''sec_audit_arch_2017-01-10'', 
         ''sec_audit_arch_2017-01-11'', 
         ''sec_audit_arch_2017-01-12'', 
         ''sec_audit_arch_2017-01-13'', 
         ''sec_audit_arch_2017-01-14'', 
         ''sec_audit_arch_2017-01-15'', 
         ''sec_audit_arch_2017-01-16'', 
         ''sec_audit_arch_2017-01-17'', 
         ''sec_audit_arch_2017-01-18'', 
         ''sec_audit_arch_2017-01-19'', 
         ''sec_audit_arch_2017-01-20'', 
         ''sec_audit_arch_2017-01-21'', 
         ''sec_audit_arch_2017-01-22'', 
         ''sec_audit_arch_2017-01-23'', 
         ''sec_audit_arch_2017-01-24'', 
         ''sec_audit_arch_2017-01-25'', 
         ''sec_audit_arch_2017-01-26'', 
         ''sec_audit_arch_2017-01-27''
       )
    )';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SEC_AUDIT_ARCH ***
 exec bpa.alter_policies('SEC_AUDIT_ARCH');


COMMENT ON TABLE BARS.SEC_AUDIT_ARCH IS '';
COMMENT ON COLUMN BARS.SEC_AUDIT_ARCH.REC_ID IS '';
COMMENT ON COLUMN BARS.SEC_AUDIT_ARCH.REC_UID IS '';
COMMENT ON COLUMN BARS.SEC_AUDIT_ARCH.REC_UNAME IS '';
COMMENT ON COLUMN BARS.SEC_AUDIT_ARCH.REC_UPROXY IS '';
COMMENT ON COLUMN BARS.SEC_AUDIT_ARCH.REC_DATE IS '';
COMMENT ON COLUMN BARS.SEC_AUDIT_ARCH.REC_BDATE IS '';
COMMENT ON COLUMN BARS.SEC_AUDIT_ARCH.REC_TYPE IS '';
COMMENT ON COLUMN BARS.SEC_AUDIT_ARCH.REC_MODULE IS '';
COMMENT ON COLUMN BARS.SEC_AUDIT_ARCH.REC_MESSAGE IS '';
COMMENT ON COLUMN BARS.SEC_AUDIT_ARCH.MACHINE IS '';
COMMENT ON COLUMN BARS.SEC_AUDIT_ARCH.REC_OBJECT IS '';
COMMENT ON COLUMN BARS.SEC_AUDIT_ARCH.REC_USERID IS '';
COMMENT ON COLUMN BARS.SEC_AUDIT_ARCH.BRANCH IS '';
COMMENT ON COLUMN BARS.SEC_AUDIT_ARCH.REC_STACK IS '';
COMMENT ON COLUMN BARS.SEC_AUDIT_ARCH.CLIENT_IDENTIFIER IS '';



PROMPT *** Create  grants  SEC_AUDIT_ARCH ***
grant SELECT                                                                 on SEC_AUDIT_ARCH  to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SEC_AUDIT_ARCH.sql =========*** End **
PROMPT ===================================================================================== 
