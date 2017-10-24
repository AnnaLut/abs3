

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CASH_LASTVISA.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CASH_LASTVISA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CASH_LASTVISA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CASH_LASTVISA'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CASH_LASTVISA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CASH_LASTVISA ***
begin 
  execute immediate '
  CREATE TABLE BARS.CASH_LASTVISA 
   (	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	REF NUMBER, 
	DAT DATE, 
	USERID NUMBER, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CASH_LASTVISA ***
 exec bpa.alter_policies('CASH_LASTVISA');


COMMENT ON TABLE BARS.CASH_LASTVISA IS 'Последняя виза для кассовых документов';
COMMENT ON COLUMN BARS.CASH_LASTVISA.KF IS '';
COMMENT ON COLUMN BARS.CASH_LASTVISA.REF IS '';
COMMENT ON COLUMN BARS.CASH_LASTVISA.DAT IS '';
COMMENT ON COLUMN BARS.CASH_LASTVISA.USERID IS 'Последний визирь';
COMMENT ON COLUMN BARS.CASH_LASTVISA.BRANCH IS 'Бранч пользователя, кто ставил последнюю визу';




PROMPT *** Create  constraint XPK_CASHLASTVISA ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_LASTVISA ADD CONSTRAINT XPK_CASHLASTVISA PRIMARY KEY (KF, REF, USERID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CASHLASTVISA_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_LASTVISA ADD CONSTRAINT FK_CASHLASTVISA_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CASHLASTVISA_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_LASTVISA MODIFY (BRANCH CONSTRAINT CC_CASHLASTVISA_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CASHLASTVISA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CASHLASTVISA ON BARS.CASH_LASTVISA (KF, REF, USERID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XIE_CASHISA_DATBRANCH ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_CASHISA_DATBRANCH ON BARS.CASH_LASTVISA (DAT, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CASH_LASTVISA ***
grant SELECT                                                                 on CASH_LASTVISA   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CASH_LASTVISA   to BARS_DM;
grant SELECT                                                                 on CASH_LASTVISA   to RPBN001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CASH_LASTVISA   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CASH_LASTVISA.sql =========*** End ***
PROMPT ===================================================================================== 
