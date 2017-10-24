

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BR_TIER_EDIT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BR_TIER_EDIT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BR_TIER_EDIT'', ''FILIAL'' , null, ''F'', ''F'', ''F'');
               bpa.alter_policy_info(''BR_TIER_EDIT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BR_TIER_EDIT ***
begin 
  execute immediate '
  CREATE TABLE BARS.BR_TIER_EDIT 
   (	BR_ID NUMBER(38,0), 
	BDATE DATE DEFAULT TRUNC(SYSDATE), 
	KV NUMBER(3,0), 
	S NUMBER(24,0), 
	RATE NUMBER(30,8), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BR_TIER_EDIT ***
 exec bpa.alter_policies('BR_TIER_EDIT');


COMMENT ON TABLE BARS.BR_TIER_EDIT IS 'Значения ступенчатых базовых процентных ставок';
COMMENT ON COLUMN BARS.BR_TIER_EDIT.BR_ID IS 'Код базовой ставки';
COMMENT ON COLUMN BARS.BR_TIER_EDIT.BDATE IS 'Дата установки';
COMMENT ON COLUMN BARS.BR_TIER_EDIT.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.BR_TIER_EDIT.S IS 'Граничная сумма';
COMMENT ON COLUMN BARS.BR_TIER_EDIT.RATE IS 'Ставка';
COMMENT ON COLUMN BARS.BR_TIER_EDIT.BRANCH IS 'Код подразделения';




PROMPT *** Create  constraint FK_BRTIEREDIT_BRATES ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_TIER_EDIT ADD CONSTRAINT FK_BRTIEREDIT_BRATES FOREIGN KEY (BR_ID)
	  REFERENCES BARS.BRATES (BR_ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BRTIEREDIT_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_TIER_EDIT ADD CONSTRAINT FK_BRTIEREDIT_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BRTIEREDIT_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_TIER_EDIT ADD CONSTRAINT FK_BRTIEREDIT_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRTIEREDIT_BDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_TIER_EDIT ADD CONSTRAINT CC_BRTIEREDIT_BDATE CHECK (bdate = trunc(bdate)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRTIEREDIT_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_TIER_EDIT MODIFY (BRANCH CONSTRAINT CC_BRTIEREDIT_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRTIEREDIT_S_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_TIER_EDIT MODIFY (S CONSTRAINT CC_BRTIEREDIT_S_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRTIEREDIT_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_TIER_EDIT MODIFY (KV CONSTRAINT CC_BRTIEREDIT_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRTIEREDIT_BDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_TIER_EDIT MODIFY (BDATE CONSTRAINT CC_BRTIEREDIT_BDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRTIEREDIT_BRID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_TIER_EDIT MODIFY (BR_ID CONSTRAINT CC_BRTIEREDIT_BRID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_BRTIEREDIT ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_TIER_EDIT ADD CONSTRAINT PK_BRTIEREDIT PRIMARY KEY (BR_ID, BDATE, KV, S)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BRTIEREDIT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BRTIEREDIT ON BARS.BR_TIER_EDIT (BR_ID, BDATE, KV, S) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BR_TIER_EDIT ***
grant SELECT                                                                 on BR_TIER_EDIT    to BARS;
grant SELECT                                                                 on BR_TIER_EDIT    to BARSAQ with grant option;
grant SELECT                                                                 on BR_TIER_EDIT    to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on BR_TIER_EDIT    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BR_TIER_EDIT    to BARS_SUP;
grant INSERT,SELECT                                                          on BR_TIER_EDIT    to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on BR_TIER_EDIT    to DPT_ADMIN;
grant SELECT,SELECT                                                          on BR_TIER_EDIT    to KLBX;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BR_TIER_EDIT    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BR_TIER_EDIT.sql =========*** End *** 
PROMPT ===================================================================================== 
