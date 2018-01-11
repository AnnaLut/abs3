

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GROUPS_STAFF.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GROUPS_STAFF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GROUPS_STAFF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''GROUPS_STAFF'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''GROUPS_STAFF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GROUPS_STAFF ***
begin 
  execute immediate '
  CREATE TABLE BARS.GROUPS_STAFF 
   (	IDU NUMBER(38,0), 
	IDG NUMBER(38,0), 
	SECG NUMBER(1,0), 
	APPROVE NUMBER(1,0), 
	ADATE1 DATE, 
	ADATE2 DATE, 
	RDATE1 DATE, 
	RDATE2 DATE, 
	REVOKED NUMBER(1,0), 
	GRANTOR NUMBER(38,0), 
	SEC_SEL NUMBER(1,0), 
	SEC_CRE NUMBER(1,0), 
	SEC_DEB NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GROUPS_STAFF ***
 exec bpa.alter_policies('GROUPS_STAFF');


COMMENT ON TABLE BARS.GROUPS_STAFF IS 'ПОЛЬЗОВАТЕЛИ <->  группы ДОСТУПА';
COMMENT ON COLUMN BARS.GROUPS_STAFF.IDU IS 'Код пользователя';
COMMENT ON COLUMN BARS.GROUPS_STAFF.IDG IS 'Код группы доступа';
COMMENT ON COLUMN BARS.GROUPS_STAFF.SECG IS 'Битовая маска прав доступа Смотреть (2-й бит), Дебетовать (1-й бит), Кредитовать (0-й бит)';
COMMENT ON COLUMN BARS.GROUPS_STAFF.APPROVE IS 'Признак подтверждения прав службой безопасности
1-подтверждено, NULL/0 - нет';
COMMENT ON COLUMN BARS.GROUPS_STAFF.ADATE1 IS 'Дата начала действия привилегии';
COMMENT ON COLUMN BARS.GROUPS_STAFF.ADATE2 IS 'Дата окончания действия привилегии';
COMMENT ON COLUMN BARS.GROUPS_STAFF.RDATE1 IS 'Дата начала бездействия привилегии';
COMMENT ON COLUMN BARS.GROUPS_STAFF.RDATE2 IS 'Дата окончания бездействия привилегии';
COMMENT ON COLUMN BARS.GROUPS_STAFF.REVOKED IS 'Пометка на удаление ресурса';
COMMENT ON COLUMN BARS.GROUPS_STAFF.GRANTOR IS 'Кто создал группу (код пользователя)';
COMMENT ON COLUMN BARS.GROUPS_STAFF.SEC_SEL IS '';
COMMENT ON COLUMN BARS.GROUPS_STAFF.SEC_CRE IS '';
COMMENT ON COLUMN BARS.GROUPS_STAFF.SEC_DEB IS '';




PROMPT *** Create  constraint PK_GROUPSSTAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPS_STAFF ADD CONSTRAINT PK_GROUPSSTAFF PRIMARY KEY (IDU, IDG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GROUPSSTAFF_APPROVE ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPS_STAFF ADD CONSTRAINT CC_GROUPSSTAFF_APPROVE CHECK (approve in (0, 1)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GROUPSSTAFF_ADATE1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPS_STAFF ADD CONSTRAINT CC_GROUPSSTAFF_ADATE1 CHECK (adate1 <= adate2) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GROUPSSTAFF_RDATE1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPS_STAFF ADD CONSTRAINT CC_GROUPSSTAFF_RDATE1 CHECK (rdate1 <= rdate2) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GROUPSSTAFF_REVOKED ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPS_STAFF ADD CONSTRAINT CC_GROUPSSTAFF_REVOKED CHECK (revoked in (0,1)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GROUPSSTAFF_IDU_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPS_STAFF MODIFY (IDU CONSTRAINT CC_GROUPSSTAFF_IDU_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GROUPSSTAFF_IDG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GROUPS_STAFF MODIFY (IDG CONSTRAINT CC_GROUPSSTAFF_IDG_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_GROUPSSTAFF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_GROUPSSTAFF ON BARS.GROUPS_STAFF (IDU, IDG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  GROUPS_STAFF ***
grant DELETE,INSERT,SELECT,UPDATE                                            on GROUPS_STAFF    to ABS_ADMIN;
grant SELECT                                                                 on GROUPS_STAFF    to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on GROUPS_STAFF    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on GROUPS_STAFF    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on GROUPS_STAFF    to GROUPS_STAFF;
grant SELECT                                                                 on GROUPS_STAFF    to KLBX;
grant SELECT                                                                 on GROUPS_STAFF    to START1;
grant SELECT                                                                 on GROUPS_STAFF    to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on GROUPS_STAFF    to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on GROUPS_STAFF    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GROUPS_STAFF.sql =========*** End *** 
PROMPT ===================================================================================== 
