

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPU_TYPES_OB22.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPU_TYPES_OB22 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPU_TYPES_OB22'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPU_TYPES_OB22'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPU_TYPES_OB22'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPU_TYPES_OB22 ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPU_TYPES_OB22 
   (	TYPE_ID NUMBER(38,0), 
	K013 CHAR(1), 
	S181 VARCHAR2(1), 
	R034 VARCHAR2(1), 
	NBS_DEP CHAR(4), 
	OB22_DEP CHAR(2), 
	NBS_INT CHAR(4), 
	OB22_INT CHAR(2), 
	NBS_EXP CHAR(4), 
	OB22_EXP CHAR(2), 
	NBS_RED CHAR(4), 
	OB22_RED CHAR(2), 
	IRVK VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPU_TYPES_OB22 ***
 exec bpa.alter_policies('DPU_TYPES_OB22');


COMMENT ON TABLE BARS.DPU_TYPES_OB22 IS 'Параметри OB22 депозитів ЮО';
COMMENT ON COLUMN BARS.DPU_TYPES_OB22.IRVK IS '';
COMMENT ON COLUMN BARS.DPU_TYPES_OB22.TYPE_ID IS 'Тип (вид) договору';
COMMENT ON COLUMN BARS.DPU_TYPES_OB22.K013 IS 'Код виду клієнта';
COMMENT ON COLUMN BARS.DPU_TYPES_OB22.S181 IS 'Код строку';
COMMENT ON COLUMN BARS.DPU_TYPES_OB22.R034 IS 'Ознака належності до національної/іноземної валюти';
COMMENT ON COLUMN BARS.DPU_TYPES_OB22.NBS_DEP IS 'Балансовий рахунок депозиту';
COMMENT ON COLUMN BARS.DPU_TYPES_OB22.OB22_DEP IS 'Значення OB22 рах. депозиту';
COMMENT ON COLUMN BARS.DPU_TYPES_OB22.NBS_INT IS 'Балансовий рахунок відсотків';
COMMENT ON COLUMN BARS.DPU_TYPES_OB22.OB22_INT IS 'Значення OB22 рах. відсотків';
COMMENT ON COLUMN BARS.DPU_TYPES_OB22.NBS_EXP IS 'Балансовий рахунок ПРОЦЕНТНИХ витрат';
COMMENT ON COLUMN BARS.DPU_TYPES_OB22.OB22_EXP IS 'Значення OB22 рах. ПРОЦЕНТНИХ витрат';
COMMENT ON COLUMN BARS.DPU_TYPES_OB22.NBS_RED IS 'Балансовий рахунок ЗМЕНШЕННЯ витрат';
COMMENT ON COLUMN BARS.DPU_TYPES_OB22.OB22_RED IS 'Значення OB22 рах. ЗМЕНШЕННЯ витрат';




PROMPT *** Create  constraint PK_DPUTYPESOB22 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES_OB22 ADD CONSTRAINT PK_DPUTYPESOB22 PRIMARY KEY (TYPE_ID, NBS_DEP, R034, S181)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUTYPESOB22_K013_IRVK ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES_OB22 ADD CONSTRAINT CC_DPUTYPESOB22_K013_IRVK CHECK ( IRVK = case when K013 = ''1'' then ''0'' else IRVK end ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUTYPESOB22_K013_S181 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES_OB22 ADD CONSTRAINT CC_DPUTYPESOB22_K013_S181 CHECK ( S181 = case when K013 = ''1'' then ''1'' else S181 end ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUTYPESOB22_S181 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES_OB22 ADD CONSTRAINT CC_DPUTYPESOB22_S181 CHECK (S181 in (''0'',''1'',''2'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUTYPESOB22_R034 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES_OB22 ADD CONSTRAINT CC_DPUTYPESOB22_R034 CHECK (R034 in (''1'',''2'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUTYPESOB22_K013_R034 ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES_OB22 ADD CONSTRAINT CC_DPUTYPESOB22_K013_R034 CHECK ( R034 = case when K013 = ''1'' then ''1'' else R034 end ) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUTYPESOB22_TYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES_OB22 MODIFY (TYPE_ID CONSTRAINT CC_DPUTYPESOB22_TYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUTYPESOB22_K013_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES_OB22 MODIFY (K013 CONSTRAINT CC_DPUTYPESOB22_K013_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUTYPESOB22_S181_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES_OB22 MODIFY (S181 CONSTRAINT CC_DPUTYPESOB22_S181_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUTYPESOB22_R034_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES_OB22 MODIFY (R034 CONSTRAINT CC_DPUTYPESOB22_R034_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUTYPESOB22_NBSDEP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES_OB22 MODIFY (NBS_DEP CONSTRAINT CC_DPUTYPESOB22_NBSDEP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUTYPESOB22_OB22DEP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES_OB22 MODIFY (OB22_DEP CONSTRAINT CC_DPUTYPESOB22_OB22DEP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUTYPESOB22_NBSINT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES_OB22 MODIFY (NBS_INT CONSTRAINT CC_DPUTYPESOB22_NBSINT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUTYPESOB22_OB22INT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES_OB22 MODIFY (OB22_INT CONSTRAINT CC_DPUTYPESOB22_OB22INT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUTYPESOB22_NBSEXP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES_OB22 MODIFY (NBS_EXP CONSTRAINT CC_DPUTYPESOB22_NBSEXP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPUTYPESOB22_OB22EXP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPU_TYPES_OB22 MODIFY (OB22_EXP CONSTRAINT CC_DPUTYPESOB22_OB22EXP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPUTYPESOB22 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPUTYPESOB22 ON BARS.DPU_TYPES_OB22 (TYPE_ID, NBS_DEP, R034, S181) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPU_TYPES_OB22 ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPU_TYPES_OB22  to ABS_ADMIN;
grant SELECT                                                                 on DPU_TYPES_OB22  to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPU_TYPES_OB22  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPU_TYPES_OB22  to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPU_TYPES_OB22  to DPT_ADMIN;
grant SELECT                                                                 on DPU_TYPES_OB22  to START1;
grant SELECT                                                                 on DPU_TYPES_OB22  to UPLD;
grant FLASHBACK,SELECT                                                       on DPU_TYPES_OB22  to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPU_TYPES_OB22.sql =========*** End **
PROMPT ===================================================================================== 
