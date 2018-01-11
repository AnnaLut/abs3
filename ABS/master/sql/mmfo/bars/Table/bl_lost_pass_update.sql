

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BL_LOST_PASS_UPDATE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BL_LOST_PASS_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BL_LOST_PASS_UPDATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BL_LOST_PASS_UPDATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BL_LOST_PASS_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BL_LOST_PASS_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.BL_LOST_PASS_UPDATE 
   (	PASS_SER VARCHAR2(2), 
	PASS_NUM VARCHAR2(6), 
	LNAME VARCHAR2(50), 
	FNAME VARCHAR2(50), 
	MNAME VARCHAR2(50), 
	BDATE DATE, 
	BASE VARCHAR2(30), 
	INFO_SOURCE VARCHAR2(30), 
	PASS_DATE DATE, 
	PASS_OFFICE VARCHAR2(300), 
	INS_DATE DATE, 
	USER_ID NUMBER, 
	PASS_NEW_ID VARCHAR2(8), 
	BASE_ID NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BL_LOST_PASS_UPDATE ***
 exec bpa.alter_policies('BL_LOST_PASS_UPDATE');


COMMENT ON TABLE BARS.BL_LOST_PASS_UPDATE IS 'История изменений УТЕРЯННЫЕ/УКРАДЕННЫЕ ПАСПОРТА';
COMMENT ON COLUMN BARS.BL_LOST_PASS_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.BL_LOST_PASS_UPDATE.PASS_SER IS 'Серия паспорта. Кириллица в верхнем регистре.';
COMMENT ON COLUMN BARS.BL_LOST_PASS_UPDATE.PASS_NUM IS 'Номер паспорта, с ведущими нулями.';
COMMENT ON COLUMN BARS.BL_LOST_PASS_UPDATE.LNAME IS 'Фамилия';
COMMENT ON COLUMN BARS.BL_LOST_PASS_UPDATE.FNAME IS 'Имя';
COMMENT ON COLUMN BARS.BL_LOST_PASS_UPDATE.MNAME IS 'Отчество';
COMMENT ON COLUMN BARS.BL_LOST_PASS_UPDATE.BDATE IS 'Дата рождения';
COMMENT ON COLUMN BARS.BL_LOST_PASS_UPDATE.BASE IS 'База данных';
COMMENT ON COLUMN BARS.BL_LOST_PASS_UPDATE.INFO_SOURCE IS 'Источник получения информации';
COMMENT ON COLUMN BARS.BL_LOST_PASS_UPDATE.PASS_DATE IS 'Дата выдачи паспорта';
COMMENT ON COLUMN BARS.BL_LOST_PASS_UPDATE.PASS_OFFICE IS 'Кем выдан паспорт';
COMMENT ON COLUMN BARS.BL_LOST_PASS_UPDATE.INS_DATE IS 'Дата добавления информации';
COMMENT ON COLUMN BARS.BL_LOST_PASS_UPDATE.USER_ID IS 'Код пользователя';
COMMENT ON COLUMN BARS.BL_LOST_PASS_UPDATE.PASS_NEW_ID IS 'Новый номер и серия паспорта';
COMMENT ON COLUMN BARS.BL_LOST_PASS_UPDATE.BASE_ID IS '';




PROMPT *** Create  constraint CC_BLLOSTPASSUPDATE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_LOST_PASS_UPDATE MODIFY (KF CONSTRAINT CC_BLLOSTPASSUPDATE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_LOST_PASS_SER_UPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_LOST_PASS_UPDATE MODIFY (PASS_SER CONSTRAINT NN_BL_LOST_PASS_SER_UPD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_LOST_PASS_NUM_UPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_LOST_PASS_UPDATE MODIFY (PASS_NUM CONSTRAINT NN_BL_LOST_PASS_NUM_UPD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_LOST_USER_UPD ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_LOST_PASS_UPDATE MODIFY (USER_ID CONSTRAINT NN_BL_LOST_USER_UPD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index BL_LOST_PASS_NUM_UPD ***
begin   
 execute immediate '
  CREATE INDEX BARS.BL_LOST_PASS_NUM_UPD ON BARS.BL_LOST_PASS_UPDATE (PASS_NUM, PASS_SER) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BL_LOST_PASS_UPDATE ***
grant SELECT                                                                 on BL_LOST_PASS_UPDATE to BARSREADER_ROLE;
grant SELECT                                                                 on BL_LOST_PASS_UPDATE to BARS_DM;
grant INSERT,SELECT                                                          on BL_LOST_PASS_UPDATE to RBL;
grant SELECT                                                                 on BL_LOST_PASS_UPDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BL_LOST_PASS_UPDATE.sql =========*** E
PROMPT ===================================================================================== 
