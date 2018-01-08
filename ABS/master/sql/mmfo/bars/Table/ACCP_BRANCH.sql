

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCP_BRANCH.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCP_BRANCH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCP_BRANCH'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ACCP_BRANCH'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCP_BRANCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCP_BRANCH 
   (	BRANCH VARCHAR2(30), 
	OBL NUMBER(2,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCP_BRANCH ***
 exec bpa.alter_policies('ACCP_BRANCH');


COMMENT ON TABLE BARS.ACCP_BRANCH IS 'Довідник ТВБВ';
COMMENT ON COLUMN BARS.ACCP_BRANCH.BRANCH IS 'ID';
COMMENT ON COLUMN BARS.ACCP_BRANCH.OBL IS 'Приналежність ТВБВ, 1-Київ, 2-область';




PROMPT *** Create  constraint CC_ACCPBRANCH_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCP_BRANCH MODIFY (BRANCH CONSTRAINT CC_ACCPBRANCH_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCPBRANCH_OBL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCP_BRANCH MODIFY (OBL CONSTRAINT CC_ACCPBRANCH_OBL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ACCPBRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCP_BRANCH ADD CONSTRAINT PK_ACCPBRANCH PRIMARY KEY (BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCPBRANCH ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCPBRANCH ON BARS.ACCP_BRANCH (BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCP_BRANCH ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCP_BRANCH     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCP_BRANCH     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCP_BRANCH.sql =========*** End *** =
PROMPT ===================================================================================== 
