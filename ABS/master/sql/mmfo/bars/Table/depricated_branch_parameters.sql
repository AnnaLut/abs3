

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEPRICATED_BRANCH_PARAMETERS.sql =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEPRICATED_BRANCH_PARAMETERS ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEPRICATED_BRANCH_PARAMETERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEPRICATED_BRANCH_PARAMETERS 
   (	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	TAG VARCHAR2(16), 
	VAL VARCHAR2(250)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DEPRICATED_BRANCH_PARAMETERS ***
 exec bpa.alter_policies('DEPRICATED_BRANCH_PARAMETERS');


COMMENT ON TABLE BARS.DEPRICATED_BRANCH_PARAMETERS IS 'Параметры безбалансовых отделений';
COMMENT ON COLUMN BARS.DEPRICATED_BRANCH_PARAMETERS.BRANCH IS 'Код подразделения';
COMMENT ON COLUMN BARS.DEPRICATED_BRANCH_PARAMETERS.TAG IS 'Тэг параметра';
COMMENT ON COLUMN BARS.DEPRICATED_BRANCH_PARAMETERS.VAL IS 'Значение параметра';




PROMPT *** Create  constraint CC_BRANCHPARAMS_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEPRICATED_BRANCH_PARAMETERS ADD CONSTRAINT CC_BRANCHPARAMS_BRANCH_NN CHECK (BRANCH IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BRANCHPARAMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEPRICATED_BRANCH_PARAMETERS ADD CONSTRAINT PK_BRANCHPARAMS PRIMARY KEY (BRANCH, TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRANCHPARAMS_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEPRICATED_BRANCH_PARAMETERS MODIFY (TAG CONSTRAINT CC_BRANCHPARAMS_TAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BRANCHPARAMS_BRANCHTAGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEPRICATED_BRANCH_PARAMETERS ADD CONSTRAINT FK_BRANCHPARAMS_BRANCHTAGS FOREIGN KEY (TAG)
	  REFERENCES BARS.DEPRICATED_BRANCH_TAGS (TAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BRANCHPARAMS_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEPRICATED_BRANCH_PARAMETERS ADD CONSTRAINT FK_BRANCHPARAMS_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BRANCHPARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BRANCHPARAMS ON BARS.DEPRICATED_BRANCH_PARAMETERS (BRANCH, TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DEPRICATED_BRANCH_PARAMETERS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DEPRICATED_BRANCH_PARAMETERS to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DEPRICATED_BRANCH_PARAMETERS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DEPRICATED_BRANCH_PARAMETERS to BARS_DM;
grant INSERT,UPDATE                                                          on DEPRICATED_BRANCH_PARAMETERS to CUST001;
grant SELECT                                                                 on DEPRICATED_BRANCH_PARAMETERS to KLBX;
grant SELECT                                                                 on DEPRICATED_BRANCH_PARAMETERS to SALGL;
grant SELECT                                                                 on DEPRICATED_BRANCH_PARAMETERS to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DEPRICATED_BRANCH_PARAMETERS to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DEPRICATED_BRANCH_PARAMETERS to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEPRICATED_BRANCH_PARAMETERS.sql =====
PROMPT ===================================================================================== 
