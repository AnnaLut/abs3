

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_PARAMS_ARC.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_VIDD_PARAMS_ARC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_VIDD_PARAMS_ARC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_VIDD_PARAMS_ARC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_VIDD_PARAMS_ARC ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_VIDD_PARAMS_ARC 
   (	VIDD NUMBER(38,0), 
	TAG VARCHAR2(16), 
	VAL VARCHAR2(3000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_VIDD_PARAMS_ARC ***
 exec bpa.alter_policies('DPT_VIDD_PARAMS_ARC');


COMMENT ON TABLE BARS.DPT_VIDD_PARAMS_ARC IS 'Значения доп.параметров видов вкладов';
COMMENT ON COLUMN BARS.DPT_VIDD_PARAMS_ARC.VIDD IS 'Код вида вклада';
COMMENT ON COLUMN BARS.DPT_VIDD_PARAMS_ARC.TAG IS 'Код доп.параметра';
COMMENT ON COLUMN BARS.DPT_VIDD_PARAMS_ARC.VAL IS 'Значение доп.параметра';




PROMPT *** Create  constraint CC_DPTVIDDPARAMS_VIDDA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_PARAMS_ARC MODIFY (VIDD CONSTRAINT CC_DPTVIDDPARAMS_VIDDA_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDPARAMSA_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_PARAMS_ARC MODIFY (TAG CONSTRAINT CC_DPTVIDDPARAMSA_TAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDPARAMSA_VAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_PARAMS_ARC MODIFY (VAL CONSTRAINT CC_DPTVIDDPARAMSA_VAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_VIDD_PARAMS_ARC ***
grant SELECT                                                                 on DPT_VIDD_PARAMS_ARC to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on DPT_VIDD_PARAMS_ARC to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_VIDD_PARAMS_ARC to BARS_DM;
grant SELECT                                                                 on DPT_VIDD_PARAMS_ARC to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_PARAMS_ARC.sql =========*** E
PROMPT ===================================================================================== 
