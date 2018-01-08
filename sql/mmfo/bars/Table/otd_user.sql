

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTD_USER.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTD_USER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTD_USER'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OTD_USER'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTD_USER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTD_USER ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTD_USER 
   (	OTD NUMBER(38,0), 
	USERID NUMBER(38,0), 
	PR NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTD_USER ***
 exec bpa.alter_policies('OTD_USER');


COMMENT ON TABLE BARS.OTD_USER IS 'Подразделения банка <-> Пользователи АБС';
COMMENT ON COLUMN BARS.OTD_USER.OTD IS 'Код подразделения';
COMMENT ON COLUMN BARS.OTD_USER.USERID IS 'Код пользователя';
COMMENT ON COLUMN BARS.OTD_USER.PR IS 'Признак основного подразделения';




PROMPT *** Create  constraint PK_OTDUSER ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTD_USER ADD CONSTRAINT PK_OTDUSER PRIMARY KEY (OTD, USERID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OTDUSER_PR ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTD_USER ADD CONSTRAINT CC_OTDUSER_PR CHECK (pr = 1) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OTDUSER_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTD_USER ADD CONSTRAINT FK_OTDUSER_STAFF FOREIGN KEY (USERID)
	  REFERENCES BARS.STAFF$BASE (ID) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OTDUSER_OTDEL ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTD_USER ADD CONSTRAINT FK_OTDUSER_OTDEL FOREIGN KEY (OTD)
	  REFERENCES BARS.OTDEL (ID) DISABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009716 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTD_USER MODIFY (OTD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009717 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTD_USER MODIFY (USERID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OTDUSER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OTDUSER ON BARS.OTD_USER (OTD, USERID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTD_USER ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTD_USER        to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OTD_USER        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OTD_USER        to BARS_DM;
grant SELECT                                                                 on OTD_USER        to CP_ROLE;
grant SELECT                                                                 on OTD_USER        to RCC_DEAL;
grant SELECT                                                                 on OTD_USER        to RPBN001;
grant SELECT                                                                 on OTD_USER        to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OTD_USER        to WR_ALL_RIGHTS;
grant SELECT                                                                 on OTD_USER        to WR_CUSTREG;
grant FLASHBACK,SELECT                                                       on OTD_USER        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTD_USER.sql =========*** End *** ====
PROMPT ===================================================================================== 
