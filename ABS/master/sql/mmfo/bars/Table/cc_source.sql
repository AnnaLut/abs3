

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CC_SOURCE.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CC_SOURCE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CC_SOURCE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CC_SOURCE'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CC_SOURCE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CC_SOURCE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CC_SOURCE 
   (	SOUR NUMBER(1,0), 
	NAME VARCHAR2(70), 
	S200 CHAR(1), 
	BR NUMBER, 
	N_MON NUMBER, 
	IR_MAX NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CC_SOURCE ***
 exec bpa.alter_policies('CC_SOURCE');


COMMENT ON TABLE BARS.CC_SOURCE IS '¬иды источников кредитовани€';
COMMENT ON COLUMN BARS.CC_SOURCE.SOUR IS '¬ид источника кредитовани€';
COMMENT ON COLUMN BARS.CC_SOURCE.NAME IS 'Ќаименование источника кредитовани€';
COMMENT ON COLUMN BARS.CC_SOURCE.S200 IS '';
COMMENT ON COLUMN BARS.CC_SOURCE.BR IS 'MAX-ограничение по значению результирующей ставки';
COMMENT ON COLUMN BARS.CC_SOURCE.N_MON IS 'количество мес€цев дл€ пересмотра % ставки';
COMMENT ON COLUMN BARS.CC_SOURCE.IR_MAX IS '';




PROMPT *** Create  constraint PK_CCSOURCE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SOURCE ADD CONSTRAINT PK_CCSOURCE PRIMARY KEY (SOUR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCSOURCE_SOUR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SOURCE MODIFY (SOUR CONSTRAINT CC_CCSOURCE_SOUR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CCSOURCE_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CC_SOURCE MODIFY (NAME CONSTRAINT CC_CCSOURCE_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CCSOURCE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CCSOURCE ON BARS.CC_SOURCE (SOUR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CC_SOURCE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_SOURCE       to ABS_ADMIN;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on CC_SOURCE       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CC_SOURCE       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CC_SOURCE       to CC_SOURCE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on CC_SOURCE       to RCC_DEAL;
grant SELECT                                                                 on CC_SOURCE       to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on CC_SOURCE       to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on CC_SOURCE       to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CC_SOURCE.sql =========*** End *** ===
PROMPT ===================================================================================== 
