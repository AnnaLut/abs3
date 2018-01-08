

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFF_KLF00.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFF_KLF00 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAFF_KLF00'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_KLF00'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_KLF00'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFF_KLF00 ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFF_KLF00 
   (	ID NUMBER(38,0), 
	KODF CHAR(2), 
	A017 CHAR(1), 
	APPROVE NUMBER(1,0), 
	ADATE1 DATE, 
	ADATE2 DATE, 
	RDATE1 DATE, 
	RDATE2 DATE, 
	REVERSE NUMBER(1,0), 
	REVOKED NUMBER(1,0), 
	GRANTOR NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAFF_KLF00 ***
 exec bpa.alter_policies('STAFF_KLF00');


COMMENT ON TABLE BARS.STAFF_KLF00 IS 'Пользователи<->Файлы отчетности НБУ';
COMMENT ON COLUMN BARS.STAFF_KLF00.ID IS 'Код пользователя';
COMMENT ON COLUMN BARS.STAFF_KLF00.KODF IS 'Код файла';
COMMENT ON COLUMN BARS.STAFF_KLF00.A017 IS '';
COMMENT ON COLUMN BARS.STAFF_KLF00.APPROVE IS 'Признак подтверждения';
COMMENT ON COLUMN BARS.STAFF_KLF00.ADATE1 IS 'Дата начала действия привилегии';
COMMENT ON COLUMN BARS.STAFF_KLF00.ADATE2 IS 'Дата окончания действия привилегии';
COMMENT ON COLUMN BARS.STAFF_KLF00.RDATE1 IS 'Дата начала бездействия привилегии';
COMMENT ON COLUMN BARS.STAFF_KLF00.RDATE2 IS 'Дата окончания бездействия привилегии';
COMMENT ON COLUMN BARS.STAFF_KLF00.REVERSE IS '';
COMMENT ON COLUMN BARS.STAFF_KLF00.REVOKED IS 'Флаг подтверждения изъятия привилегии';
COMMENT ON COLUMN BARS.STAFF_KLF00.GRANTOR IS 'Пользователь, выдавший привелегию';




PROMPT *** Create  constraint PK_STAFFKLF ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_KLF00 ADD CONSTRAINT PK_STAFFKLF PRIMARY KEY (ID, KODF, A017)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFKLF_ADATE1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_KLF00 ADD CONSTRAINT CC_STAFFKLF_ADATE1 CHECK (adate1 <= adate2) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFKLF_A017_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_KLF00 MODIFY (A017 CONSTRAINT CC_STAFFKLF_A017_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFKLF_KODF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_KLF00 MODIFY (KODF CONSTRAINT CC_STAFFKLF_KODF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFKLF_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_KLF00 MODIFY (ID CONSTRAINT CC_STAFFKLF_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFKLF_GRANTOR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_KLF00 MODIFY (GRANTOR CONSTRAINT CC_STAFFKLF_GRANTOR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFFKLF_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_KLF00 ADD CONSTRAINT FK_STAFFKLF_STAFF FOREIGN KEY (ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFFKLF_STAFF2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_KLF00 ADD CONSTRAINT FK_STAFFKLF_STAFF2 FOREIGN KEY (GRANTOR)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFKLF_REVERSE ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_KLF00 ADD CONSTRAINT CC_STAFFKLF_REVERSE CHECK (reverse in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFKLF_RDATE1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_KLF00 ADD CONSTRAINT CC_STAFFKLF_RDATE1 CHECK (rdate1 <= rdate2) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFKLF_APPROVE ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_KLF00 ADD CONSTRAINT CC_STAFFKLF_APPROVE CHECK (approve in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFKLF_REVOKED ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_KLF00 ADD CONSTRAINT CC_STAFFKLF_REVOKED CHECK (revoked in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STAFFKLF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STAFFKLF ON BARS.STAFF_KLF00 (ID, KODF, A017) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAFF_KLF00 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFF_KLF00     to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFF_KLF00     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STAFF_KLF00     to BARS_DM;
grant SELECT                                                                 on STAFF_KLF00     to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STAFF_KLF00     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFF_KLF00.sql =========*** End *** =
PROMPT ===================================================================================== 
