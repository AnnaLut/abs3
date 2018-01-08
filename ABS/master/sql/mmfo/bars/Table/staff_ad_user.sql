

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STAFF_AD_USER.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STAFF_AD_USER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STAFF_AD_USER'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STAFF_AD_USER ***
begin 
  execute immediate '
  CREATE TABLE BARS.STAFF_AD_USER 
   (	USER_ID NUMBER(38,0), 
	ACTIVE_DIRECTORY_NAME VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STAFF_AD_USER ***
 exec bpa.alter_policies('STAFF_AD_USER');


COMMENT ON TABLE BARS.STAFF_AD_USER IS '';
COMMENT ON COLUMN BARS.STAFF_AD_USER.USER_ID IS '';
COMMENT ON COLUMN BARS.STAFF_AD_USER.ACTIVE_DIRECTORY_NAME IS '';




PROMPT *** Create  constraint FK_STAFF_AD_USER_REF_STAFF ***
begin   
 execute immediate '
  ALTER TABLE BARS.STAFF_AD_USER ADD CONSTRAINT FK_STAFF_AD_USER_REF_STAFF FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index STAFF_AD_USER_IDX ***
begin   
 execute immediate '
  CREATE INDEX BARS.STAFF_AD_USER_IDX ON BARS.STAFF_AD_USER (USER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  or sqlcode=-1408 then null; else raise; end if;
 end;
/




PROMPT *** Create  index STAFF_AD_USER_NAME_IDX ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.STAFF_AD_USER_NAME_IDX ON BARS.STAFF_AD_USER (ACTIVE_DIRECTORY_NAME) 
  PCTFREE 10 INITRANS 2 MAXTRANS 167 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  or sqlcode=-1408 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STAFF_AD_USER ***
grant SELECT                                                                 on STAFF_AD_USER   to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STAFF_AD_USER.sql =========*** End ***
PROMPT ===================================================================================== 
