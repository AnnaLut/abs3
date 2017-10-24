

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BR_NORMAL_EDIT.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BR_NORMAL_EDIT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BR_NORMAL_EDIT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BR_NORMAL_EDIT'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''BR_NORMAL_EDIT'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BR_NORMAL_EDIT ***
begin 
  execute immediate '
  CREATE TABLE BARS.BR_NORMAL_EDIT 
   (	BR_ID NUMBER(38,0), 
	BDATE DATE DEFAULT TRUNC(SYSDATE), 
	KV NUMBER(3,0), 
	RATE NUMBER(30,8), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	BR_TP NUMBER GENERATED ALWAYS AS (1) VIRTUAL VISIBLE , 
	BRANCH VARCHAR2(8) GENERATED ALWAYS AS (''/''||KF||''/'') VIRTUAL VISIBLE 
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BR_NORMAL_EDIT ***
 exec bpa.alter_policies('BR_NORMAL_EDIT');


COMMENT ON TABLE BARS.BR_NORMAL_EDIT IS 'Значения обычных базовых процентных ставок';
COMMENT ON COLUMN BARS.BR_NORMAL_EDIT.KF IS '';
COMMENT ON COLUMN BARS.BR_NORMAL_EDIT.BR_TP IS '';
COMMENT ON COLUMN BARS.BR_NORMAL_EDIT.BRANCH IS '';
COMMENT ON COLUMN BARS.BR_NORMAL_EDIT.BR_ID IS 'Код базовой ставки';
COMMENT ON COLUMN BARS.BR_NORMAL_EDIT.BDATE IS 'Дата установки';
COMMENT ON COLUMN BARS.BR_NORMAL_EDIT.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.BR_NORMAL_EDIT.RATE IS 'Ставка';




PROMPT *** Create  constraint PK_BRNORMALEDIT ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_NORMAL_EDIT ADD CONSTRAINT PK_BRNORMALEDIT PRIMARY KEY (KF, BR_ID, KV, BDATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0085218 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_NORMAL_EDIT MODIFY (RATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRNORMALEDIT_BDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_NORMAL_EDIT ADD CONSTRAINT CC_BRNORMALEDIT_BDATE CHECK (bdate = trunc(bdate)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRNORMALEDIT_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_NORMAL_EDIT MODIFY (KV CONSTRAINT CC_BRNORMALEDIT_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRNORMALEDIT_BDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_NORMAL_EDIT MODIFY (BDATE CONSTRAINT CC_BRNORMALEDIT_BDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRNORMALEDIT_BRID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_NORMAL_EDIT MODIFY (BR_ID CONSTRAINT CC_BRNORMALEDIT_BRID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BRNORMALEDIT_BRATES2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_NORMAL_EDIT ADD CONSTRAINT FK_BRNORMALEDIT_BRATES2 FOREIGN KEY (BR_ID, BR_TP)
	  REFERENCES BARS.BRATES (BR_ID, BR_TP) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRNORMALEDIT_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_NORMAL_EDIT MODIFY (KF CONSTRAINT CC_BRNORMALEDIT_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BRNORMALEDIT_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.BR_NORMAL_EDIT ADD CONSTRAINT FK_BRNORMALEDIT_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BRNORMALEDIT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BRNORMALEDIT ON BARS.BR_NORMAL_EDIT (KF, BR_ID, KV, BDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BR_NORMAL_EDIT ***
grant SELECT                                                                 on BR_NORMAL_EDIT  to BARSAQ with grant option;
grant SELECT                                                                 on BR_NORMAL_EDIT  to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on BR_NORMAL_EDIT  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BR_NORMAL_EDIT  to BARS_DM;
grant INSERT,SELECT                                                          on BR_NORMAL_EDIT  to CUST001;
grant DELETE,INSERT,SELECT,UPDATE                                            on BR_NORMAL_EDIT  to DPT_ADMIN;
grant SELECT,SELECT                                                          on BR_NORMAL_EDIT  to KLBX;
grant SELECT                                                                 on BR_NORMAL_EDIT  to REFSYNC_USR;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BR_NORMAL_EDIT  to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BR_NORMAL_EDIT.sql =========*** End **
PROMPT ===================================================================================== 
