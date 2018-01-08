

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEPRICATED_PARAMS$GLOBAL.sql =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEPRICATED_PARAMS$GLOBAL ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEPRICATED_PARAMS$GLOBAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEPRICATED_PARAMS$GLOBAL 
   (	PAR VARCHAR2(30), 
	VAL VARCHAR2(250), 
	COMM VARCHAR2(250), 
	SRV_FLAG NUMBER(1,0) DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DEPRICATED_PARAMS$GLOBAL ***
 exec bpa.alter_policies('DEPRICATED_PARAMS$GLOBAL');


COMMENT ON TABLE BARS.DEPRICATED_PARAMS$GLOBAL IS 'Глобальные параметры системы';
COMMENT ON COLUMN BARS.DEPRICATED_PARAMS$GLOBAL.PAR IS 'Параметр';
COMMENT ON COLUMN BARS.DEPRICATED_PARAMS$GLOBAL.VAL IS 'Значение';
COMMENT ON COLUMN BARS.DEPRICATED_PARAMS$GLOBAL.COMM IS 'Комментарий';
COMMENT ON COLUMN BARS.DEPRICATED_PARAMS$GLOBAL.SRV_FLAG IS 'Ознака сервісного параметру';




PROMPT *** Create  constraint CC_PARAMS$GLOBAL_PAR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEPRICATED_PARAMS$GLOBAL MODIFY (PAR CONSTRAINT CC_PARAMS$GLOBAL_PAR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PARAMS$GLOBAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEPRICATED_PARAMS$GLOBAL ADD CONSTRAINT PK_PARAMS$GLOBAL PRIMARY KEY (PAR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PARAMS$GLOBAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PARAMS$GLOBAL ON BARS.DEPRICATED_PARAMS$GLOBAL (PAR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DEPRICATED_PARAMS$GLOBAL ***
grant SELECT                                                                 on DEPRICATED_PARAMS$GLOBAL to BARSDWH_ACCESS_USER;
grant DELETE,INSERT,SELECT,UPDATE                                            on DEPRICATED_PARAMS$GLOBAL to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DEPRICATED_PARAMS$GLOBAL to BARS_DM;
grant SELECT                                                                 on DEPRICATED_PARAMS$GLOBAL to DPT_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DEPRICATED_PARAMS$GLOBAL to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DEPRICATED_PARAMS$GLOBAL to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEPRICATED_PARAMS$GLOBAL.sql =========
PROMPT ===================================================================================== 
