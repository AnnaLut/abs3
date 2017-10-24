

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_F00$LOCAL.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_F00$LOCAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_F00$LOCAL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_F00$LOCAL'', ''FILIAL'' , ''Q'', ''Q'', ''Q'', ''Q'');
               bpa.alter_policy_info(''KL_F00$LOCAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_F00$LOCAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_F00$LOCAL 
   (	POLICY_GROUP VARCHAR2(30) DEFAULT sys_context(''bars_context'',''policy_group''), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	KODF CHAR(2), 
	A017 CHAR(1), 
	UUU CHAR(3), 
	ZZZ VARCHAR2(20), 
	PATH_O VARCHAR2(35), 
	DATF DATE, 
	NOM CHAR(1), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_F00$LOCAL ***
 exec bpa.alter_policies('KL_F00$LOCAL');


COMMENT ON TABLE BARS.KL_F00$LOCAL IS 'Локальные данные по отчетным файлам';
COMMENT ON COLUMN BARS.KL_F00$LOCAL.POLICY_GROUP IS 'Группа политик';
COMMENT ON COLUMN BARS.KL_F00$LOCAL.BRANCH IS 'Код подразделения';
COMMENT ON COLUMN BARS.KL_F00$LOCAL.KODF IS 'Код формы отчета';
COMMENT ON COLUMN BARS.KL_F00$LOCAL.A017 IS 'Код схемы предоставления';
COMMENT ON COLUMN BARS.KL_F00$LOCAL.UUU IS 'Код эл. имени';
COMMENT ON COLUMN BARS.KL_F00$LOCAL.ZZZ IS 'МФО/ Код ОблУпр. НБУ';
COMMENT ON COLUMN BARS.KL_F00$LOCAL.PATH_O IS 'Путь формирования';
COMMENT ON COLUMN BARS.KL_F00$LOCAL.DATF IS 'Дата формирования последнего отчета';
COMMENT ON COLUMN BARS.KL_F00$LOCAL.NOM IS 'Порядковый номер за день';
COMMENT ON COLUMN BARS.KL_F00$LOCAL.KF IS '';




PROMPT *** Create  constraint CC_KLFLOC_UUU_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F00$LOCAL MODIFY (UUU CONSTRAINT CC_KLFLOC_UUU_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLF00$LOCAL_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F00$LOCAL MODIFY (KF CONSTRAINT CC_KLF00$LOCAL_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLFLOC_A017_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F00$LOCAL MODIFY (A017 CONSTRAINT CC_KLFLOC_A017_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLFLOC_KODF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F00$LOCAL MODIFY (KODF CONSTRAINT CC_KLFLOC_KODF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLFLOC_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F00$LOCAL MODIFY (BRANCH CONSTRAINT CC_KLFLOC_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLFLOC_POLICYGRP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F00$LOCAL MODIFY (POLICY_GROUP CONSTRAINT CC_KLFLOC_POLICYGRP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLFLOC ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F00$LOCAL ADD CONSTRAINT FK_KLFLOC FOREIGN KEY (KODF, A017)
	  REFERENCES BARS.KL_F00$GLOBAL (KODF, A017) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLFLOC_POLICYGRP ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F00$LOCAL ADD CONSTRAINT FK_KLFLOC_POLICYGRP FOREIGN KEY (POLICY_GROUP)
	  REFERENCES BARS.POLICY_GROUPS (POLICY_GROUP) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLFLOC_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F00$LOCAL ADD CONSTRAINT FK_KLFLOC_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLFLOC_BRANCH_CC ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F00$LOCAL ADD CONSTRAINT CC_KLFLOC_BRANCH_CC CHECK (length(branch)<=8) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_KLF00$LOCAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F00$LOCAL ADD CONSTRAINT PK_KLF00$LOCAL PRIMARY KEY (KF, POLICY_GROUP, BRANCH, KODF, A017)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLF00$LOCAL_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_F00$LOCAL ADD CONSTRAINT FK_KLF00$LOCAL_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KLF00$LOCAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KLF00$LOCAL ON BARS.KL_F00$LOCAL (KF, POLICY_GROUP, BRANCH, KODF, A017) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KL_F00$LOCAL ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_F00$LOCAL    to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_F00$LOCAL    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_F00$LOCAL    to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_F00$LOCAL    to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on KL_F00$LOCAL    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_F00$LOCAL.sql =========*** End *** 
PROMPT ===================================================================================== 
