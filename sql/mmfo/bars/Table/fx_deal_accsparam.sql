

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FX_DEAL_ACCSPARAM.sql =========*** Run
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FX_DEAL_ACCSPARAM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FX_DEAL_ACCSPARAM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FX_DEAL_ACCSPARAM'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FX_DEAL_ACCSPARAM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FX_DEAL_ACCSPARAM ***
begin 
  execute immediate '
  CREATE TABLE BARS.FX_DEAL_ACCSPARAM 
   (	NBS CHAR(4), 
	SP_ID NUMBER(22,0), 
	VALUE VARCHAR2(254)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FX_DEAL_ACCSPARAM ***
 exec bpa.alter_policies('FX_DEAL_ACCSPARAM');


COMMENT ON TABLE BARS.FX_DEAL_ACCSPARAM IS 'FOREX. Спецпараметры счетов модуля';
COMMENT ON COLUMN BARS.FX_DEAL_ACCSPARAM.NBS IS 'НБС';
COMMENT ON COLUMN BARS.FX_DEAL_ACCSPARAM.SP_ID IS 'Ид. спецпараметра';
COMMENT ON COLUMN BARS.FX_DEAL_ACCSPARAM.VALUE IS 'Значение спецпараметра';




PROMPT *** Create  constraint PK_FXDEALACCSPARAM ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_DEAL_ACCSPARAM ADD CONSTRAINT PK_FXDEALACCSPARAM PRIMARY KEY (NBS, SP_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FXDEALACCSPARAM_NBS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_DEAL_ACCSPARAM MODIFY (NBS CONSTRAINT CC_FXDEALACCSPARAM_NBS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FXDEALACCSPARAM_SPID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_DEAL_ACCSPARAM MODIFY (SP_ID CONSTRAINT CC_FXDEALACCSPARAM_SPID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FXDEALACCSPARAM_VALUE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_DEAL_ACCSPARAM MODIFY (VALUE CONSTRAINT CC_FXDEALACCSPARAM_VALUE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FXDEALACCSPARAM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FXDEALACCSPARAM ON BARS.FX_DEAL_ACCSPARAM (NBS, SP_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FX_DEAL_ACCSPARAM ***
grant SELECT                                                                 on FX_DEAL_ACCSPARAM to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FX_DEAL_ACCSPARAM to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FX_DEAL_ACCSPARAM to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FX_DEAL_ACCSPARAM to FOREX;
grant SELECT                                                                 on FX_DEAL_ACCSPARAM to UPLD;
grant FLASHBACK,SELECT                                                       on FX_DEAL_ACCSPARAM to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FX_DEAL_ACCSPARAM.sql =========*** End
PROMPT ===================================================================================== 
