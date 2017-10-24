

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEAL_NUMERATOR.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEAL_NUMERATOR ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEAL_NUMERATOR ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEAL_NUMERATOR 
   (	MODULE_CODE VARCHAR2(3), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	LAST_NUM NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DEAL_NUMERATOR ***
 exec bpa.alter_policies('DEAL_NUMERATOR');


COMMENT ON TABLE BARS.DEAL_NUMERATOR IS 'Посл.использованные № договоров в разрезе модулей и подразделений';
COMMENT ON COLUMN BARS.DEAL_NUMERATOR.MODULE_CODE IS 'Код модуля';
COMMENT ON COLUMN BARS.DEAL_NUMERATOR.BRANCH IS 'Подразделение';
COMMENT ON COLUMN BARS.DEAL_NUMERATOR.LAST_NUM IS 'Последний использованный № договора';




PROMPT *** Create  constraint PK_DEALNUMERATOR ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_NUMERATOR ADD CONSTRAINT PK_DEALNUMERATOR PRIMARY KEY (MODULE_CODE, BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEALNUMERATOR_LASTNUM ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_NUMERATOR ADD CONSTRAINT CC_DEALNUMERATOR_LASTNUM CHECK (last_num >= 0) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DEALNUMERATOR_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_NUMERATOR ADD CONSTRAINT FK_DEALNUMERATOR_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEALNUMERATOR_MODULECODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_NUMERATOR MODIFY (MODULE_CODE CONSTRAINT CC_DEALNUMERATOR_MODULECODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEALNUMERATOR_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_NUMERATOR MODIFY (BRANCH CONSTRAINT CC_DEALNUMERATOR_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DEALNUMERATOR_LASTNUM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEAL_NUMERATOR MODIFY (LAST_NUM CONSTRAINT CC_DEALNUMERATOR_LASTNUM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DEALNUMERATOR ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DEALNUMERATOR ON BARS.DEAL_NUMERATOR (MODULE_CODE, BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DEAL_NUMERATOR ***
grant SELECT                                                                 on DEAL_NUMERATOR  to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DEAL_NUMERATOR  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEAL_NUMERATOR.sql =========*** End **
PROMPT ===================================================================================== 
