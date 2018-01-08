

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACCM_STATE_AGG.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACCM_STATE_AGG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACCM_STATE_AGG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ACCM_STATE_AGG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ACCM_STATE_AGG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACCM_STATE_AGG ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACCM_STATE_AGG 
   (	CALDT_ID NUMBER(38,0), 
	AGG_MONBAL CHAR(1) DEFAULT ''N'', 
	AGG_YEARBAL CHAR(1) DEFAULT ''N''
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSACCM ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACCM_STATE_AGG ***
 exec bpa.alter_policies('ACCM_STATE_AGG');


COMMENT ON TABLE BARS.ACCM_STATE_AGG IS 'Подсистема накопления. Метаописание состояний агрегатов в разрезе дат';
COMMENT ON COLUMN BARS.ACCM_STATE_AGG.CALDT_ID IS 'Ид. календарной даты';
COMMENT ON COLUMN BARS.ACCM_STATE_AGG.AGG_MONBAL IS 'Признак наличия агрегата месячного баланса';
COMMENT ON COLUMN BARS.ACCM_STATE_AGG.AGG_YEARBAL IS '';




PROMPT *** Create  constraint CC_ACCMSTATESNAP_AGGMONBAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_STATE_AGG ADD CONSTRAINT CC_ACCMSTATESNAP_AGGMONBAL CHECK (agg_monbal in (''Y'', ''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ACCMSTATEAGG ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_STATE_AGG ADD CONSTRAINT PK_ACCMSTATEAGG PRIMARY KEY (CALDT_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSACCM  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSTATESNAP_AGGYEARBAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_STATE_AGG ADD CONSTRAINT CC_ACCMSTATESNAP_AGGYEARBAL CHECK (agg_yearbal in (''Y'', ''N'')) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSTATEAGG_CALID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_STATE_AGG MODIFY (CALDT_ID CONSTRAINT CC_ACCMSTATEAGG_CALID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCMSTATEAGG_AGGMONBAL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACCM_STATE_AGG MODIFY (AGG_MONBAL CONSTRAINT CC_ACCMSTATEAGG_AGGMONBAL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCMSTATEAGG ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCMSTATEAGG ON BARS.ACCM_STATE_AGG (CALDT_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSACCM ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACCM_STATE_AGG ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCM_STATE_AGG  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACCM_STATE_AGG  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACCM_STATE_AGG  to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACCM_STATE_AGG.sql =========*** End **
PROMPT ===================================================================================== 
