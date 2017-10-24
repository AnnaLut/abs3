

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PEREKR_B_UPDATE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PEREKR_B_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PEREKR_B_UPDATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PEREKR_B_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PEREKR_B_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.PEREKR_B_UPDATE 
   (	ID NUMBER, 
	IDS NUMBER, 
	TT CHAR(9), 
	MFOB VARCHAR2(12), 
	NLSB VARCHAR2(15), 
	POLU VARCHAR2(47), 
	NAZN VARCHAR2(160), 
	OKPO VARCHAR2(10), 
	IDR NUMBER, 
	KOEF NUMBER, 
	VOB NUMBER, 
	FORMULA VARCHAR2(255), 
	KOD NUMBER(1,0), 
	FDAT DATE, 
	USER_NAME VARCHAR2(30), 
	IDUPD NUMBER, 
	CHACTION NUMBER(1,0), 
	MFOB_TEMP VARCHAR2(12)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PEREKR_B_UPDATE ***
 exec bpa.alter_policies('PEREKR_B_UPDATE');


COMMENT ON TABLE BARS.PEREKR_B_UPDATE IS '';
COMMENT ON COLUMN BARS.PEREKR_B_UPDATE.MFOB_TEMP IS '';
COMMENT ON COLUMN BARS.PEREKR_B_UPDATE.ID IS '';
COMMENT ON COLUMN BARS.PEREKR_B_UPDATE.IDS IS '';
COMMENT ON COLUMN BARS.PEREKR_B_UPDATE.TT IS '';
COMMENT ON COLUMN BARS.PEREKR_B_UPDATE.MFOB IS '';
COMMENT ON COLUMN BARS.PEREKR_B_UPDATE.NLSB IS '';
COMMENT ON COLUMN BARS.PEREKR_B_UPDATE.POLU IS '';
COMMENT ON COLUMN BARS.PEREKR_B_UPDATE.NAZN IS '';
COMMENT ON COLUMN BARS.PEREKR_B_UPDATE.OKPO IS '';
COMMENT ON COLUMN BARS.PEREKR_B_UPDATE.IDR IS '';
COMMENT ON COLUMN BARS.PEREKR_B_UPDATE.KOEF IS '';
COMMENT ON COLUMN BARS.PEREKR_B_UPDATE.VOB IS '';
COMMENT ON COLUMN BARS.PEREKR_B_UPDATE.FORMULA IS '';
COMMENT ON COLUMN BARS.PEREKR_B_UPDATE.KOD IS '';
COMMENT ON COLUMN BARS.PEREKR_B_UPDATE.FDAT IS '';
COMMENT ON COLUMN BARS.PEREKR_B_UPDATE.USER_NAME IS '';
COMMENT ON COLUMN BARS.PEREKR_B_UPDATE.IDUPD IS '';
COMMENT ON COLUMN BARS.PEREKR_B_UPDATE.CHACTION IS '';




PROMPT *** Create  constraint R_PRKRB_UPD_S ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B_UPDATE ADD CONSTRAINT R_PRKRB_UPD_S FOREIGN KEY (IDS)
	  REFERENCES BARS.PEREKR_S (IDS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_PRKRB_UPD_R ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B_UPDATE ADD CONSTRAINT R_PRKRB_UPD_R FOREIGN KEY (IDR)
	  REFERENCES BARS.PEREKR_R (IDR) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_PEREKR_B_UPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B_UPDATE ADD CONSTRAINT XPK_PEREKR_B_UPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010831 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B_UPDATE MODIFY (USER_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010830 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B_UPDATE MODIFY (FDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010829 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B_UPDATE MODIFY (VOB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010827 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B_UPDATE MODIFY (IDR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010826 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B_UPDATE MODIFY (NAZN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010825 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B_UPDATE MODIFY (POLU NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010824 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B_UPDATE MODIFY (NLSB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010822 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B_UPDATE MODIFY (TT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010821 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B_UPDATE MODIFY (IDS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010820 ***
begin   
 execute immediate '
  ALTER TABLE BARS.PEREKR_B_UPDATE MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_PEREKR_B_UPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_PEREKR_B_UPDATE ON BARS.PEREKR_B_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PEREKR_B_UPDATE ***
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on PEREKR_B_UPDATE to ABS_ADMIN;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on PEREKR_B_UPDATE to BARS015;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on PEREKR_B_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PEREKR_B_UPDATE to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PEREKR_B_UPDATE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PEREKR_B_UPDATE.sql =========*** End *
PROMPT ===================================================================================== 
