

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_BRANCH.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_VIDD_BRANCH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_VIDD_BRANCH'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_VIDD_BRANCH'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_VIDD_BRANCH'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_VIDD_BRANCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_VIDD_BRANCH 
   (	VIDD NUMBER(38,0), 
	BRANCH VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_VIDD_BRANCH ***
 exec bpa.alter_policies('DPT_VIDD_BRANCH');


COMMENT ON TABLE BARS.DPT_VIDD_BRANCH IS 'Подразделения <-> виды вкладов';
COMMENT ON COLUMN BARS.DPT_VIDD_BRANCH.VIDD IS 'Код вида вклада';
COMMENT ON COLUMN BARS.DPT_VIDD_BRANCH.BRANCH IS 'Код подразделения';




PROMPT *** Create  constraint CC_DPTVIDDBRANCH_VIDD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_BRANCH MODIFY (VIDD CONSTRAINT CC_DPTVIDDBRANCH_VIDD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDBRANCH_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_BRANCH MODIFY (BRANCH CONSTRAINT CC_DPTVIDDBRANCH_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTVIDDBRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_BRANCH ADD CONSTRAINT PK_DPTVIDDBRANCH PRIMARY KEY (VIDD, BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTVIDDBRANCH ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTVIDDBRANCH ON BARS.DPT_VIDD_BRANCH (VIDD, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_VIDD_BRANCH ***
grant SELECT                                                                 on DPT_VIDD_BRANCH to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_VIDD_BRANCH to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_VIDD_BRANCH to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_VIDD_BRANCH to DPT_ADMIN;
grant SELECT                                                                 on DPT_VIDD_BRANCH to UPLD;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_VIDD_BRANCH to VKLAD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_VIDD_BRANCH to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DPT_VIDD_BRANCH to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_BRANCH.sql =========*** End *
PROMPT ===================================================================================== 
