

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIG_DOG_STOP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIG_DOG_STOP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIG_DOG_STOP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIG_DOG_STOP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIG_DOG_STOP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIG_DOG_STOP ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIG_DOG_STOP 
   (	DOG_ID NUMBER(38,0), 
	STOP_DATE DATE, 
	STAFF_ID NUMBER(38,0), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIG_DOG_STOP ***
 exec bpa.alter_policies('CIG_DOG_STOP');


COMMENT ON TABLE BARS.CIG_DOG_STOP IS 'Перелік договорів по яким заборонена передача даних';
COMMENT ON COLUMN BARS.CIG_DOG_STOP.DOG_ID IS 'Код договору';
COMMENT ON COLUMN BARS.CIG_DOG_STOP.STOP_DATE IS 'Дата занесення в список';
COMMENT ON COLUMN BARS.CIG_DOG_STOP.STAFF_ID IS 'Код користувача';
COMMENT ON COLUMN BARS.CIG_DOG_STOP.BRANCH IS 'Відділення';




PROMPT *** Create  constraint PK_CIGDOGSTOP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_STOP ADD CONSTRAINT PK_CIGDOGSTOP PRIMARY KEY (DOG_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGSTOP_SDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_STOP MODIFY (STOP_DATE CONSTRAINT CC_CIGDOGSTOP_SDATE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGSTOP_STAFFID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_STOP MODIFY (STAFF_ID CONSTRAINT CC_CIGDOGSTOP_STAFFID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIGDOGSTOP_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_DOG_STOP MODIFY (BRANCH CONSTRAINT CC_CIGDOGSTOP_BRANCH_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIGDOGSTOP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIGDOGSTOP ON BARS.CIG_DOG_STOP (DOG_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIG_DOG_STOP ***
grant DELETE,INSERT,SELECT                                                   on CIG_DOG_STOP    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIG_DOG_STOP    to BARS_DM;
grant DELETE,INSERT,SELECT                                                   on CIG_DOG_STOP    to CIG_ROLE;



PROMPT *** Create SYNONYM  to CIG_DOG_STOP ***

  CREATE OR REPLACE PUBLIC SYNONYM CIG_DOG_STOP FOR BARS.CIG_DOG_STOP;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIG_DOG_STOP.sql =========*** End *** 
PROMPT ===================================================================================== 
