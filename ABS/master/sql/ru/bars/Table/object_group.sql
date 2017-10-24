

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OBJECT_GROUP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OBJECT_GROUP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OBJECT_GROUP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OBJECT_GROUP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OBJECT_GROUP ***
begin 
  execute immediate '
  CREATE TABLE BARS.OBJECT_GROUP 
   (	ID NUMBER(5,0), 
	GROUP_TYPE_ID NUMBER(5,0), 
	GROUP_CODE VARCHAR2(30 CHAR), 
	GROUP_NAME VARCHAR2(300 CHAR), 
	PARENT_GROUP_ID NUMBER(5,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OBJECT_GROUP ***
 exec bpa.alter_policies('OBJECT_GROUP');


COMMENT ON TABLE BARS.OBJECT_GROUP IS 'Довідник груп об'єктів системи з ієрархічною структурою';
COMMENT ON COLUMN BARS.OBJECT_GROUP.ID IS '';
COMMENT ON COLUMN BARS.OBJECT_GROUP.GROUP_TYPE_ID IS '';
COMMENT ON COLUMN BARS.OBJECT_GROUP.GROUP_CODE IS '';
COMMENT ON COLUMN BARS.OBJECT_GROUP.GROUP_NAME IS '';
COMMENT ON COLUMN BARS.OBJECT_GROUP.PARENT_GROUP_ID IS '';




PROMPT *** Create  constraint FK_DEAL_PROD_GROUP_REF_PARENT ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_GROUP ADD CONSTRAINT FK_DEAL_PROD_GROUP_REF_PARENT FOREIGN KEY (PARENT_GROUP_ID)
	  REFERENCES BARS.OBJECT_GROUP (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_OBJ_GROUP_REF_GROUP_TYPE ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_GROUP ADD CONSTRAINT FK_OBJ_GROUP_REF_GROUP_TYPE FOREIGN KEY (GROUP_TYPE_ID)
	  REFERENCES BARS.OBJECT_GROUP_TYPE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint AK_KEY_2_OBJECT_G ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_GROUP ADD CONSTRAINT AK_KEY_2_OBJECT_G UNIQUE (GROUP_TYPE_ID, GROUP_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_OBJECT_GROUP ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_GROUP ADD CONSTRAINT PK_OBJECT_GROUP PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003187810 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_GROUP MODIFY (GROUP_NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003187809 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_GROUP MODIFY (GROUP_CODE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003187808 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_GROUP MODIFY (GROUP_TYPE_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C003187807 ***
begin   
 execute immediate '
  ALTER TABLE BARS.OBJECT_GROUP MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OBJECT_GROUP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OBJECT_GROUP ON BARS.OBJECT_GROUP (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index AK_KEY_2_OBJECT_G ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.AK_KEY_2_OBJECT_G ON BARS.OBJECT_GROUP (GROUP_TYPE_ID, GROUP_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OBJECT_GROUP.sql =========*** End *** 
PROMPT ===================================================================================== 
