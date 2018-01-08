

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_OBS_S080.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_OBS_S080 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_OBS_S080'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_OBS_S080'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_OBS_S080'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_OBS_S080 ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_OBS_S080 
   (	FIN NUMBER(38,0), 
	OBS NUMBER(38,0), 
	S080 VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_OBS_S080 ***
 exec bpa.alter_policies('FIN_OBS_S080');


COMMENT ON TABLE BARS.FIN_OBS_S080 IS '';
COMMENT ON COLUMN BARS.FIN_OBS_S080.FIN IS '';
COMMENT ON COLUMN BARS.FIN_OBS_S080.OBS IS '';
COMMENT ON COLUMN BARS.FIN_OBS_S080.S080 IS '';




PROMPT *** Create  constraint XPK_FIN_OBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_OBS_S080 ADD CONSTRAINT XPK_FIN_OBS PRIMARY KEY (FIN, OBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_FIN_FIN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_OBS_S080 ADD CONSTRAINT R_FIN_FIN FOREIGN KEY (FIN)
	  REFERENCES BARS.STAN_FIN (FIN) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_FIN_RISK ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_OBS_S080 ADD CONSTRAINT R_FIN_RISK FOREIGN KEY (S080)
	  REFERENCES BARS.CRISK (CRISK) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint R_OBS_OBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_OBS_S080 ADD CONSTRAINT R_OBS_OBS FOREIGN KEY (OBS)
	  REFERENCES BARS.STAN_OBS (OBS) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_FIN_OBS_S080_FIN ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_OBS_S080 MODIFY (FIN CONSTRAINT NK_FIN_OBS_S080_FIN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_FIN_OBS_S080_OBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_OBS_S080 MODIFY (OBS CONSTRAINT NK_FIN_OBS_S080_OBS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FIN_OBS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FIN_OBS ON BARS.FIN_OBS_S080 (FIN, OBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_OBS_S080 ***
grant SELECT                                                                 on FIN_OBS_S080    to ABS_ADMIN;
grant SELECT                                                                 on FIN_OBS_S080    to BARS009;
grant SELECT                                                                 on FIN_OBS_S080    to BARSUPL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_OBS_S080    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_OBS_S080    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on FIN_OBS_S080    to RCC_DEAL;
grant SELECT                                                                 on FIN_OBS_S080    to TECH005;
grant SELECT                                                                 on FIN_OBS_S080    to TECH006;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_OBS_S080    to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on FIN_OBS_S080    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_OBS_S080.sql =========*** End *** 
PROMPT ===================================================================================== 
