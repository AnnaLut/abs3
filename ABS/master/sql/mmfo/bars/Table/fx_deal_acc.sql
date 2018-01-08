

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FX_DEAL_ACC.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FX_DEAL_ACC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FX_DEAL_ACC'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''FX_DEAL_ACC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FX_DEAL_ACC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FX_DEAL_ACC ***
begin 
  execute immediate '
  CREATE TABLE BARS.FX_DEAL_ACC 
   (	ID NUMBER(22,0), 
	RNK NUMBER(38,0), 
	FX_TYPE VARCHAR2(15), 
	KV_TYPE VARCHAR2(1), 
	KV NUMBER(3,0), 
	ACC9 NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FX_DEAL_ACC ***
 exec bpa.alter_policies('FX_DEAL_ACC');


COMMENT ON TABLE BARS.FX_DEAL_ACC IS 'FOREX. Групи рахунків клієнтів';
COMMENT ON COLUMN BARS.FX_DEAL_ACC.ID IS 'Ід.';
COMMENT ON COLUMN BARS.FX_DEAL_ACC.RNK IS 'РНК';
COMMENT ON COLUMN BARS.FX_DEAL_ACC.FX_TYPE IS 'Тип FOREX-угоди';
COMMENT ON COLUMN BARS.FX_DEAL_ACC.KV_TYPE IS 'Валюта А/Б';
COMMENT ON COLUMN BARS.FX_DEAL_ACC.KV IS 'Валюта';
COMMENT ON COLUMN BARS.FX_DEAL_ACC.ACC9 IS 'Рахунок 9200(Спот)/9202(Форвард)-ВалА / 9210(Форвард)/9212(Форвард)-ВалБ';




PROMPT *** Create  constraint PK_FXDEALACC ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_DEAL_ACC ADD CONSTRAINT PK_FXDEALACC PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FXDEALACC_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_DEAL_ACC MODIFY (ID CONSTRAINT CC_FXDEALACC_ID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FXDEALACC_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_DEAL_ACC MODIFY (RNK CONSTRAINT CC_FXDEALACC_RNK_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FXDEALACC_FXTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_DEAL_ACC MODIFY (FX_TYPE CONSTRAINT CC_FXDEALACC_FXTYPE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FXDEALACC_KVTYPE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_DEAL_ACC MODIFY (KV_TYPE CONSTRAINT CC_FXDEALACC_KVTYPE_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FXDEALACC_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_DEAL_ACC MODIFY (KV CONSTRAINT CC_FXDEALACC_KV_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FXDEALACC_ACC9_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_DEAL_ACC MODIFY (ACC9 CONSTRAINT CC_FXDEALACC_ACC9_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FXDELACC_KVTYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.FX_DEAL_ACC ADD CONSTRAINT CC_FXDELACC_KVTYPE CHECK (kv_type in (''A'', ''B'')) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FXDEALACC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FXDEALACC ON BARS.FX_DEAL_ACC (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FX_DEAL_ACC ***
grant SELECT                                                                 on FX_DEAL_ACC     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on FX_DEAL_ACC     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FX_DEAL_ACC     to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FX_DEAL_ACC     to FOREX;
grant SELECT                                                                 on FX_DEAL_ACC     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FX_DEAL_ACC.sql =========*** End *** =
PROMPT ===================================================================================== 
