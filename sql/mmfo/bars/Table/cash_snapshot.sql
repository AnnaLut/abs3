

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CASH_SNAPSHOT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CASH_SNAPSHOT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CASH_SNAPSHOT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CASH_SNAPSHOT'', ''FILIAL'' , ''F'', ''F'', null, null);
               bpa.alter_policy_info(''CASH_SNAPSHOT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CASH_SNAPSHOT ***
begin 
  execute immediate '
  CREATE TABLE BARS.CASH_SNAPSHOT 
   (	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	OPDATE DATE, 
	ACC NUMBER, 
	OSTF NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CASH_SNAPSHOT ***
 exec bpa.alter_policies('CASH_SNAPSHOT');


COMMENT ON TABLE BARS.CASH_SNAPSHOT IS 'Срез по счетам кассиров (касса+ценности) на системную дату';
COMMENT ON COLUMN BARS.CASH_SNAPSHOT.BRANCH IS '';
COMMENT ON COLUMN BARS.CASH_SNAPSHOT.OPDATE IS 'Операционный день + время открытия кассы';
COMMENT ON COLUMN BARS.CASH_SNAPSHOT.ACC IS 'Операционный день + время открытия кассы';
COMMENT ON COLUMN BARS.CASH_SNAPSHOT.OSTF IS 'Входящий остаток на счете на дату открытия';
COMMENT ON COLUMN BARS.CASH_SNAPSHOT.KF IS '';




PROMPT *** Create  constraint XPK_CASHSNAPSHOT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_SNAPSHOT ADD CONSTRAINT XPK_CASHSNAPSHOT PRIMARY KEY (BRANCH, OPDATE, ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_CASHSNAPSHOT_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_SNAPSHOT ADD CONSTRAINT FK_CASHSNAPSHOT_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XFK_CASHSNAPSHOT ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_SNAPSHOT ADD CONSTRAINT XFK_CASHSNAPSHOT FOREIGN KEY (BRANCH, OPDATE)
	  REFERENCES BARS.CASH_OPEN (BRANCH, OPDATE) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CASHSNAPSHOT_BR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CASH_SNAPSHOT MODIFY (BRANCH CONSTRAINT CC_CASHSNAPSHOT_BR_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CASHSNAPSHOT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CASHSNAPSHOT ON BARS.CASH_SNAPSHOT (BRANCH, OPDATE, ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CASH_SNAPSHOT ***
grant SELECT                                                                 on CASH_SNAPSHOT   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CASH_SNAPSHOT   to BARS_DM;
grant SELECT                                                                 on CASH_SNAPSHOT   to OPER000;
grant SELECT                                                                 on CASH_SNAPSHOT   to RPBN001;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CASH_SNAPSHOT   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CASH_SNAPSHOT.sql =========*** End ***
PROMPT ===================================================================================== 
