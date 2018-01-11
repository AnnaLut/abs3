

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_1PB_2909_DOC_TMP.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_1PB_2909_DOC_TMP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_1PB_2909_DOC_TMP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_1PB_2909_DOC_TMP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_1PB_2909_DOC_TMP ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.CIM_1PB_2909_DOC_TMP 
   (	KF VARCHAR2(6), 
	REF NUMBER(38,0), 
	VDAT DATE, 
	KV NUMBER(3,0), 
	S NUMBER(24,0), 
	MFOA VARCHAR2(6), 
	MFOB VARCHAR2(6), 
	NLSA VARCHAR2(15), 
	NLSB VARCHAR2(15), 
	NAM_A VARCHAR2(38), 
	NAM_B VARCHAR2(38), 
	NAZN VARCHAR2(160), 
	N NUMBER, 
	REF1 NUMBER, 
	REF2 NUMBER, 
	REF3 NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_1PB_2909_DOC_TMP ***
 exec bpa.alter_policies('CIM_1PB_2909_DOC_TMP');


COMMENT ON TABLE BARS.CIM_1PB_2909_DOC_TMP IS 'Рух коштів через котловий 2909 (для 1ПБ)';
COMMENT ON COLUMN BARS.CIM_1PB_2909_DOC_TMP.KF IS 'Код РУ';
COMMENT ON COLUMN BARS.CIM_1PB_2909_DOC_TMP.REF IS 'Референс';
COMMENT ON COLUMN BARS.CIM_1PB_2909_DOC_TMP.VDAT IS 'Дата валютування';
COMMENT ON COLUMN BARS.CIM_1PB_2909_DOC_TMP.KV IS 'Код валюти';
COMMENT ON COLUMN BARS.CIM_1PB_2909_DOC_TMP.S IS 'Сума';
COMMENT ON COLUMN BARS.CIM_1PB_2909_DOC_TMP.MFOA IS 'МФО рахунку надходження';
COMMENT ON COLUMN BARS.CIM_1PB_2909_DOC_TMP.MFOB IS 'МФО рахунку зарахування';
COMMENT ON COLUMN BARS.CIM_1PB_2909_DOC_TMP.NLSA IS 'Рахунок надходження';
COMMENT ON COLUMN BARS.CIM_1PB_2909_DOC_TMP.NLSB IS 'Рахунок зарахування';
COMMENT ON COLUMN BARS.CIM_1PB_2909_DOC_TMP.NAM_A IS 'Назва рахунку надходження';
COMMENT ON COLUMN BARS.CIM_1PB_2909_DOC_TMP.NAM_B IS 'Назва рахунку зарахування';
COMMENT ON COLUMN BARS.CIM_1PB_2909_DOC_TMP.NAZN IS 'Призначення';
COMMENT ON COLUMN BARS.CIM_1PB_2909_DOC_TMP.N IS '';
COMMENT ON COLUMN BARS.CIM_1PB_2909_DOC_TMP.REF1 IS 'Референс наступного документа';
COMMENT ON COLUMN BARS.CIM_1PB_2909_DOC_TMP.REF2 IS 'Референс 2 документа в послідовності операцій';
COMMENT ON COLUMN BARS.CIM_1PB_2909_DOC_TMP.REF3 IS '';




PROMPT *** Create  constraint CC_CIM1PB2909DOCT_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_1PB_2909_DOC_TMP MODIFY (KF CONSTRAINT CC_CIM1PB2909DOCT_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIM1PB2909DOCT_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_1PB_2909_DOC_TMP MODIFY (REF CONSTRAINT CC_CIM1PB2909DOCT_REF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIM1PB2909DOCT_VDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_1PB_2909_DOC_TMP MODIFY (VDAT CONSTRAINT CC_CIM1PB2909DOCT_VDAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIM1PB2909DOCT_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_1PB_2909_DOC_TMP MODIFY (KV CONSTRAINT CC_CIM1PB2909DOCT_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIM1PB2909DOCT_S_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_1PB_2909_DOC_TMP MODIFY (S CONSTRAINT CC_CIM1PB2909DOCT_S_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIM1PB2909DOCT_MFOA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_1PB_2909_DOC_TMP MODIFY (MFOA CONSTRAINT CC_CIM1PB2909DOCT_MFOA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIM1PB2909DOCT_MFOB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_1PB_2909_DOC_TMP MODIFY (MFOB CONSTRAINT CC_CIM1PB2909DOCT_MFOB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIM1PB2909DOCT_NLSA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_1PB_2909_DOC_TMP MODIFY (NLSA CONSTRAINT CC_CIM1PB2909DOCT_NLSA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIM1PB2909DOCT_NLSB_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_1PB_2909_DOC_TMP MODIFY (NLSB CONSTRAINT CC_CIM1PB2909DOCT_NLSB_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CIM1PB2909DOCT_REF_UK ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIM_1PB_2909_DOC_TMP ADD CONSTRAINT CC_CIM1PB2909DOCT_REF_UK UNIQUE (REF) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index CC_CIM1PB2909DOCT_REF_UK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.CC_CIM1PB2909DOCT_REF_UK ON BARS.CIM_1PB_2909_DOC_TMP (REF) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIM_1PB_2909_DOC_TMP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_1PB_2909_DOC_TMP to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_1PB_2909_DOC_TMP to CIM_ROLE;
grant SELECT                                                                 on CIM_1PB_2909_DOC_TMP to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_1PB_2909_DOC_TMP.sql =========*** 
PROMPT ===================================================================================== 
