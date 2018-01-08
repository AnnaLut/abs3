

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_STAFF.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_VIDD_STAFF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_VIDD_STAFF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_VIDD_STAFF'', ''FILIAL'' , ''B'', ''B'', ''B'', ''B'');
               bpa.alter_policy_info(''DPT_VIDD_STAFF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_VIDD_STAFF ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_VIDD_STAFF 
   (	VIDD NUMBER(38,0), 
	USERID NUMBER(38,0), 
	BRANCH VARCHAR2(30), 
	APPROVE NUMBER(1,0), 
	ADATE1 DATE, 
	ADATE2 DATE, 
	RDATE1 DATE, 
	RDATE2 DATE, 
	REVOKED NUMBER(1,0), 
	GRANTOR VARCHAR2(8), 
	 CONSTRAINT PK_DPTVIDDSTAFF PRIMARY KEY (VIDD, USERID) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_VIDD_STAFF ***
 exec bpa.alter_policies('DPT_VIDD_STAFF');


COMMENT ON TABLE BARS.DPT_VIDD_STAFF IS 'Привязка пользователей к видам вкладам';
COMMENT ON COLUMN BARS.DPT_VIDD_STAFF.VIDD IS 'Код вида вклада';
COMMENT ON COLUMN BARS.DPT_VIDD_STAFF.USERID IS 'Код пользователя';
COMMENT ON COLUMN BARS.DPT_VIDD_STAFF.BRANCH IS 'Код подразделения';
COMMENT ON COLUMN BARS.DPT_VIDD_STAFF.APPROVE IS 'Признак потверждения';
COMMENT ON COLUMN BARS.DPT_VIDD_STAFF.ADATE1 IS 'Дата начала действия привилегии';
COMMENT ON COLUMN BARS.DPT_VIDD_STAFF.ADATE2 IS 'Дата окончания действия привилегии';
COMMENT ON COLUMN BARS.DPT_VIDD_STAFF.RDATE1 IS 'Дата начала бездействия привилегии';
COMMENT ON COLUMN BARS.DPT_VIDD_STAFF.RDATE2 IS 'Дата окончания бездействия привилегии';
COMMENT ON COLUMN BARS.DPT_VIDD_STAFF.REVOKED IS 'Пометка на удаление ресурса';
COMMENT ON COLUMN BARS.DPT_VIDD_STAFF.GRANTOR IS 'Кто выдал ресурс';




PROMPT *** Create  constraint CC_DPTVIDDSTAFF_VIDD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_STAFF MODIFY (VIDD CONSTRAINT CC_DPTVIDDSTAFF_VIDD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDSTAFF_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_STAFF MODIFY (USERID CONSTRAINT CC_DPTVIDDSTAFF_USERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDSTAFF_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_STAFF MODIFY (BRANCH CONSTRAINT CC_DPTVIDDSTAFF_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTVIDDSTAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_STAFF ADD CONSTRAINT PK_DPTVIDDSTAFF PRIMARY KEY (VIDD, USERID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTVIDDSTAFF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTVIDDSTAFF ON BARS.DPT_VIDD_STAFF (VIDD, USERID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_VIDD_STAFF ***
grant SELECT                                                                 on DPT_VIDD_STAFF  to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_VIDD_STAFF  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_VIDD_STAFF  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_VIDD_STAFF  to DPT_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_VIDD_STAFF  to DPT_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_VIDD_STAFF  to VKLAD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_VIDD_STAFF  to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DPT_VIDD_STAFF  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_STAFF.sql =========*** End **
PROMPT ===================================================================================== 
