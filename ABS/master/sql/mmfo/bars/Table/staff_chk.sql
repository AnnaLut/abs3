

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFF_CHK.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFF_CHK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAFF_CHK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_CHK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_CHK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFF_CHK ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFF_CHK 
   (	ID NUMBER(38,0), 
	CHKID NUMBER(38,0), 
	APPROVE NUMBER(1,0), 
	ADATE1 DATE, 
	ADATE2 DATE, 
	RDATE1 DATE, 
	RDATE2 DATE, 
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




PROMPT *** ALTER_POLICIES to STAFF_CHK ***
 exec bpa.alter_policies('STAFF_CHK');


COMMENT ON TABLE BARS.STAFF_CHK IS 'ПОЛЬЗОВАТЕЛИ <->  группы КОНТРОЛЯ';
COMMENT ON COLUMN BARS.STAFF_CHK.ID IS 'Код пользователя';
COMMENT ON COLUMN BARS.STAFF_CHK.CHKID IS 'Код группы контроля';
COMMENT ON COLUMN BARS.STAFF_CHK.APPROVE IS 'Флаг подтверждения выдачи привилегии';
COMMENT ON COLUMN BARS.STAFF_CHK.ADATE1 IS 'Дата начала действия привилегии';
COMMENT ON COLUMN BARS.STAFF_CHK.ADATE2 IS 'Дата окончания действия привилегии';
COMMENT ON COLUMN BARS.STAFF_CHK.RDATE1 IS 'Дата начала бездействия привилегии';
COMMENT ON COLUMN BARS.STAFF_CHK.RDATE2 IS 'Дата окончания бездействия привилегии';
COMMENT ON COLUMN BARS.STAFF_CHK.REVOKED IS 'Флаг подтверждения изъятия привилегии';
COMMENT ON COLUMN BARS.STAFF_CHK.GRANTOR IS 'Пользователь, выдавший привелегию';




PROMPT *** Create  constraint CC_STAFFCHK_ADATE1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_CHK ADD CONSTRAINT CC_STAFFCHK_ADATE1 CHECK (adate1 <= adate2) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFCHK_REVOKED ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_CHK ADD CONSTRAINT CC_STAFFCHK_REVOKED CHECK (revoked in (0,1)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_STAFFCHK ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_CHK ADD CONSTRAINT PK_STAFFCHK PRIMARY KEY (ID, CHKID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFCHK_APPROVE ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_CHK ADD CONSTRAINT CC_STAFFCHK_APPROVE CHECK (approve in (0,1)) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFCHK_RDATE1 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_CHK ADD CONSTRAINT CC_STAFFCHK_RDATE1 CHECK (rdate1 <= rdate2) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFCHK_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_CHK MODIFY (ID CONSTRAINT CC_STAFFCHK_ID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFCHK_CHKID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_CHK MODIFY (CHKID CONSTRAINT CC_STAFFCHK_CHKID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STAFFCHK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STAFFCHK ON BARS.STAFF_CHK (ID, CHKID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAFF_CHK ***
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFF_CHK       to ABS_ADMIN;
grant SELECT                                                                 on STAFF_CHK       to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STAFF_CHK       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STAFF_CHK       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFF_CHK       to STAFF_CHK;
grant SELECT                                                                 on STAFF_CHK       to START1;
grant SELECT                                                                 on STAFF_CHK       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STAFF_CHK       to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on STAFF_CHK       to WR_REFREAD;
grant SELECT                                                                 on STAFF_CHK       to WR_VERIFDOC;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFF_CHK.sql =========*** End *** ===
PROMPT ===================================================================================== 
