

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BR_TIER_EDIT.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BR_TIER_EDIT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BR_TIER_EDIT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BR_TIER_EDIT'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''BR_TIER_EDIT'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
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
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	BR_TP NUMBER GENERATED ALWAYS AS (2) VIRTUAL VISIBLE , 
	BRANCH VARCHAR2(8) GENERATED ALWAYS AS (''/''||KF||''/'') VIRTUAL VISIBLE 
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
COMMENT ON COLUMN BARS.BR_TIER_EDIT.BRANCH IS '';
COMMENT ON COLUMN BARS.BR_TIER_EDIT.KF IS '';
COMMENT ON COLUMN BARS.BR_TIER_EDIT.BR_TP IS '';
COMMENT ON COLUMN BARS.BR_TIER_EDIT.BR_ID IS 'Код базовой ставки';
COMMENT ON COLUMN BARS.BR_TIER_EDIT.BDATE IS 'Дата установки';
COMMENT ON COLUMN BARS.BR_TIER_EDIT.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.BR_TIER_EDIT.S IS 'Граничная сумма';
COMMENT ON COLUMN BARS.BR_TIER_EDIT.RATE IS 'Ставка';




PROMPT *** Create  constraint PK_BRTIEREDIT ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_TIER_EDIT ADD CONSTRAINT PK_BRTIEREDIT PRIMARY KEY (KF, BR_ID, KV, BDATE, S)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00111309 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_TIER_EDIT MODIFY (RATE NOT NULL ENABLE)';
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




PROMPT *** Create  constraint CC_BRTIEREDIT_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_TIER_EDIT MODIFY (KF CONSTRAINT CC_BRTIEREDIT_KF_NN NOT NULL ENABLE)';
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




PROMPT *** Create  constraint CC_BRTIEREDIT_BDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_TIER_EDIT MODIFY (BDATE CONSTRAINT CC_BRTIEREDIT_BDATE_NN NOT NULL ENABLE)';
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




PROMPT *** Create  constraint CC_BRTIEREDIT_S_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_TIER_EDIT MODIFY (S CONSTRAINT CC_BRTIEREDIT_S_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BRTIEREDIT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BRTIEREDIT ON BARS.BR_TIER_EDIT (KF, BR_ID, KV, BDATE, S) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BR_TIER_EDIT ***
grant SELECT                                                                 on BR_TIER_EDIT    to BARSAQ with grant option;
grant SELECT                                                                 on BR_TIER_EDIT    to BARSREADER_ROLE;
grant SELECT                                                                 on BR_TIER_EDIT    to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on BR_TIER_EDIT    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BR_TIER_EDIT    to BARS_DM;
grant INSERT,SELECT                                                          on BR_TIER_EDIT    to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on BR_TIER_EDIT    to DPT_ADMIN;
grant SELECT,SELECT                                                          on BR_TIER_EDIT    to KLBX;
grant SELECT                                                                 on BR_TIER_EDIT    to REFSYNC_USR;
grant SELECT                                                                 on BR_TIER_EDIT    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BR_TIER_EDIT    to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BR_TIER_EDIT.sql =========*** End *** 
PROMPT ===================================================================================== 
