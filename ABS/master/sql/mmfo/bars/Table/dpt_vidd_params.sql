

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_PARAMS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_VIDD_PARAMS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_VIDD_PARAMS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_VIDD_PARAMS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_VIDD_PARAMS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_VIDD_PARAMS ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_VIDD_PARAMS 
   (	VIDD NUMBER(38,0), 
	TAG VARCHAR2(16), 
	VAL VARCHAR2(3000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_VIDD_PARAMS ***
 exec bpa.alter_policies('DPT_VIDD_PARAMS');


COMMENT ON TABLE BARS.DPT_VIDD_PARAMS IS 'Значения доп.параметров видов вкладов';
COMMENT ON COLUMN BARS.DPT_VIDD_PARAMS.VIDD IS 'Код вида вклада';
COMMENT ON COLUMN BARS.DPT_VIDD_PARAMS.TAG IS 'Код доп.параметра';
COMMENT ON COLUMN BARS.DPT_VIDD_PARAMS.VAL IS 'Значение доп.параметра';




PROMPT *** Create  constraint CC_TAGVALDAT ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_PARAMS ADD CONSTRAINT CC_TAGVALDAT CHECK ((tag =''FORB_EARLY_DATE'' and regexp_like(val,''^[[:digit:]]{1,2}/[[:digit:]]{1,2}/[[:digit:]]{4}$'')) or tag !=''FORB_EARLY_DATE'') ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_DPTVIDDPARAMS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_PARAMS ADD CONSTRAINT PK_DPTVIDDPARAMS PRIMARY KEY (VIDD, TAG)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDDPARAMS_DPTVIDD ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_PARAMS ADD CONSTRAINT FK_DPTVIDDPARAMS_DPTVIDD FOREIGN KEY (VIDD)
	  REFERENCES BARS.DPT_VIDD (VIDD) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_DPTVIDDPARAMS_DPTVIDDTAGS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_PARAMS ADD CONSTRAINT FK_DPTVIDDPARAMS_DPTVIDDTAGS FOREIGN KEY (TAG)
	  REFERENCES BARS.DPT_VIDD_TAGS (TAG) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDPARAMS_VIDD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_PARAMS MODIFY (VIDD CONSTRAINT CC_DPTVIDDPARAMS_VIDD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDPARAMS_TAG_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_PARAMS MODIFY (TAG CONSTRAINT CC_DPTVIDDPARAMS_TAG_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTVIDDPARAMS_VAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_VIDD_PARAMS MODIFY (VAL CONSTRAINT CC_DPTVIDDPARAMS_VAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTVIDDPARAMS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTVIDDPARAMS ON BARS.DPT_VIDD_PARAMS (VIDD, TAG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_VIDD_PARAMS ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on DPT_VIDD_PARAMS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_VIDD_PARAMS to BARS_DM;
grant SELECT                                                                 on DPT_VIDD_PARAMS to DPT_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_VIDD_PARAMS to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to DPT_VIDD_PARAMS ***

  CREATE OR REPLACE PUBLIC SYNONYM DPT_VIDD_PARAMS FOR BARS.DPT_VIDD_PARAMS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_VIDD_PARAMS.sql =========*** End *
PROMPT ===================================================================================== 
