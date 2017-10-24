

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_ACCOUNTS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_ACCOUNTS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_ACCOUNTS'', ''WHOLE'' , null, null, null, null);
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


COMMENT ON TABLE BARS.DPT_ACCOUNTS IS '����� �� ���.��������� ���.���';
COMMENT ON COLUMN BARS.DPT_ACCOUNTS.DPTID IS '������������� ������';
COMMENT ON COLUMN BARS.DPT_ACCOUNTS.ACCID IS '������������� �����';




PROMPT *** Create  constraint FK_DPTACCOUNTS_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_ACCOUNTS ADD CONSTRAINT FK_DPTACCOUNTS_ACCOUNTS FOREIGN KEY (ACCID)
	  REFERENCES BARS.ACCOUNTS (ACC) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTACCOUNTS_DPTDPTALL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_ACCOUNTS ADD CONSTRAINT FK_DPTACCOUNTS_DPTDPTALL FOREIGN KEY (DPTID)
	  REFERENCES BARS.DPT_DEPOSIT_ALL (DEPOSIT_ID) ENABLE';
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




PROMPT *** Create  constraint CC_DPTACCOUNTS_DPTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_ACCOUNTS MODIFY (DPTID CONSTRAINT CC_DPTACCOUNTS_DPTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
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



PROMPT *** Create  grants  DPT_ACCOUNTS ***
grant SELECT                                                                 on DPT_ACCOUNTS    to BARS_ACCESS_DEFROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on DPT_ACCOUNTS    to BARS_DM;
grant SELECT                                                                 on DPT_ACCOUNTS    to START1;



PROMPT *** Create SYNONYM  to DPT_ACCOUNTS ***

  CREATE OR REPLACE PUBLIC SYNONYM DPT_ACCOUNTS FOR BARS.DPT_ACCOUNTS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_ACCOUNTS.sql =========*** End *** 
PROMPT ===================================================================================== 
