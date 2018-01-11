

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAN_FIN.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAN_FIN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAN_FIN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STAN_FIN'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''STAN_FIN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAN_FIN ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAN_FIN 
   (	FIN NUMBER(38,0), 
	NAME VARCHAR2(35), 
	IP NUMBER(10,0), 
	IP3 NUMBER(10,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAN_FIN ***
 exec bpa.alter_policies('STAN_FIN');


COMMENT ON TABLE BARS.STAN_FIN IS 'Справочник финансовых состояний клиента';
COMMENT ON COLUMN BARS.STAN_FIN.FIN IS 'Фин. состояние по № п/п';
COMMENT ON COLUMN BARS.STAN_FIN.NAME IS 'Название фин.состояния клиентов';
COMMENT ON COLUMN BARS.STAN_FIN.IP IS 'Порогове значення iнтегрованого показника';
COMMENT ON COLUMN BARS.STAN_FIN.IP3 IS '';




PROMPT *** Create  constraint PK_STANFIN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAN_FIN ADD CONSTRAINT PK_STANFIN PRIMARY KEY (FIN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STANFIN_FIN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAN_FIN MODIFY (FIN CONSTRAINT CC_STANFIN_FIN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STANFIN_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAN_FIN MODIFY (NAME CONSTRAINT CC_STANFIN_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STANFIN ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STANFIN ON BARS.STAN_FIN (FIN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAN_FIN ***
grant DELETE,INSERT,SELECT,UPDATE                                            on STAN_FIN        to ABS_ADMIN;
grant SELECT                                                                 on STAN_FIN        to BARSREADER_ROLE;
grant SELECT                                                                 on STAN_FIN        to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STAN_FIN        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STAN_FIN        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on STAN_FIN        to RCC_DEAL;
grant SELECT                                                                 on STAN_FIN        to START1;
grant SELECT                                                                 on STAN_FIN        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STAN_FIN        to WR_ALL_RIGHTS;
grant SELECT                                                                 on STAN_FIN        to WR_CREDIT;
grant SELECT                                                                 on STAN_FIN        to WR_CUSTREG;
grant FLASHBACK,SELECT                                                       on STAN_FIN        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAN_FIN.sql =========*** End *** ====
PROMPT ===================================================================================== 
