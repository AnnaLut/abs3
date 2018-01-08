

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFF_SUBSTITUTE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFF_SUBSTITUTE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAFF_SUBSTITUTE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_SUBSTITUTE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STAFF_SUBSTITUTE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFF_SUBSTITUTE ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFF_SUBSTITUTE 
   (	ID_WHO NUMBER(38,0), 
	ID_WHOM NUMBER(38,0), 
	DATE_START DATE, 
	DATE_FINISH DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAFF_SUBSTITUTE ***
 exec bpa.alter_policies('STAFF_SUBSTITUTE');


COMMENT ON TABLE BARS.STAFF_SUBSTITUTE IS 'Передача прав пользователей';
COMMENT ON COLUMN BARS.STAFF_SUBSTITUTE.ID_WHO IS 'Код пользователя кому передаем';
COMMENT ON COLUMN BARS.STAFF_SUBSTITUTE.ID_WHOM IS 'Код пользователя от кого передаем';
COMMENT ON COLUMN BARS.STAFF_SUBSTITUTE.DATE_START IS 'На период "С"';
COMMENT ON COLUMN BARS.STAFF_SUBSTITUTE.DATE_FINISH IS 'На период "ПО"';




PROMPT *** Create  constraint PK_STAFFSUBS ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_SUBSTITUTE ADD CONSTRAINT PK_STAFFSUBS PRIMARY KEY (ID_WHO, ID_WHOM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFSUBS_DATESTART ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_SUBSTITUTE ADD CONSTRAINT CC_STAFFSUBS_DATESTART CHECK (date_start <= date_finish) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFSUBS_IDWHO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_SUBSTITUTE MODIFY (ID_WHO CONSTRAINT CC_STAFFSUBS_IDWHO_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STAFFSUBS_IDWHOM_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_SUBSTITUTE MODIFY (ID_WHOM CONSTRAINT CC_STAFFSUBS_IDWHOM_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STAFFSUBS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STAFFSUBS ON BARS.STAFF_SUBSTITUTE (ID_WHO, ID_WHOM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAFF_SUBSTITUTE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFF_SUBSTITUTE to ABS_ADMIN;
grant REFERENCES,SELECT                                                      on STAFF_SUBSTITUTE to BARSAQ with grant option;
grant REFERENCES,SELECT                                                      on STAFF_SUBSTITUTE to BARSAQ_ADM with grant option;
grant SELECT                                                                 on STAFF_SUBSTITUTE to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on STAFF_SUBSTITUTE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STAFF_SUBSTITUTE to BARS_DM;
grant SELECT                                                                 on STAFF_SUBSTITUTE to START1;
grant SELECT                                                                 on STAFF_SUBSTITUTE to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STAFF_SUBSTITUTE to WR_ALL_RIGHTS;
grant SELECT                                                                 on STAFF_SUBSTITUTE to WR_DOC_INPUT;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFF_SUBSTITUTE.sql =========*** End 
PROMPT ===================================================================================== 
