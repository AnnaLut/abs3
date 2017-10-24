

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_DEPOSIT_ACTION.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_DEPOSIT_ACTION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_DEPOSIT_ACTION'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_DEPOSIT_ACTION'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''DPT_DEPOSIT_ACTION'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_DEPOSIT_ACTION ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_DEPOSIT_ACTION 
   (	ID NUMBER(1,0), 
	NAME VARCHAR2(25)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_DEPOSIT_ACTION ***
 exec bpa.alter_policies('DPT_DEPOSIT_ACTION');


COMMENT ON TABLE BARS.DPT_DEPOSIT_ACTION IS 'Статусы депозитных договоров';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_ACTION.ID IS '№ п/п';
COMMENT ON COLUMN BARS.DPT_DEPOSIT_ACTION.NAME IS 'Наименование статуса';




PROMPT *** Create  constraint PK_DPTDEPACTION ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_ACTION ADD CONSTRAINT PK_DPTDEPACTION PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPACTION_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_ACTION MODIFY (ID CONSTRAINT CC_DPTDEPACTION_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DPTDEPACTION_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DPT_DEPOSIT_ACTION MODIFY (NAME CONSTRAINT CC_DPTDEPACTION_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DPTDEPACTION ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DPTDEPACTION ON BARS.DPT_DEPOSIT_ACTION (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DPT_DEPOSIT_ACTION ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_DEPOSIT_ACTION to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_DEPOSIT_ACTION to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_DEPOSIT_ACTION to BARS_DM;
grant SELECT                                                                 on DPT_DEPOSIT_ACTION to DPT;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_DEPOSIT_ACTION to DPT_ADMIN;
grant SELECT                                                                 on DPT_DEPOSIT_ACTION to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_DEPOSIT_ACTION to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on DPT_DEPOSIT_ACTION to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_DEPOSIT_ACTION.sql =========*** En
PROMPT ===================================================================================== 
