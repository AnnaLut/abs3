

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_1PB_RU_DOC.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_1PB_RU_DOC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_1PB_RU_DOC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_1PB_RU_DOC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_1PB_RU_DOC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_1PB_RU_DOC ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIM_1PB_RU_DOC 
   (	REF NUMBER(38,0), 
	REF_CA NUMBER(38,0), 
	KF VARCHAR2(6), 
	REF_RU NUMBER(38,0), 
	VDAT DATE, 
	KV NUMBER(3,0), 
	S NUMBER(24,2), 
	NAM_A VARCHAR2(38), 
	MFOA VARCHAR2(6), 
	MFOB VARCHAR2(6), 
	NLSA VARCHAR2(15), 
	NLSB VARCHAR2(15), 
	NAZN_RU VARCHAR2(160), 
	KOD_N_CA VARCHAR2(12), 
	KOD_N_RU VARCHAR2(12), 
	CHANGED NUMBER(1,0), 
	CL_TYPE VARCHAR2(1), 
	CL_IPN VARCHAR2(14), 
	CL_NAME VARCHAR2(38), 
	MD VARCHAR2(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_1PB_RU_DOC ***
 exec bpa.alter_policies('CIM_1PB_RU_DOC');


COMMENT ON TABLE BARS.CIM_1PB_RU_DOC IS 'Документи РУ через котловий 2909 (для 1ПБ)';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC.REF IS '';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC.REF_CA IS 'Референс ЦА';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC.KF IS 'Код РУ';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC.REF_RU IS 'Референс РУ';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC.VDAT IS 'Дата валютування';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC.KV IS 'Код валюти';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC.S IS 'Сума';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC.NAM_A IS '';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC.MFOA IS 'МФО рахунку надходження';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC.MFOB IS 'МФО рахунку зарахування';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC.NLSA IS 'Рахунок надходження';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC.NLSB IS 'Рахунок зарахування';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC.NAZN_RU IS 'Призначення пдатежу (у РУ)';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC.KOD_N_CA IS 'Код призначення (у ЦА)';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC.KOD_N_RU IS 'Код призначення (у РУ)';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC.CHANGED IS 'Змінено у ЦА';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC.CL_TYPE IS 'Тип клієнта';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC.CL_IPN IS 'ІПН клієнта';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC.CL_NAME IS 'Назва клієнта';
COMMENT ON COLUMN BARS.CIM_1PB_RU_DOC.MD IS 'Автозаміна';




PROMPT *** Create  constraint CC_CIM1PBRUDOC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_1PB_RU_DOC MODIFY (KF CONSTRAINT CC_CIM1PBRUDOC_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_CIM1PBRUDOC ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_1PB_RU_DOC ADD CONSTRAINT PK_CIM1PBRUDOC PRIMARY KEY (REF_CA)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIM1PBRUDOC_VDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_1PB_RU_DOC MODIFY (VDAT CONSTRAINT CC_CIM1PBRUDOC_VDAT_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIM1PBRUDOC_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_1PB_RU_DOC MODIFY (KV CONSTRAINT CC_CIM1PBRUDOC_KV_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIM1PBRUDOC_S_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_1PB_RU_DOC MODIFY (S CONSTRAINT CC_CIM1PBRUDOC_S_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIM1PBRUDOC_MFOA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_1PB_RU_DOC MODIFY (MFOA CONSTRAINT CC_CIM1PBRUDOC_MFOA_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIM1PBRUDOC_NLSA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_1PB_RU_DOC MODIFY (NLSA CONSTRAINT CC_CIM1PBRUDOC_NLSA_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIM1PBRUDOC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIM1PBRUDOC ON BARS.CIM_1PB_RU_DOC (REF_CA) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index CIM_1PB_RUDOC_IDX ***
begin   
 execute immediate '
  CREATE INDEX BARS.CIM_1PB_RUDOC_IDX ON BARS.CIM_1PB_RU_DOC (VDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_1PB_RU_DOC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_1PB_RU_DOC  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_1PB_RU_DOC  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_1PB_RU_DOC  to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_1PB_RU_DOC.sql =========*** End **
PROMPT ===================================================================================== 
