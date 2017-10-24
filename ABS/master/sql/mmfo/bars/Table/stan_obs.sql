

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAN_OBS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAN_OBS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAN_OBS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STAN_OBS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''STAN_OBS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAN_OBS ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAN_OBS 
   (	OBS NUMBER(38,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAN_OBS ***
 exec bpa.alter_policies('STAN_OBS');


COMMENT ON TABLE BARS.STAN_OBS IS 'Справочник состояний обслуживания долга';
COMMENT ON COLUMN BARS.STAN_OBS.OBS IS 'Обслуживание долга по № п/п';
COMMENT ON COLUMN BARS.STAN_OBS.NAME IS 'Название';




PROMPT *** Create  constraint PK_STANOBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAN_OBS ADD CONSTRAINT PK_STANOBS PRIMARY KEY (OBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STANOBS_OBS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAN_OBS MODIFY (OBS CONSTRAINT CC_STANOBS_OBS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STANOBS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAN_OBS MODIFY (NAME CONSTRAINT CC_STANOBS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STANOBS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STANOBS ON BARS.STAN_OBS (OBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAN_OBS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on STAN_OBS        to ABS_ADMIN;
grant SELECT                                                                 on STAN_OBS        to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STAN_OBS        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STAN_OBS        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on STAN_OBS        to RCC_DEAL;
grant SELECT                                                                 on STAN_OBS        to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STAN_OBS        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on STAN_OBS        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAN_OBS.sql =========*** End *** ====
PROMPT ===================================================================================== 
