

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PARAMS$GLOBAL.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PARAMS$GLOBAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PARAMS$GLOBAL'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''PARAMS$GLOBAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PARAMS$GLOBAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.PARAMS$GLOBAL 
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




PROMPT *** ALTER_POLICIES to PARAMS$GLOBAL ***
 exec bpa.alter_policies('PARAMS$GLOBAL');


COMMENT ON TABLE BARS.PARAMS$GLOBAL IS 'Глобальные параметры системы';
COMMENT ON COLUMN BARS.PARAMS$GLOBAL.PAR IS 'Параметр';
COMMENT ON COLUMN BARS.PARAMS$GLOBAL.VAL IS 'Значение';
COMMENT ON COLUMN BARS.PARAMS$GLOBAL.COMM IS 'Комментарий';
COMMENT ON COLUMN BARS.PARAMS$GLOBAL.SRV_FLAG IS 'Ознака сервісного параметру';




PROMPT *** Create  constraint PK_PARAMS$GLOBAL ***
begin   
 execute immediate '
  ALTER TABLE BARS.PARAMS$GLOBAL ADD CONSTRAINT PK_PARAMS$GLOBAL PRIMARY KEY (PAR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PARAMS$GLOBAL_PAR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PARAMS$GLOBAL MODIFY (PAR CONSTRAINT CC_PARAMS$GLOBAL_PAR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PARAMS$GLOBAL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PARAMS$GLOBAL ON BARS.PARAMS$GLOBAL (PAR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PARAMS$GLOBAL ***
grant SELECT                                                                 on PARAMS$GLOBAL   to BARSDWH_ACCESS_USER;
grant SELECT                                                                 on PARAMS$GLOBAL   to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on PARAMS$GLOBAL   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PARAMS$GLOBAL   to BARS_SUP;
grant SELECT                                                                 on PARAMS$GLOBAL   to DPT_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PARAMS$GLOBAL   to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PARAMS$GLOBAL   to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to PARAMS$GLOBAL ***

  CREATE OR REPLACE SYNONYM BARSDWH_ACCESS_USER.PARAMS$GLOBAL FOR BARS.PARAMS$GLOBAL;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PARAMS$GLOBAL.sql =========*** End ***
PROMPT ===================================================================================== 
