

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFF_KEYS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFF_KEYS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAFF_KEYS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''STAFF_KEYS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFF_KEYS ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFF_KEYS 
   (	USER_ID NUMBER(38,0), 
	KEY_TYPE VARCHAR2(3), 
	KEY_ID VARCHAR2(256)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAFF_KEYS ***
 exec bpa.alter_policies('STAFF_KEYS');


COMMENT ON TABLE BARS.STAFF_KEYS IS '';
COMMENT ON COLUMN BARS.STAFF_KEYS.USER_ID IS '';
COMMENT ON COLUMN BARS.STAFF_KEYS.KEY_TYPE IS '';
COMMENT ON COLUMN BARS.STAFF_KEYS.KEY_ID IS '';




PROMPT *** Create  constraint CC_STAFFKEYS_USERID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_KEYS MODIFY (USER_ID CONSTRAINT CC_STAFFKEYS_USERID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFFKEYS_SGNTYPES ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_KEYS ADD CONSTRAINT FK_STAFFKEYS_SGNTYPES FOREIGN KEY (KEY_TYPE)
	  REFERENCES BARS.SGN_TYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STAFFKEYS_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_KEYS ADD CONSTRAINT FK_STAFFKEYS_STAFF FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_STAFFKEYS ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_KEYS ADD CONSTRAINT PK_STAFFKEYS PRIMARY KEY (USER_ID, KEY_TYPE, KEY_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STAFFKEYS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STAFFKEYS ON BARS.STAFF_KEYS (USER_ID, KEY_TYPE, KEY_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFF_KEYS.sql =========*** End *** ==
PROMPT ===================================================================================== 
