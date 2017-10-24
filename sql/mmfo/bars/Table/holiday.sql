

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/HOLIDAY.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to HOLIDAY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''HOLIDAY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''HOLIDAY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''HOLIDAY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table HOLIDAY ***
begin 
  execute immediate '
  CREATE TABLE BARS.HOLIDAY 
   (	KV NUMBER(3,0), 
	HOLIDAY DATE DEFAULT TRUNC(SYSDATE), 
	 CONSTRAINT PK_HOLIDAY PRIMARY KEY (KV, HOLIDAY) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLI 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to HOLIDAY ***
 exec bpa.alter_policies('HOLIDAY');


COMMENT ON TABLE BARS.HOLIDAY IS 'Выходные и праздники';
COMMENT ON COLUMN BARS.HOLIDAY.KV IS 'Код валюты';
COMMENT ON COLUMN BARS.HOLIDAY.HOLIDAY IS '';




PROMPT *** Create  constraint CC_HOLIDAY_KV_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.HOLIDAY MODIFY (KV CONSTRAINT CC_HOLIDAY_KV_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_HOLIDAY_HOLIDAY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.HOLIDAY MODIFY (HOLIDAY CONSTRAINT CC_HOLIDAY_HOLIDAY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_HOLIDAY ***
begin   
 execute immediate '
  ALTER TABLE BARS.HOLIDAY ADD CONSTRAINT PK_HOLIDAY PRIMARY KEY (KV, HOLIDAY)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_HOLIDAY_TABVAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.HOLIDAY ADD CONSTRAINT FK_HOLIDAY_TABVAL FOREIGN KEY (KV)
	  REFERENCES BARS.TABVAL$GLOBAL (KV) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_HOLIDAY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_HOLIDAY ON BARS.HOLIDAY (KV, HOLIDAY) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  HOLIDAY ***
grant DELETE,INSERT,SELECT,UPDATE                                            on HOLIDAY         to ABS_ADMIN;
grant FLASHBACK,REFERENCES,SELECT                                            on HOLIDAY         to BARSAQ with grant option;
grant REFERENCES,SELECT                                                      on HOLIDAY         to BARSAQ_ADM with grant option;
grant SELECT                                                                 on HOLIDAY         to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on HOLIDAY         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on HOLIDAY         to BARS_DM;
grant SELECT                                                                 on HOLIDAY         to KLBX;
grant SELECT                                                                 on HOLIDAY         to START1;
grant DELETE,INSERT,UPDATE                                                   on HOLIDAY         to TECH005;
grant SELECT                                                                 on HOLIDAY         to UPLD;
grant SELECT                                                                 on HOLIDAY         to WR_ACRINT;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on HOLIDAY         to WR_ALL_RIGHTS;
grant SELECT                                                                 on HOLIDAY         to WR_DEPOSIT_U;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/HOLIDAY.sql =========*** End *** =====
PROMPT ===================================================================================== 
