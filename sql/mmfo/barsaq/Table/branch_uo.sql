

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARSAQ/Table/BRANCH_UO.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** Create  table BRANCH_UO ***
begin 
  execute immediate '
  CREATE TABLE BARSAQ.BRANCH_UO 
   (	BRANCH VARCHAR2(30), 
	NAME VARCHAR2(70), 
	B040 VARCHAR2(20), 
	DESCRIPTION VARCHAR2(70), 
	IDPDR NUMBER, 
	DATE_OPENED DATE DEFAULT sysdate, 
	DATE_CLOSED DATE, 
	DELETED DATE, 
	SAB VARCHAR2(6), 
	OBL VARCHAR2(2), 
	TOBO NUMBER, 
	NAME_ALT VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE AQTS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARSAQ.BRANCH_UO IS 'Довідник «Віртуальний бранч» -це об’єкт, який визначає окрему точку отримання або виплати переказів, але не є відділенням банку';
COMMENT ON COLUMN BARSAQ.BRANCH_UO.DELETED IS '';
COMMENT ON COLUMN BARSAQ.BRANCH_UO.SAB IS '';
COMMENT ON COLUMN BARSAQ.BRANCH_UO.OBL IS '';
COMMENT ON COLUMN BARSAQ.BRANCH_UO.TOBO IS '';
COMMENT ON COLUMN BARSAQ.BRANCH_UO.NAME_ALT IS '';
COMMENT ON COLUMN BARSAQ.BRANCH_UO.BRANCH IS 'Код бранча';
COMMENT ON COLUMN BARSAQ.BRANCH_UO.NAME IS 'Назва бранча';
COMMENT ON COLUMN BARSAQ.BRANCH_UO.B040 IS 'Код B040 по НБУ SPR_B040.dbf';
COMMENT ON COLUMN BARSAQ.BRANCH_UO.DESCRIPTION IS 'Додатковий опис';
COMMENT ON COLUMN BARSAQ.BRANCH_UO.IDPDR IS '№ пп ЮО-власника бранчу';
COMMENT ON COLUMN BARSAQ.BRANCH_UO.DATE_OPENED IS 'Дата открытия отделения';
COMMENT ON COLUMN BARSAQ.BRANCH_UO.DATE_CLOSED IS 'Дата закрытия бранча';




PROMPT *** Create  constraint CC_BRANCHUO_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.BRANCH_UO MODIFY (BRANCH CONSTRAINT CC_BRANCHUO_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRANCHUO_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.BRANCH_UO MODIFY (NAME CONSTRAINT CC_BRANCHUO_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRANCHUO_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.BRANCH_UO MODIFY (IDPDR CONSTRAINT CC_BRANCHUO_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRANCHUO_OPN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.BRANCH_UO MODIFY (DATE_OPENED CONSTRAINT CC_BRANCHUO_OPN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_BRANCHUO ***
begin   
 execute immediate '
  ALTER TABLE BARSAQ.BRANCH_UO ADD CONSTRAINT XPK_BRANCHUO PRIMARY KEY (BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_BRANCHUO ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARSAQ.XPK_BRANCHUO ON BARSAQ.BRANCH_UO (BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE AQTS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BRANCH_UO ***
grant SELECT                                                                 on BRANCH_UO       to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on BRANCH_UO       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARSAQ/Table/BRANCH_UO.sql =========*** End *** =
PROMPT ===================================================================================== 
