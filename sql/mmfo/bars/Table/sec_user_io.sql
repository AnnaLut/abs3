

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SEC_USER_IO.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SEC_USER_IO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SEC_USER_IO'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SEC_USER_IO'', ''FILIAL'' , ''B'', ''B'', ''E'', ''E'');
               bpa.alter_policy_info(''SEC_USER_IO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SEC_USER_IO ***
begin 
  execute immediate '
  CREATE TABLE BARS.SEC_USER_IO 
   (	ID NUMBER(38,0), 
	IO_MODE NUMBER(1,0), 
	IO_DATE DATE, 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch''), 
	REC_ID NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SEC_USER_IO ***
 exec bpa.alter_policies('SEC_USER_IO');


COMMENT ON TABLE BARS.SEC_USER_IO IS 'История регистрации пользователей АБС';
COMMENT ON COLUMN BARS.SEC_USER_IO.ID IS 'Код пользователя';
COMMENT ON COLUMN BARS.SEC_USER_IO.IO_MODE IS 'Направление регистрации (1 - пришел, 0 - ушел)';
COMMENT ON COLUMN BARS.SEC_USER_IO.IO_DATE IS 'Дата-Время регистрации';
COMMENT ON COLUMN BARS.SEC_USER_IO.BRANCH IS 'Код подразделения';
COMMENT ON COLUMN BARS.SEC_USER_IO.REC_ID IS 'Номер записи';




PROMPT *** Create  constraint PK_SECUSERIO ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_USER_IO ADD CONSTRAINT PK_SECUSERIO PRIMARY KEY (REC_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECUSERIO_IOMODE ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_USER_IO ADD CONSTRAINT CC_SECUSERIO_IOMODE CHECK (io_mode in (0,1)) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECUSERIO_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_USER_IO MODIFY (ID CONSTRAINT CC_SECUSERIO_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECUSERIO_IOMODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_USER_IO MODIFY (IO_MODE CONSTRAINT CC_SECUSERIO_IOMODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECUSERIO_IODATE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_USER_IO MODIFY (IO_DATE CONSTRAINT CC_SECUSERIO_IODATE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECUSERIO_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_USER_IO MODIFY (BRANCH CONSTRAINT CC_SECUSERIO_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECUSERIO_RECID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_USER_IO MODIFY (REC_ID CONSTRAINT CC_SECUSERIO_RECID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SECUSERIO ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SECUSERIO ON BARS.SEC_USER_IO (REC_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SEC_USER_IO ***
grant DELETE,INSERT,SELECT,UPDATE                                            on SEC_USER_IO     to ABS_ADMIN;
grant SELECT                                                                 on SEC_USER_IO     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on SEC_USER_IO     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SEC_USER_IO     to BARS_DM;
grant SELECT                                                                 on SEC_USER_IO     to START1;
grant SELECT                                                                 on SEC_USER_IO     to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SEC_USER_IO     to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SEC_USER_IO.sql =========*** End *** =
PROMPT ===================================================================================== 
