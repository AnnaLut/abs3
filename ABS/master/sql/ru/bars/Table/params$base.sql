

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PARAMS$BASE.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PARAMS$BASE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PARAMS$BASE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PARAMS$BASE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PARAMS$BASE ***
begin 
  execute immediate '
  CREATE TABLE BARS.PARAMS$BASE 
   (	PAR VARCHAR2(30), 
	VAL VARCHAR2(250), 
	COMM VARCHAR2(250), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PARAMS$BASE ***
 exec bpa.alter_policies('PARAMS$BASE');


COMMENT ON TABLE BARS.PARAMS$BASE IS 'Параметры системы в разрезе филиалов';
COMMENT ON COLUMN BARS.PARAMS$BASE.PAR IS 'Параметр';
COMMENT ON COLUMN BARS.PARAMS$BASE.VAL IS 'Значение';
COMMENT ON COLUMN BARS.PARAMS$BASE.COMM IS 'Комментарий';
COMMENT ON COLUMN BARS.PARAMS$BASE.KF IS 'Код филиала';




PROMPT *** Create  constraint FK_PARAMS$BASE_BANKS ***
begin   
 execute immediate '
  ALTER TABLE BARS.PARAMS$BASE ADD CONSTRAINT FK_PARAMS$BASE_BANKS FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PARAMS$BASE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PARAMS$BASE ADD CONSTRAINT CC_PARAMS$BASE_KF_NN CHECK (KF IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PARAMS$BASE ***
begin   
 execute immediate '
  ALTER TABLE BARS.PARAMS$BASE ADD CONSTRAINT PK_PARAMS$BASE PRIMARY KEY (KF, PAR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PARAMS$BASE_PAR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.PARAMS$BASE MODIFY (PAR CONSTRAINT CC_PARAMS$BASE_PAR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PARAMS$BASE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PARAMS$BASE ON BARS.PARAMS$BASE (KF, PAR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  PARAMS$BASE ***
grant FLASHBACK,REFERENCES,SELECT                                            on PARAMS$BASE     to BARSAQ with grant option;
grant SELECT                                                                 on PARAMS$BASE     to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on PARAMS$BASE     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on PARAMS$BASE     to BARS_SUP;
grant DELETE,INSERT,SELECT,UPDATE                                            on PARAMS$BASE     to START1;
grant SELECT                                                                 on PARAMS$BASE     to WCS_SYNC_USER;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on PARAMS$BASE     to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to PARAMS$BASE ***

  CREATE OR REPLACE PUBLIC SYNONYM PARAMS$BASE FOR BARS.PARAMS$BASE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PARAMS$BASE.sql =========*** End *** =
PROMPT ===================================================================================== 
