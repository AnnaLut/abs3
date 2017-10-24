

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_FILE_SUBST.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_FILE_SUBST ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_FILE_SUBST'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_FILE_SUBST'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_FILE_SUBST ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_FILE_SUBST 
   (	PARENT_BRANCH VARCHAR2(30), 
	CHILD_BRANCH VARCHAR2(30)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_FILE_SUBST ***
 exec bpa.alter_policies('DPT_FILE_SUBST');


COMMENT ON TABLE BARS.DPT_FILE_SUBST IS 'Права на прийом файлів зарахувань за інше відділення';
COMMENT ON COLUMN BARS.DPT_FILE_SUBST.PARENT_BRANCH IS 'Відділення, що приймає файл';
COMMENT ON COLUMN BARS.DPT_FILE_SUBST.CHILD_BRANCH IS 'Відділення, за яке приймається файл';




PROMPT *** Create  constraint PK_DPTFILESUBST ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_SUBST ADD CONSTRAINT PK_DPTFILESUBST PRIMARY KEY (PARENT_BRANCH, CHILD_BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTFILESUBST_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_SUBST ADD CONSTRAINT FK_DPTFILESUBST_BRANCH FOREIGN KEY (PARENT_BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTFILESUBST_BRANCH2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_SUBST ADD CONSTRAINT FK_DPTFILESUBST_BRANCH2 FOREIGN KEY (CHILD_BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILESUBST_PBRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_SUBST MODIFY (PARENT_BRANCH CONSTRAINT CC_DPTFILESUBST_PBRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTFILESUBST_CBRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_FILE_SUBST MODIFY (CHILD_BRANCH CONSTRAINT CC_DPTFILESUBST_CBRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTFILESUBST ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTFILESUBST ON BARS.DPT_FILE_SUBST (PARENT_BRANCH, CHILD_BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_FILE_SUBST ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_FILE_SUBST  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_FILE_SUBST  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_FILE_SUBST  to DPT_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_FILE_SUBST  to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DPT_FILE_SUBST  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_FILE_SUBST.sql =========*** End **
PROMPT ===================================================================================== 
