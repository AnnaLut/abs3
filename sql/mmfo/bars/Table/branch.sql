

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BRANCH.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BRANCH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BRANCH'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BRANCH'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''BRANCH'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BRANCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.BRANCH 
   (	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	NAME VARCHAR2(70), 
	B040 VARCHAR2(20), 
	DESCRIPTION VARCHAR2(70), 
	IDPDR NUMBER(38,0), 
	DATE_OPENED DATE DEFAULT sysdate, 
	DATE_CLOSED DATE, 
	DELETED DATE, 
	SAB VARCHAR2(6), 
	OBL VARCHAR2(2) GENERATED ALWAYS AS (CASE SUBSTR(B040,9,1) WHEN ''2'' THEN SUBSTR(B040,15,2) WHEN ''0'' THEN SUBSTR(B040,4,2) WHEN ''1'' THEN SUBSTR(B040,10,2) ELSE NULL END) VIRTUAL VISIBLE , 
	TOBO NUMBER, 
	NAME_ALT VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BRANCH ***
 exec bpa.alter_policies('BRANCH');


COMMENT ON TABLE BARS.BRANCH IS 'Отделения банка';
COMMENT ON COLUMN BARS.BRANCH.BRANCH IS 'Код подразделения';
COMMENT ON COLUMN BARS.BRANCH.NAME IS 'Наименование подразделения';
COMMENT ON COLUMN BARS.BRANCH.B040 IS 'Код подразделения банка по справочнику НБУ SPR_B040.dbf';
COMMENT ON COLUMN BARS.BRANCH.DESCRIPTION IS 'Описание подразделения';
COMMENT ON COLUMN BARS.BRANCH.IDPDR IS 'Внутренний ид. подразделения';
COMMENT ON COLUMN BARS.BRANCH.DATE_OPENED IS 'Дата открытия отделения';
COMMENT ON COLUMN BARS.BRANCH.DATE_CLOSED IS 'Дата закрытия бранча';
COMMENT ON COLUMN BARS.BRANCH.DELETED IS '';
COMMENT ON COLUMN BARS.BRANCH.SAB IS '';
COMMENT ON COLUMN BARS.BRANCH.OBL IS '';
COMMENT ON COLUMN BARS.BRANCH.TOBO IS '';
COMMENT ON COLUMN BARS.BRANCH.NAME_ALT IS '';




PROMPT *** Create  constraint PK_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH ADD CONSTRAINT PK_BRANCH PRIMARY KEY (BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRANCH_BRANCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH ADD CONSTRAINT CC_BRANCH_BRANCH CHECK (REGEXP_LIKE(BRANCH, ''^/(\d{6}/){0,3}$'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRANCH_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH MODIFY (BRANCH CONSTRAINT CC_BRANCH_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRANCH_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH MODIFY (NAME CONSTRAINT CC_BRANCH_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TOBO_DATE_OPENED_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH MODIFY (DATE_OPENED CONSTRAINT CC_TOBO_DATE_OPENED_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BRANCH ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BRANCH ON BARS.BRANCH (BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BRANCH ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BRANCH          to ABS_ADMIN;
grant FLASHBACK,REFERENCES,SELECT                                            on BRANCH          to BARSAQ with grant option;
grant DELETE,INSERT,REFERENCES,SELECT,UPDATE                                 on BRANCH          to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on BRANCH          to BARSREADER_ROLE;
grant SELECT                                                                 on BRANCH          to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BRANCH          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BRANCH          to BARS_DM;
grant SELECT                                                                 on BRANCH          to CIG_ROLE;
grant SELECT                                                                 on BRANCH          to DPT_ADMIN;
grant SELECT                                                                 on BRANCH          to RCC_DEAL;
grant SELECT                                                                 on BRANCH          to RPBN001;
grant SELECT                                                                 on BRANCH          to RPBN002;
grant SELECT                                                                 on BRANCH          to SALGL;
grant DELETE,INSERT,SELECT,UPDATE                                            on BRANCH          to START1;
grant SELECT                                                                 on BRANCH          to UPLD;
grant INSERT,SELECT,UPDATE                                                   on BRANCH          to WCS_SYNC_USER;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on BRANCH          to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on BRANCH          to WR_REFREAD;



PROMPT *** Create SYNONYM  to BRANCH ***

  CREATE OR REPLACE PUBLIC SYNONYM BRANCH FOR BARS.BRANCH;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BRANCH.sql =========*** End *** ======
PROMPT ===================================================================================== 
