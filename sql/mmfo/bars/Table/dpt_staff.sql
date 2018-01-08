

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_STAFF.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_STAFF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_STAFF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_STAFF'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''DPT_STAFF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_STAFF ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_STAFF 
   (	USERID NUMBER(38,0), 
	FIO VARCHAR2(60), 
	FIO_R VARCHAR2(60), 
	DOVER VARCHAR2(200), 
	POSADA VARCHAR2(120), 
	POSADA_R VARCHAR2(120), 
	TOWN VARCHAR2(40), 
	ADRESS VARCHAR2(70), 
	MFO VARCHAR2(12), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	ISP NUMBER(38,0), 
	SEX NUMBER, 
	FIO2 VARCHAR2(60), 
	RNK NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_STAFF ***
 exec bpa.alter_policies('DPT_STAFF');


COMMENT ON TABLE BARS.DPT_STAFF IS 'Справочник доп. свойств пользователей для депозитного модуля';
COMMENT ON COLUMN BARS.DPT_STAFF.USERID IS 'Идентификатор пользователя';
COMMENT ON COLUMN BARS.DPT_STAFF.FIO IS 'ФИО ответственного пользователя';
COMMENT ON COLUMN BARS.DPT_STAFF.FIO_R IS 'ФИО ответственного пользователя (сокращенное) в род. падеже';
COMMENT ON COLUMN BARS.DPT_STAFF.DOVER IS '№ доверенности и дата заключения';
COMMENT ON COLUMN BARS.DPT_STAFF.POSADA IS 'Должность пользователя';
COMMENT ON COLUMN BARS.DPT_STAFF.POSADA_R IS 'Должность пользователя в род. падеже';
COMMENT ON COLUMN BARS.DPT_STAFF.TOWN IS 'Город';
COMMENT ON COLUMN BARS.DPT_STAFF.ADRESS IS 'Адрес подразделения банка';
COMMENT ON COLUMN BARS.DPT_STAFF.MFO IS 'МФО подразделения';
COMMENT ON COLUMN BARS.DPT_STAFF.BRANCH IS 'Код подразделения';
COMMENT ON COLUMN BARS.DPT_STAFF.ISP IS 'Код ответ.исп';
COMMENT ON COLUMN BARS.DPT_STAFF.SEX IS '';
COMMENT ON COLUMN BARS.DPT_STAFF.FIO2 IS '';
COMMENT ON COLUMN BARS.DPT_STAFF.RNK IS '';




PROMPT *** Create  constraint PK_DPTSTAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_STAFF ADD CONSTRAINT PK_DPTSTAFF PRIMARY KEY (BRANCH, USERID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTSTAFF_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_STAFF ADD CONSTRAINT FK_DPTSTAFF_BRANCH FOREIGN KEY (BRANCH)
	  REFERENCES BARS.BRANCH (BRANCH) DEFERRABLE ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTSTAFF_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_STAFF ADD CONSTRAINT FK_DPTSTAFF_BANKS FOREIGN KEY (MFO)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTSTAFF_STAFF2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_STAFF ADD CONSTRAINT FK_DPTSTAFF_STAFF2 FOREIGN KEY (ISP)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTSTAFF_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_STAFF ADD CONSTRAINT FK_DPTSTAFF_STAFF FOREIGN KEY (USERID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTSTAFF_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_STAFF MODIFY (BRANCH CONSTRAINT CC_DPTSTAFF_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTSTAFF_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_STAFF MODIFY (USERID CONSTRAINT CC_DPTSTAFF_USERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTSTAFF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTSTAFF ON BARS.DPT_STAFF (BRANCH, USERID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_STAFF ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_STAFF       to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_STAFF       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_STAFF       to BARS_DM;
grant SELECT                                                                 on DPT_STAFF       to CC_DOC;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_STAFF       to DPT;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_STAFF       to DPT_ADMIN;
grant SELECT                                                                 on DPT_STAFF       to KLBX;
grant SELECT                                                                 on DPT_STAFF       to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_STAFF       to VKLAD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_STAFF       to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DPT_STAFF       to WR_REFREAD;



PROMPT *** Create SYNONYM  to DPT_STAFF ***

  CREATE OR REPLACE PUBLIC SYNONYM DPT_STAFF FOR BARS.DPT_STAFF;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_STAFF.sql =========*** End *** ===
PROMPT ===================================================================================== 
