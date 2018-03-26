

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_ACCOUNTS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_ACCOUNTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_ACCOUNTS'', ''CENTER'' , ''E'', ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_ACCOUNTS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DPT_ACCOUNTS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_ACCOUNTS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_ACCOUNTS 
   (	DPTID NUMBER(38,0), 
	ACCID NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	 CONSTRAINT PK_DPTACCOUNTS PRIMARY KEY (DPTID, ACCID) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSBIGI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_ACCOUNTS ***
 exec bpa.alter_policies('DPT_ACCOUNTS');


COMMENT ON TABLE BARS.DPT_ACCOUNTS IS 'Счета по деп.договорам физ.лиц';
COMMENT ON COLUMN BARS.DPT_ACCOUNTS.DPTID IS 'Идентификатор вклада';
COMMENT ON COLUMN BARS.DPT_ACCOUNTS.ACCID IS 'Идентификатор счета';
COMMENT ON COLUMN BARS.DPT_ACCOUNTS.KF IS '';




PROMPT *** Create  constraint CC_DPTACCOUNTS_DPTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_ACCOUNTS MODIFY (DPTID CONSTRAINT CC_DPTACCOUNTS_DPTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTACCOUNTS_ACCID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_ACCOUNTS MODIFY (ACCID CONSTRAINT CC_DPTACCOUNTS_ACCID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTACCOUNTS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_ACCOUNTS MODIFY (KF CONSTRAINT CC_DPTACCOUNTS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_ACCOUNTS ADD CONSTRAINT PK_DPTACCOUNTS PRIMARY KEY (DPTID, ACCID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 or sqlcode=-28667 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTACCOUNTS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTACCOUNTS ON BARS.DPT_ACCOUNTS (DPTID, ACCID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Create  index IDX_DPTACCOUNTS_ACCID ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_DPTACCOUNTS_ACCID ON BARS.DPT_ACCOUNTS (ACCID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Create  index IDX_DPTACCOUNTS_DPTID ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_DPTACCOUNTS_DPTID ON BARS.DPT_ACCOUNTS (DPTID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/


PROMPT *** Create  grants  DPT_ACCOUNTS ***
grant SELECT                                                                 on DPT_ACCOUNTS    to BARSREADER_ROLE;
grant SELECT                                                                 on DPT_ACCOUNTS    to BARS_ACCESS_DEFROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on DPT_ACCOUNTS    to BARS_DM;
grant SELECT                                                                 on DPT_ACCOUNTS    to START1;



PROMPT *** Create SYNONYM  to DPT_ACCOUNTS ***

  CREATE OR REPLACE PUBLIC SYNONYM DPT_ACCOUNTS FOR BARS.DPT_ACCOUNTS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_ACCOUNTS.sql =========*** End *** 
PROMPT ===================================================================================== 
