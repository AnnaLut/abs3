

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BL_LOST_PASS.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BL_LOST_PASS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BL_LOST_PASS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BL_LOST_PASS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BL_LOST_PASS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BL_LOST_PASS ***
begin 
  execute immediate '
  CREATE TABLE BARS.BL_LOST_PASS 
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
	BASE_ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BL_LOST_PASS ***
 exec bpa.alter_policies('BL_LOST_PASS');


COMMENT ON TABLE BARS.BL_LOST_PASS IS 'УТЕРЯННЫЕ/УКРАДЕННЫЕ ПАСПОРТА';
COMMENT ON COLUMN BARS.BL_LOST_PASS.PASS_SER IS 'Серия паспорта. Кириллица в верхнем регистре.';
COMMENT ON COLUMN BARS.BL_LOST_PASS.PASS_NUM IS 'Номер паспорта, с ведущими нулями.';
COMMENT ON COLUMN BARS.BL_LOST_PASS.LNAME IS 'Фамилия';
COMMENT ON COLUMN BARS.BL_LOST_PASS.FNAME IS 'Имя';
COMMENT ON COLUMN BARS.BL_LOST_PASS.MNAME IS 'Отчество';
COMMENT ON COLUMN BARS.BL_LOST_PASS.BDATE IS 'Дата рождения';
COMMENT ON COLUMN BARS.BL_LOST_PASS.BASE IS 'База данных';
COMMENT ON COLUMN BARS.BL_LOST_PASS.INFO_SOURCE IS 'Источник получения информации';
COMMENT ON COLUMN BARS.BL_LOST_PASS.PASS_DATE IS 'Дата выдачи паспорта';
COMMENT ON COLUMN BARS.BL_LOST_PASS.PASS_OFFICE IS 'Кем выдан паспорт';
COMMENT ON COLUMN BARS.BL_LOST_PASS.INS_DATE IS 'Дата добавления информации';
COMMENT ON COLUMN BARS.BL_LOST_PASS.USER_ID IS 'Код пользователя';
COMMENT ON COLUMN BARS.BL_LOST_PASS.BASE_ID IS 'Код источника получения информации';




PROMPT *** Create  constraint PK_BL_LOST_PASS ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_LOST_PASS ADD CONSTRAINT PK_BL_LOST_PASS PRIMARY KEY (PASS_SER, PASS_NUM, BASE_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_LOST_PASS_SER ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_LOST_PASS MODIFY (PASS_SER CONSTRAINT NN_BL_LOST_PASS_SER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_LOST_PASS_NUM ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_LOST_PASS MODIFY (PASS_NUM CONSTRAINT NN_BL_LOST_PASS_NUM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_LOST_USER ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_LOST_PASS MODIFY (USER_ID CONSTRAINT NN_BL_LOST_USER NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NN_BL_LOST_BASE_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.BL_LOST_PASS MODIFY (BASE_ID CONSTRAINT NN_BL_LOST_BASE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index BL_LOST_PASS_NUM ***
begin   
 execute immediate '
  CREATE INDEX BARS.BL_LOST_PASS_NUM ON BARS.BL_LOST_PASS (PASS_NUM, PASS_SER) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BL_LOST_PASS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BL_LOST_PASS ON BARS.BL_LOST_PASS (PASS_SER, PASS_NUM, BASE_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BL_LOST_PASS ***
grant SELECT                                                                 on BL_LOST_PASS    to BARSREADER_ROLE;
grant SELECT                                                                 on BL_LOST_PASS    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BL_LOST_PASS    to RBL;
grant SELECT                                                                 on BL_LOST_PASS    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BL_LOST_PASS.sql =========*** End *** 
PROMPT ===================================================================================== 
