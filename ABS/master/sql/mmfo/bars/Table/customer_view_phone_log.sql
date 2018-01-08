

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CUSTOMER_VIEW_PHONE_LOG.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CUSTOMER_VIEW_PHONE_LOG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CUSTOMER_VIEW_PHONE_LOG'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''CUSTOMER_VIEW_PHONE_LOG'', ''WHOLE'' , ''B'', ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CUSTOMER_VIEW_PHONE_LOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.CUSTOMER_VIEW_PHONE_LOG 
   (	RNK NUMBER, 
	DATE_POST DATE, 
	PHONE VARCHAR2(50), 
	BRANCH VARCHAR2(30), 
	USERID NUMBER, 
	LOGNAME VARCHAR2(30), 
	FIO VARCHAR2(60)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CUSTOMER_VIEW_PHONE_LOG ***
 exec bpa.alter_policies('CUSTOMER_VIEW_PHONE_LOG');


COMMENT ON TABLE BARS.CUSTOMER_VIEW_PHONE_LOG IS '';
COMMENT ON COLUMN BARS.CUSTOMER_VIEW_PHONE_LOG.RNK IS '';
COMMENT ON COLUMN BARS.CUSTOMER_VIEW_PHONE_LOG.DATE_POST IS '';
COMMENT ON COLUMN BARS.CUSTOMER_VIEW_PHONE_LOG.PHONE IS '';
COMMENT ON COLUMN BARS.CUSTOMER_VIEW_PHONE_LOG.BRANCH IS '';
COMMENT ON COLUMN BARS.CUSTOMER_VIEW_PHONE_LOG.USERID IS '';
COMMENT ON COLUMN BARS.CUSTOMER_VIEW_PHONE_LOG.LOGNAME IS '';
COMMENT ON COLUMN BARS.CUSTOMER_VIEW_PHONE_LOG.FIO IS '';




PROMPT *** Create  index I_CUSTOMER_VIEW_PHONE_LOG ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_CUSTOMER_VIEW_PHONE_LOG ON BARS.CUSTOMER_VIEW_PHONE_LOG (DATE_POST, RNK) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CUSTOMER_VIEW_PHONE_LOG ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CUSTOMER_VIEW_PHONE_LOG to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CUSTOMER_VIEW_PHONE_LOG to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CUSTOMER_VIEW_PHONE_LOG.sql =========*
PROMPT ===================================================================================== 
