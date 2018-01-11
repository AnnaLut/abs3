

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_INHERITORS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_INHERITORS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_INHERITORS'', ''CENTER'' , ''E'', ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_INHERITORS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DPT_INHERITORS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_INHERITORS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_INHERITORS 
   (	DPT_ID NUMBER(38,0), 
	INHERIT_CUSTID NUMBER(38,0), 
	INHERIT_SHARE NUMBER(9,6), 
	INHERIT_DATE DATE, 
	CERTIF_NUM VARCHAR2(100), 
	CERTIF_DATE DATE, 
	BANKDATE DATE, 
	INHERIT_STATE NUMBER(1,0) DEFAULT 0, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	ATTR_INCOME NUMBER(3,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_INHERITORS ***
 exec bpa.alter_policies('DPT_INHERITORS');


COMMENT ON TABLE BARS.DPT_INHERITORS IS 'Наследники деп.договоров физ.лиц';
COMMENT ON COLUMN BARS.DPT_INHERITORS.DPT_ID IS 'Идентификатор договора';
COMMENT ON COLUMN BARS.DPT_INHERITORS.INHERIT_CUSTID IS 'Рег.номер физ.лица - наследника';
COMMENT ON COLUMN BARS.DPT_INHERITORS.INHERIT_SHARE IS 'Доля в наследстве';
COMMENT ON COLUMN BARS.DPT_INHERITORS.INHERIT_DATE IS 'Дата вступления в права наследования';
COMMENT ON COLUMN BARS.DPT_INHERITORS.CERTIF_NUM IS 'Номер свидет-ва о правах наследования';
COMMENT ON COLUMN BARS.DPT_INHERITORS.CERTIF_DATE IS 'Дата свидет-ва о правах наследования';
COMMENT ON COLUMN BARS.DPT_INHERITORS.BANKDATE IS 'Банковская дата';
COMMENT ON COLUMN BARS.DPT_INHERITORS.INHERIT_STATE IS 'Статус';
COMMENT ON COLUMN BARS.DPT_INHERITORS.KF IS '';
COMMENT ON COLUMN BARS.DPT_INHERITORS.BRANCH IS '';
COMMENT ON COLUMN BARS.DPT_INHERITORS.ATTR_INCOME IS '';




PROMPT *** Create  constraint CC_DPTINHERIT_DATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_INHERITORS ADD CONSTRAINT CC_DPTINHERIT_DATES CHECK (certif_date <= inherit_date) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTINHERIT ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_INHERITORS ADD CONSTRAINT PK_DPTINHERIT PRIMARY KEY (DPT_ID, INHERIT_CUSTID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTINHERIT_INHERITSHARE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_INHERITORS ADD CONSTRAINT CC_DPTINHERIT_INHERITSHARE CHECK (inherit_share > 0 AND inherit_share <= 100) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTINHERIT_INHERITSTATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_INHERITORS ADD CONSTRAINT CC_DPTINHERIT_INHERITSTATE CHECK (inherit_state in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTINHERIT_BANKDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_INHERITORS MODIFY (BANKDATE CONSTRAINT CC_DPTINHERIT_BANKDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTINHERIT_DPTID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_INHERITORS MODIFY (DPT_ID CONSTRAINT CC_DPTINHERIT_DPTID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTINHERIT_INHERITCUST_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_INHERITORS MODIFY (INHERIT_CUSTID CONSTRAINT CC_DPTINHERIT_INHERITCUST_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTINHERIT_INHERITSHARE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_INHERITORS MODIFY (INHERIT_SHARE CONSTRAINT CC_DPTINHERIT_INHERITSHARE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTINHERIT_INHERITDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_INHERITORS MODIFY (INHERIT_DATE CONSTRAINT CC_DPTINHERIT_INHERITDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTINHERIT_CERTIFNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_INHERITORS MODIFY (CERTIF_NUM CONSTRAINT CC_DPTINHERIT_CERTIFNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTINHERIT_CERTIFDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_INHERITORS MODIFY (CERTIF_DATE CONSTRAINT CC_DPTINHERIT_CERTIFDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTINHERIT_INHERITSTATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_INHERITORS MODIFY (INHERIT_STATE CONSTRAINT CC_DPTINHERIT_INHERITSTATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTINHERIT_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_INHERITORS MODIFY (KF CONSTRAINT CC_DPTINHERIT_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTINHERIT_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_INHERITORS MODIFY (BRANCH CONSTRAINT CC_DPTINHERIT_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTINHERITORS_ATTRINCOME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_INHERITORS MODIFY (ATTR_INCOME CONSTRAINT CC_DPTINHERITORS_ATTRINCOME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTINHERIT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTINHERIT ON BARS.DPT_INHERITORS (DPT_ID, INHERIT_CUSTID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_DPTINHERIT ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_DPTINHERIT ON BARS.DPT_INHERITORS (DPT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_INHERITORS ***
grant SELECT                                                                 on DPT_INHERITORS  to BARSREADER_ROLE;
grant SELECT                                                                 on DPT_INHERITORS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_INHERITORS  to BARS_DM;
grant SELECT                                                                 on DPT_INHERITORS  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_INHERITORS  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_INHERITORS.sql =========*** End **
PROMPT ===================================================================================== 
