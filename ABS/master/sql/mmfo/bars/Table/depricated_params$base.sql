

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DEPRICATED_PARAMS$BASE.sql =========**
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DEPRICATED_PARAMS$BASE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DEPRICATED_PARAMS$BASE ***
begin 
  execute immediate '
  CREATE TABLE BARS.DEPRICATED_PARAMS$BASE 
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




PROMPT *** ALTER_POLICIES to DEPRICATED_PARAMS$BASE ***
 exec bpa.alter_policies('DEPRICATED_PARAMS$BASE');


COMMENT ON TABLE BARS.DEPRICATED_PARAMS$BASE IS 'Параметры системы в разрезе филиалов';
COMMENT ON COLUMN BARS.DEPRICATED_PARAMS$BASE.PAR IS 'Параметр';
COMMENT ON COLUMN BARS.DEPRICATED_PARAMS$BASE.VAL IS 'Значение';
COMMENT ON COLUMN BARS.DEPRICATED_PARAMS$BASE.COMM IS 'Комментарий';
COMMENT ON COLUMN BARS.DEPRICATED_PARAMS$BASE.KF IS 'Код филиала';




PROMPT *** Create  constraint CC_PARAMS$BASE_PAR_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEPRICATED_PARAMS$BASE MODIFY (PAR CONSTRAINT CC_PARAMS$BASE_PAR_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_PARAMS$BASE ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEPRICATED_PARAMS$BASE ADD CONSTRAINT PK_PARAMS$BASE PRIMARY KEY (KF, PAR)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_PARAMS$BASE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DEPRICATED_PARAMS$BASE ADD CONSTRAINT CC_PARAMS$BASE_KF_NN CHECK (KF IS NOT NULL) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_PARAMS$BASE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_PARAMS$BASE ON BARS.DEPRICATED_PARAMS$BASE (KF, PAR) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DEPRICATED_PARAMS$BASE ***
grant FLASHBACK,REFERENCES,SELECT                                            on DEPRICATED_PARAMS$BASE to BARSAQ with grant option;
grant SELECT                                                                 on DEPRICATED_PARAMS$BASE to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on DEPRICATED_PARAMS$BASE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DEPRICATED_PARAMS$BASE to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on DEPRICATED_PARAMS$BASE to START1;
grant SELECT                                                                 on DEPRICATED_PARAMS$BASE to UPLD;
grant SELECT                                                                 on DEPRICATED_PARAMS$BASE to WCS_SYNC_USER;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DEPRICATED_PARAMS$BASE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DEPRICATED_PARAMS$BASE.sql =========**
PROMPT ===================================================================================== 
