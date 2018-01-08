

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/USER_MESSAGES_TYPES.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to USER_MESSAGES_TYPES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''USER_MESSAGES_TYPES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''USER_MESSAGES_TYPES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''USER_MESSAGES_TYPES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table USER_MESSAGES_TYPES ***
begin 
  execute immediate '
  CREATE TABLE BARS.USER_MESSAGES_TYPES 
   (	ID NUMBER(38,0), 
	NAME VARCHAR2(300), 
	ACTUAL_TIME NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYNI ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to USER_MESSAGES_TYPES ***
 exec bpa.alter_policies('USER_MESSAGES_TYPES');


COMMENT ON TABLE BARS.USER_MESSAGES_TYPES IS 'Типи повідомлень для WEB користувачів';
COMMENT ON COLUMN BARS.USER_MESSAGES_TYPES.ID IS 'Ідентифікатор';
COMMENT ON COLUMN BARS.USER_MESSAGES_TYPES.NAME IS 'Найменування';
COMMENT ON COLUMN BARS.USER_MESSAGES_TYPES.ACTUAL_TIME IS 'Час актуальності повідомлення (у днях)';




PROMPT *** Create  constraint PK_USERMESSAGESTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.USER_MESSAGES_TYPES ADD CONSTRAINT PK_USERMESSAGESTYPES PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_USERMESSAGESTYPES_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.USER_MESSAGES_TYPES MODIFY (ID CONSTRAINT CC_USERMESSAGESTYPES_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_USERMESSAGESTYPES_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.USER_MESSAGES_TYPES MODIFY (NAME CONSTRAINT CC_USERMESSAGESTYPES_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_USERMESSAGESACT_TIME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.USER_MESSAGES_TYPES MODIFY (ACTUAL_TIME CONSTRAINT CC_USERMESSAGESACT_TIME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_USERMESSAGESTYPES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_USERMESSAGESTYPES ON BARS.USER_MESSAGES_TYPES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  USER_MESSAGES_TYPES ***
grant SELECT                                                                 on USER_MESSAGES_TYPES to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on USER_MESSAGES_TYPES to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on USER_MESSAGES_TYPES to DPT_ADMIN;
grant SELECT                                                                 on USER_MESSAGES_TYPES to START1;
grant SELECT                                                                 on USER_MESSAGES_TYPES to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/USER_MESSAGES_TYPES.sql =========*** E
PROMPT ===================================================================================== 
