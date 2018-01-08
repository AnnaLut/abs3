

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCT_BRANCHES.sql =========*
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to WCS_SUBPRODUCT_BRANCHES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''WCS_SUBPRODUCT_BRANCHES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SUBPRODUCT_BRANCHES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''WCS_SUBPRODUCT_BRANCHES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table WCS_SUBPRODUCT_BRANCHES ***
begin 
  execute immediate '
  CREATE TABLE BARS.WCS_SUBPRODUCT_BRANCHES 
   (	SUBPRODUCT_ID VARCHAR2(100), 
	BRANCH VARCHAR2(30), 
	START_DATE DATE DEFAULT sysdate, 
	END_DATE DATE, 
	APPLY_HIERARCHY NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to WCS_SUBPRODUCT_BRANCHES ***
 exec bpa.alter_policies('WCS_SUBPRODUCT_BRANCHES');


COMMENT ON TABLE BARS.WCS_SUBPRODUCT_BRANCHES IS 'МАКи субпродукта';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_BRANCHES.SUBPRODUCT_ID IS 'Идентификатор субпродукта';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_BRANCHES.BRANCH IS 'Идентификатор отделения';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_BRANCHES.START_DATE IS 'Дата начала действия';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_BRANCHES.END_DATE IS 'Дата окончания действия (пусто - безсрочно)';
COMMENT ON COLUMN BARS.WCS_SUBPRODUCT_BRANCHES.APPLY_HIERARCHY IS 'Применять иерархически';




PROMPT *** Create  constraint CC_SBPBRANCHES_SDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_BRANCHES MODIFY (START_DATE CONSTRAINT CC_SBPBRANCHES_SDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SBPBRANCHES_APPLYHR ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_BRANCHES ADD CONSTRAINT CC_SBPBRANCHES_APPLYHR CHECK (apply_hierarchy in (0, 1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SBPBRANCHES ***
begin   
 execute immediate '
  ALTER TABLE BARS.WCS_SUBPRODUCT_BRANCHES ADD CONSTRAINT PK_SBPBRANCHES PRIMARY KEY (SUBPRODUCT_ID, BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SBPBRANCHES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SBPBRANCHES ON BARS.WCS_SUBPRODUCT_BRANCHES (SUBPRODUCT_ID, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  WCS_SUBPRODUCT_BRANCHES ***
grant SELECT                                                                 on WCS_SUBPRODUCT_BRANCHES to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SUBPRODUCT_BRANCHES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on WCS_SUBPRODUCT_BRANCHES to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on WCS_SUBPRODUCT_BRANCHES to START1;
grant SELECT                                                                 on WCS_SUBPRODUCT_BRANCHES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/WCS_SUBPRODUCT_BRANCHES.sql =========*
PROMPT ===================================================================================== 
