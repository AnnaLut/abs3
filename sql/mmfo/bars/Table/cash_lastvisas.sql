

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CASH_LASTVISAS.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CASH_LASTVISAS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CASH_LASTVISAS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CASH_LASTVISAS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''CASH_LASTVISAS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CASH_LASTVISAS ***
begin 
  execute immediate '
  CREATE TABLE BARS.CASH_LASTVISAS
   (	KF             VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	REF            NUMBER, 
	DAT            DATE, 
	USERID         NUMBER, 
	BRANCH         VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''),
        account_acc    number,
        ACCOUNT_branch varchar2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CASH_LASTVISAS ***
 exec bpa.alter_policies('CASH_LASTVISAS');


COMMENT ON TABLE  BARS.CASH_LASTVISAS           IS 'Последняя виза для кассовых документов';
COMMENT ON COLUMN BARS.CASH_LASTVISAS.KF        IS '';
COMMENT ON COLUMN BARS.CASH_LASTVISAS.REF       IS '';
COMMENT ON COLUMN BARS.CASH_LASTVISAS.DAT       IS '';
COMMENT ON COLUMN BARS.CASH_LASTVISAS.USERID    IS 'Последний визирь';
COMMENT ON COLUMN BARS.CASH_LASTVISAS.BRANCH    IS 'Бранч пользователя, кто ставил последнюю визу';
comment on column CASH_LASTVISAS.account_acc    is 'Идентификатор кассового счета в документе';
comment on column CASH_LASTVISAS.account_branch is 'Бранч кассового счета в документе';




PROMPT *** Create  constraint XPK_CASHLASTVISAS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_LASTVISAS ADD CONSTRAINT XPK_CASHLASTVISAS PRIMARY KEY (KF, REF, USERID, ACCOUNT_ACC)
  USING INDEX TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CASHLASTVISAS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XIE_CASHLASTVISAS_KFACCBRANCH ON BARS.CASH_LASTVISAS (KF, ACCOUNT_BRANCH) TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  index XIE_CASHISAS_DATBRANCH ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_CASHISAS_DATBRANCH ON BARS.CASH_LASTVISAS (DAT, BRANCH) 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CASH_LASTVISA ***
grant SELECT                                                                 on CASH_LASTVISAS   to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CASH_LASTVISAS.sql =========*** End ***
PROMPT ===================================================================================== 
