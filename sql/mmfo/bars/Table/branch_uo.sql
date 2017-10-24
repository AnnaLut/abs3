

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BRANCH_UO.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BRANCH_UO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BRANCH_UO'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BRANCH_UO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BRANCH_UO ***
begin 
  execute immediate '
  CREATE TABLE BARS.BRANCH_UO 
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
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BRANCH_UO ***
 exec bpa.alter_policies('BRANCH_UO');


COMMENT ON TABLE BARS.BRANCH_UO IS 'Довідник «Віртуальний бранч» -це об’єкт, який визначає окрему точку отримання або виплати переказів, але не є відділенням банку';
COMMENT ON COLUMN BARS.BRANCH_UO.BRANCH IS 'Код бранча';
COMMENT ON COLUMN BARS.BRANCH_UO.NAME IS 'Назва бранча';
COMMENT ON COLUMN BARS.BRANCH_UO.B040 IS 'Код B040 по НБУ SPR_B040.dbf';
COMMENT ON COLUMN BARS.BRANCH_UO.DESCRIPTION IS 'Додатковий опис';
COMMENT ON COLUMN BARS.BRANCH_UO.IDPDR IS '№ пп ЮО-власника бранчу';
COMMENT ON COLUMN BARS.BRANCH_UO.DATE_OPENED IS 'Дата открытия отделения';
COMMENT ON COLUMN BARS.BRANCH_UO.DATE_CLOSED IS 'Дата закрытия бранча';
COMMENT ON COLUMN BARS.BRANCH_UO.DELETED IS '';
COMMENT ON COLUMN BARS.BRANCH_UO.SAB IS '';
COMMENT ON COLUMN BARS.BRANCH_UO.OBL IS '';
COMMENT ON COLUMN BARS.BRANCH_UO.TOBO IS '';
COMMENT ON COLUMN BARS.BRANCH_UO.NAME_ALT IS '';




PROMPT *** Create  constraint CC_BRANCHUO_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH_UO MODIFY (BRANCH CONSTRAINT CC_BRANCHUO_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRANCHUO_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH_UO MODIFY (NAME CONSTRAINT CC_BRANCHUO_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_BRANCHUO_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH_UO ADD CONSTRAINT FK_BRANCHUO_ID FOREIGN KEY (IDPDR)
	  REFERENCES BARS.MONEX_UO (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_BRANCHUO ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH_UO ADD CONSTRAINT XPK_BRANCHUO PRIMARY KEY (BRANCH)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRANCHUO_OPN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH_UO MODIFY (DATE_OPENED CONSTRAINT CC_BRANCHUO_OPN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BRANCHUO_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.BRANCH_UO MODIFY (IDPDR CONSTRAINT CC_BRANCHUO_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_BRANCHUO ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_BRANCHUO ON BARS.BRANCH_UO (BRANCH) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  BRANCH_UO ***
grant DELETE,INSERT,SELECT,UPDATE                                            on BRANCH_UO       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BRANCH_UO       to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on BRANCH_UO       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BRANCH_UO.sql =========*** End *** ===
PROMPT ===================================================================================== 
