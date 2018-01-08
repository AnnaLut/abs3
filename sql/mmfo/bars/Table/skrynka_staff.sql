

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SKRYNKA_STAFF.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SKRYNKA_STAFF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SKRYNKA_STAFF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SKRYNKA_STAFF'', ''FILIAL'' , ''Q'', ''Q'', ''Q'', ''Q'');
               bpa.alter_policy_info(''SKRYNKA_STAFF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SKRYNKA_STAFF ***
begin 
  execute immediate '
  CREATE TABLE BARS.SKRYNKA_STAFF 
   (	USERID NUMBER, 
	TIP NUMBER DEFAULT ''1'', 
	FIO VARCHAR2(160), 
	FIO_R VARCHAR2(160), 
	DOVER VARCHAR2(240), 
	POSADA VARCHAR2(260), 
	POSADA_R VARCHAR2(260), 
	TOWN VARCHAR2(40), 
	ADRESS VARCHAR2(170), 
	MFO VARCHAR2(12), 
	TELEFON VARCHAR2(30), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	MODE_TIME VARCHAR2(11) DEFAULT ''__:__-__:__'', 
	WEEKEND VARCHAR2(254) DEFAULT ''__________________'', 
	APPROVED VARCHAR2(254), 
	ID NUMBER, 
	ACTIV NUMBER DEFAULT 1
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SKRYNKA_STAFF ***
 exec bpa.alter_policies('SKRYNKA_STAFF');


COMMENT ON TABLE BARS.SKRYNKA_STAFF IS 'параметры отв исполнителей по сейфам';
COMMENT ON COLUMN BARS.SKRYNKA_STAFF.MODE_TIME IS 'Режим роботи відділення';
COMMENT ON COLUMN BARS.SKRYNKA_STAFF.WEEKEND IS 'Вихідні дні';
COMMENT ON COLUMN BARS.SKRYNKA_STAFF.APPROVED IS 'Ким і коли затверджені тарифи';
COMMENT ON COLUMN BARS.SKRYNKA_STAFF.ID IS '';
COMMENT ON COLUMN BARS.SKRYNKA_STAFF.ACTIV IS 'Активний/неактивний запис';
COMMENT ON COLUMN BARS.SKRYNKA_STAFF.USERID IS 'код пользователя';
COMMENT ON COLUMN BARS.SKRYNKA_STAFF.TIP IS 'тип исполнителя';
COMMENT ON COLUMN BARS.SKRYNKA_STAFF.FIO IS 'фио';
COMMENT ON COLUMN BARS.SKRYNKA_STAFF.FIO_R IS 'фио родительный падеж';
COMMENT ON COLUMN BARS.SKRYNKA_STAFF.DOVER IS 'доверенность';
COMMENT ON COLUMN BARS.SKRYNKA_STAFF.POSADA IS 'должность';
COMMENT ON COLUMN BARS.SKRYNKA_STAFF.POSADA_R IS 'должность родительный падеж';
COMMENT ON COLUMN BARS.SKRYNKA_STAFF.TOWN IS 'город';
COMMENT ON COLUMN BARS.SKRYNKA_STAFF.ADRESS IS 'адрес';
COMMENT ON COLUMN BARS.SKRYNKA_STAFF.MFO IS 'МФО';
COMMENT ON COLUMN BARS.SKRYNKA_STAFF.TELEFON IS '';
COMMENT ON COLUMN BARS.SKRYNKA_STAFF.BRANCH IS '';
COMMENT ON COLUMN BARS.SKRYNKA_STAFF.KF IS '';




PROMPT *** Create  constraint PK_SKRYNKASTAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_STAFF ADD CONSTRAINT PK_SKRYNKASTAFF PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



/*
PROMPT *** Create  constraint CC_SKRYNKASTAFF_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_STAFF MODIFY (USERID CONSTRAINT CC_SKRYNKASTAFF_USERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/
*/

PROMPT *** Create  constraint CC_SKRYNKASTAFF_USERID_NN ***
begin   
 execute immediate 'ALTER TABLE BARS.SKRYNKA_STAFF MODIFY  USERID NULL';
exception when others then
  if  sqlcode=-1451 then null; else raise; end if;
 end;
/


PROMPT *** Create  constraint FK_SKRYNKA_STAFF_USERID ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_STAFF ADD CONSTRAINT FK_SKRYNKA_STAFF_USERID FOREIGN KEY (USERID)
	  REFERENCES BARS.STAFF$BASE (ID) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKA_STAFF_TIP ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_STAFF ADD CONSTRAINT FK_SKRYNKA_STAFF_TIP FOREIGN KEY (TIP)
	  REFERENCES BARS.SKRYNKA_STAFF_TIP (TIP) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKASTAFF_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_STAFF ADD CONSTRAINT FK_SKRYNKASTAFF_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_SKRYNKASTAFF_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_STAFF ADD CONSTRAINT FK_SKRYNKASTAFF_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKASTAFF_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_STAFF MODIFY (KF CONSTRAINT CC_SKRYNKASTAFF_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKASTAFF_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_STAFF MODIFY (BRANCH CONSTRAINT CC_SKRYNKASTAFF_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SKRYNKASTAFF_TIP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SKRYNKA_STAFF MODIFY (TIP CONSTRAINT CC_SKRYNKASTAFF_TIP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SKRYNKASTAFF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SKRYNKASTAFF ON BARS.SKRYNKA_STAFF (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SKRYNKA_STAFF ***
grant SELECT                                                                 on SKRYNKA_STAFF   to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SKRYNKA_STAFF   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SKRYNKA_STAFF   to BARS_DM;
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on SKRYNKA_STAFF   to DEP_SKRN;
grant SELECT                                                                 on SKRYNKA_STAFF   to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SKRYNKA_STAFF   to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on SKRYNKA_STAFF   to WR_REFREAD;



PROMPT *** Create SYNONYM  to SKRYNKA_STAFF ***

  CREATE OR REPLACE PUBLIC SYNONYM SKRYNKA_STAFF FOR BARS.SKRYNKA_STAFF;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SKRYNKA_STAFF.sql =========*** End ***
PROMPT ===================================================================================== 
