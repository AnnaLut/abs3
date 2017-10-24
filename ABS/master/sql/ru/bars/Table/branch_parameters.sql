

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BRANCH_PARAMETERS.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BRANCH_PARAMETERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BRANCH_PARAMETERS'', ''FILIAL'' , ''F'', ''F'', ''F'', ''F'');
               bpa.alter_policy_info(''BRANCH_PARAMETERS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BRANCH_PARAMETERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.BRANCH_PARAMETERS 
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




PROMPT *** ALTER_POLICIES to BRANCH_PARAMETERS ***
 exec bpa.alter_policies('BRANCH_PARAMETERS');


COMMENT ON TABLE BARS.BRANCH_PARAMETERS IS 'Параметры безбалансовых отделений';
COMMENT ON COLUMN BARS.BRANCH_PARAMETERS.BRANCH IS 'Код подразделения';
COMMENT ON COLUMN BARS.BRANCH_PARAMETERS.TAG IS 'Тэг параметра';
COMMENT ON COLUMN BARS.BRANCH_PARAMETERS.VAL IS 'Значение параметра';




PROMPT *** Create  constraint FK_BRANCHPARAMS_BRANCHTAGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH_PARAMETERS ADD CONSTRAINT FK_BRANCHPARAMS_BRANCHTAGS FOREIGN KEY (TAG)
	  REFERENCES BARS.BRANCH_TAGS (TAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BRANCHPARAMS_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH_PARAMETERS ADD CONSTRAINT FK_BRANCHPARAMS_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BRANCHPARAMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH_PARAMETERS ADD CONSTRAINT PK_BRANCHPARAMS PRIMARY KEY (BRANCH, TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRANCHPARAMS_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH_PARAMETERS MODIFY (TAG CONSTRAINT CC_BRANCHPARAMS_TAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRANCHPARAMS_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH_PARAMETERS ADD CONSTRAINT CC_BRANCHPARAMS_BRANCH_NN CHECK (BRANCH IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BRANCHPARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BRANCHPARAMS ON BARS.BRANCH_PARAMETERS (BRANCH, TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BRANCH_PARAMETERS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BRANCH_PARAMETERS to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BRANCH_PARAMETERS to BARS_ACCESS_DEFROLE;
grant INSERT,UPDATE                                                          on BRANCH_PARAMETERS to CUST001;
grant SELECT                                                                 on BRANCH_PARAMETERS to KLBX;
grant SELECT                                                                 on BRANCH_PARAMETERS to SALGL;
grant SELECT                                                                 on BRANCH_PARAMETERS to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BRANCH_PARAMETERS to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on BRANCH_PARAMETERS to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BRANCH_PARAMETERS.sql =========*** End
PROMPT ===================================================================================== 
