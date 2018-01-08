

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPU_DEALW_UPDATE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPU_DEALW_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPU_DEALW_UPDATE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPU_DEALW_UPDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''DPU_DEALW_UPDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPU_DEALW_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPU_DEALW_UPDATE 
   (	IDUPD NUMBER(38,0), 
	CHGACTION NUMBER(1,0), 
	CHGDATE DATE, 
	BDATE DATE, 
	DONEBY NUMBER(38,0), 
	DPU_ID NUMBER(38,0), 
	TAG VARCHAR2(10), 
	VALUE VARCHAR2(250), 
	KF VARCHAR2(6) DEFAULT NULL
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSBIGD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPU_DEALW_UPDATE ***
 exec bpa.alter_policies('DPU_DEALW_UPDATE');


COMMENT ON TABLE BARS.DPU_DEALW_UPDATE IS 'Історія змін дод. параметрів депозитів ЮО';
COMMENT ON COLUMN BARS.DPU_DEALW_UPDATE.IDUPD IS 'Ідентифікатор зміни параметрів';
COMMENT ON COLUMN BARS.DPU_DEALW_UPDATE.CHGACTION IS 'Тип зміни параметрів';
COMMENT ON COLUMN BARS.DPU_DEALW_UPDATE.CHGDATE IS 'Календарна дата зміни параметрів';
COMMENT ON COLUMN BARS.DPU_DEALW_UPDATE.BDATE IS 'Банківська дата зміни параметрів';
COMMENT ON COLUMN BARS.DPU_DEALW_UPDATE.DONEBY IS 'Ідентифікатор користувача, що виконав зміни';
COMMENT ON COLUMN BARS.DPU_DEALW_UPDATE.DPU_ID IS 'Ідентифікатор депозитного договору ЮО';
COMMENT ON COLUMN BARS.DPU_DEALW_UPDATE.TAG IS 'Код дод. параметру';
COMMENT ON COLUMN BARS.DPU_DEALW_UPDATE.VALUE IS 'Значення дод. параметру';
COMMENT ON COLUMN BARS.DPU_DEALW_UPDATE.KF IS '';




PROMPT *** Create  constraint CC_DPUDEALWUPDATE_CHGACTION_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEALW_UPDATE MODIFY (CHGACTION CONSTRAINT CC_DPUDEALWUPDATE_CHGACTION_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALWUPDATE_IDUPD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEALW_UPDATE MODIFY (IDUPD CONSTRAINT CC_DPUDEALWUPDATE_IDUPD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPUDEALWUPDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEALW_UPDATE ADD CONSTRAINT PK_DPUDEALWUPDATE PRIMARY KEY (IDUPD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALWUPDATE_CHGDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEALW_UPDATE MODIFY (CHGDATE CONSTRAINT CC_DPUDEALWUPDATE_CHGDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALWUPDATE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEALW_UPDATE MODIFY (KF CONSTRAINT CC_DPUDEALWUPDATE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALWUPDATE_DONEBY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEALW_UPDATE MODIFY (DONEBY CONSTRAINT CC_DPUDEALWUPDATE_DONEBY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALWUPDATE_DPUID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEALW_UPDATE MODIFY (DPU_ID CONSTRAINT CC_DPUDEALWUPDATE_DPUID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALWUPDATE_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEALW_UPDATE MODIFY (TAG CONSTRAINT CC_DPUDEALWUPDATE_TAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUDEALWUPDATE_BDATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_DEALW_UPDATE MODIFY (BDATE CONSTRAINT CC_DPUDEALWUPDATE_BDATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPUDEALWUPDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPUDEALWUPDATE ON BARS.DPU_DEALW_UPDATE (IDUPD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_DPUDEALWUPDATE ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_DPUDEALWUPDATE ON BARS.DPU_DEALW_UPDATE (DPU_ID, BDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSBIGI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPU_DEALW_UPDATE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_DEALW_UPDATE to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_DEALW_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPU_DEALW_UPDATE to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPU_DEALW_UPDATE to DPT_ADMIN;
grant SELECT                                                                 on DPU_DEALW_UPDATE to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPU_DEALW_UPDATE.sql =========*** End 
PROMPT ===================================================================================== 
