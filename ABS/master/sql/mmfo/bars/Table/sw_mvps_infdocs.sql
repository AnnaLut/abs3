

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SW_MVPS_INFDOCS.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SW_MVPS_INFDOCS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SW_MVPS_INFDOCS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SW_MVPS_INFDOCS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SW_MVPS_INFDOCS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SW_MVPS_INFDOCS ***
begin 
  execute immediate '
  CREATE TABLE BARS.SW_MVPS_INFDOCS 
   (	REF NUMBER(38,0), 
	INFREF NUMBER(38,0), 
	FDAT DATE, 
	OTM NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SW_MVPS_INFDOCS ***
 exec bpa.alter_policies('SW_MVPS_INFDOCS');


COMMENT ON TABLE BARS.SW_MVPS_INFDOCS IS 'SWIFT. Сформированные уведомления по начальным документам';
COMMENT ON COLUMN BARS.SW_MVPS_INFDOCS.REF IS 'Реф. начального документа';
COMMENT ON COLUMN BARS.SW_MVPS_INFDOCS.INFREF IS 'Реф. информационного уведомления';
COMMENT ON COLUMN BARS.SW_MVPS_INFDOCS.FDAT IS 'Банковская дата проводки по корсчету';
COMMENT ON COLUMN BARS.SW_MVPS_INFDOCS.OTM IS 'Признак необходимости отправки документа';




PROMPT *** Create  constraint PK_SWMVPSINFDOC ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MVPS_INFDOCS ADD CONSTRAINT PK_SWMVPSINFDOC PRIMARY KEY (REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_SWMVPSINFDOC ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MVPS_INFDOCS ADD CONSTRAINT UK_SWMVPSINFDOC UNIQUE (INFREF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMVPSINFDOC_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MVPS_INFDOCS MODIFY (REF CONSTRAINT CC_SWMVPSINFDOC_REF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMVPSINFDOC_INFREF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MVPS_INFDOCS MODIFY (INFREF CONSTRAINT CC_SWMVPSINFDOC_INFREF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SWMVSPINFDOC_FDAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SW_MVPS_INFDOCS MODIFY (FDAT CONSTRAINT CC_SWMVSPINFDOC_FDAT_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SWMVPSINFDOC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SWMVPSINFDOC ON BARS.SW_MVPS_INFDOCS (REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_SWMVPSINFDOC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_SWMVPSINFDOC ON BARS.SW_MVPS_INFDOCS (INFREF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_SWMVPSINFDOC ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_SWMVPSINFDOC ON BARS.SW_MVPS_INFDOCS (FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS COMPRESS 1 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I2_SWMVPSINFDOC ***
begin   
 execute immediate '
  CREATE INDEX BARS.I2_SWMVPSINFDOC ON BARS.SW_MVPS_INFDOCS (OTM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SW_MVPS_INFDOCS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_MVPS_INFDOCS to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SW_MVPS_INFDOCS to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SW_MVPS_INFDOCS to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SW_MVPS_INFDOCS.sql =========*** End *
PROMPT ===================================================================================== 
