

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_POA_BRANCHES.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_POA_BRANCHES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_POA_BRANCHES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_POA_BRANCHES'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''DPT_POA_BRANCHES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_POA_BRANCHES ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_POA_BRANCHES 
   (	BRANCH VARCHAR2(30), 
	ORD NUMBER, 
	ACTIVE NUMBER, 
	POA_ID NUMBER, 
	KRED NUMBER DEFAULT 1, 
	BOSS NUMBER DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_POA_BRANCHES ***
 exec bpa.alter_policies('DPT_POA_BRANCHES');


COMMENT ON TABLE BARS.DPT_POA_BRANCHES IS 'Привязка довіреностей на підписання депозитних договорів до відділень';
COMMENT ON COLUMN BARS.DPT_POA_BRANCHES.BRANCH IS 'Код відділення';
COMMENT ON COLUMN BARS.DPT_POA_BRANCHES.ORD IS 'Порядок';
COMMENT ON COLUMN BARS.DPT_POA_BRANCHES.ACTIVE IS 'Флаг активності';
COMMENT ON COLUMN BARS.DPT_POA_BRANCHES.POA_ID IS 'Ід. довіреності';
COMMENT ON COLUMN BARS.DPT_POA_BRANCHES.KRED IS 'Право на підписання кредитних договорів БПК';
COMMENT ON COLUMN BARS.DPT_POA_BRANCHES.BOSS IS '';




PROMPT *** Create  constraint CC_DPTPOABRANCHES_KRED ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_POA_BRANCHES ADD CONSTRAINT CC_DPTPOABRANCHES_KRED CHECK (kred in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTPOABRANCHES ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_POA_BRANCHES ADD CONSTRAINT PK_DPTPOABRANCHES PRIMARY KEY (BRANCH, ORD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTPOABRANCHES_ACTIVE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_POA_BRANCHES ADD CONSTRAINT CC_DPTPOABRANCHES_ACTIVE CHECK (active in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTPOABRANCHES_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_POA_BRANCHES MODIFY (BRANCH CONSTRAINT CC_DPTPOABRANCHES_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTPOABRANCHES_ORD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_POA_BRANCHES MODIFY (ORD CONSTRAINT CC_DPTPOABRANCHES_ORD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTPOABRANCHES_ACTIVE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_POA_BRANCHES MODIFY (ACTIVE CONSTRAINT CC_DPTPOABRANCHES_ACTIVE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTPOABRANCHES_POAID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_POA_BRANCHES MODIFY (POA_ID CONSTRAINT CC_DPTPOABRANCHES_POAID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008835 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_POA_BRANCHES MODIFY (KRED NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTPOABRANCHES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTPOABRANCHES ON BARS.DPT_POA_BRANCHES (BRANCH, ORD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_POA_BRANCHES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_POA_BRANCHES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_POA_BRANCHES to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_POA_BRANCHES to DPT_ADMIN;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_POA_BRANCHES.sql =========*** End 
PROMPT ===================================================================================== 
