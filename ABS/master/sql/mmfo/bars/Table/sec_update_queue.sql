

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SEC_UPDATE_QUEUE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SEC_UPDATE_QUEUE ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SEC_UPDATE_QUEUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.SEC_UPDATE_QUEUE 
   (	UPDATE_TIME DATE, 
	USER_ID NUMBER(*,0), 
	 CONSTRAINT PK_SECUPDQ PRIMARY KEY (UPDATE_TIME, USER_ID) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSSMLD 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SEC_UPDATE_QUEUE ***
 exec bpa.alter_policies('SEC_UPDATE_QUEUE');


COMMENT ON TABLE BARS.SEC_UPDATE_QUEUE IS 'Очередь записей для обновления пользователских масок доступа к счетам';
COMMENT ON COLUMN BARS.SEC_UPDATE_QUEUE.UPDATE_TIME IS 'Плановое время обновления';
COMMENT ON COLUMN BARS.SEC_UPDATE_QUEUE.USER_ID IS 'ID пользователя';




PROMPT *** Create  constraint CC_SECUPDQ_UPDTIME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_UPDATE_QUEUE MODIFY (UPDATE_TIME CONSTRAINT CC_SECUPDQ_UPDTIME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SECUPDQ ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_UPDATE_QUEUE ADD CONSTRAINT PK_SECUPDQ PRIMARY KEY (UPDATE_TIME, USER_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECUPDQ_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_UPDATE_QUEUE MODIFY (USER_ID CONSTRAINT CC_SECUPDQ_USERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SECUPDQ ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SECUPDQ ON BARS.SEC_UPDATE_QUEUE (UPDATE_TIME, USER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SEC_UPDATE_QUEUE.sql =========*** End 
PROMPT ===================================================================================== 
