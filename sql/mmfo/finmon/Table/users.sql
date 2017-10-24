

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/FINMON/Table/USERS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** Create  table USERS ***
begin 
  execute immediate '
  CREATE TABLE FINMON.USERS 
   (	ID VARCHAR2(15), 
	VDP_POS VARCHAR2(100), 
	VDP_NM1 VARCHAR2(50), 
	VDP_NM2 VARCHAR2(30), 
	VDP_NM3 VARCHAR2(30), 
	VDP_TLF VARCHAR2(10), 
	VDP_EMAIL VARCHAR2(254), 
	VDP_KEY VARCHAR2(6), 
	VDP_TYPE VARCHAR2(4), 
	VDP_NM VARCHAR2(20), 
	VDP_DATE DATE, 
	VDP_DATE_ASSIGNMENT DATE, 
	VDP_CLEAR_NM VARCHAR2(20), 
	VDP_CLEAR_DATE DATE, 
	VDP_CLEAR_DATE_ASSIGNMENT DATE, 
	BRANCH_ID VARCHAR2(15), 
	STATUS VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE USERS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE FINMON.USERS IS '';
COMMENT ON COLUMN FINMON.USERS.ID IS '';
COMMENT ON COLUMN FINMON.USERS.VDP_POS IS '';
COMMENT ON COLUMN FINMON.USERS.VDP_NM1 IS '';
COMMENT ON COLUMN FINMON.USERS.VDP_NM2 IS '';
COMMENT ON COLUMN FINMON.USERS.VDP_NM3 IS '';
COMMENT ON COLUMN FINMON.USERS.VDP_TLF IS '';
COMMENT ON COLUMN FINMON.USERS.VDP_EMAIL IS '';
COMMENT ON COLUMN FINMON.USERS.VDP_KEY IS '';
COMMENT ON COLUMN FINMON.USERS.VDP_TYPE IS '';
COMMENT ON COLUMN FINMON.USERS.VDP_NM IS '';
COMMENT ON COLUMN FINMON.USERS.VDP_DATE IS '';
COMMENT ON COLUMN FINMON.USERS.VDP_DATE_ASSIGNMENT IS '';
COMMENT ON COLUMN FINMON.USERS.VDP_CLEAR_NM IS '';
COMMENT ON COLUMN FINMON.USERS.VDP_CLEAR_DATE IS '';
COMMENT ON COLUMN FINMON.USERS.VDP_CLEAR_DATE_ASSIGNMENT IS '';
COMMENT ON COLUMN FINMON.USERS.BRANCH_ID IS '';
COMMENT ON COLUMN FINMON.USERS.STATUS IS '';




PROMPT *** Create  constraint XPK_USERS ***
begin   
 execute immediate '
  ALTER TABLE FINMON.USERS ADD CONSTRAINT XPK_USERS PRIMARY KEY (BRANCH_ID, ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_USERS_BRANCH_ID ***
begin   
 execute immediate '
  ALTER TABLE FINMON.USERS ADD CONSTRAINT FK_USERS_BRANCH_ID FOREIGN KEY (BRANCH_ID)
	  REFERENCES FINMON.BANK (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_USERS_STATUS ***
begin   
 execute immediate '
  ALTER TABLE FINMON.USERS ADD CONSTRAINT FK_USERS_STATUS FOREIGN KEY (STATUS)
	  REFERENCES FINMON.K_DFM06 (CODE) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_USERS_VDP_POS ***
begin   
 execute immediate '
  ALTER TABLE FINMON.USERS MODIFY (VDP_POS CONSTRAINT NK_USERS_VDP_POS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_USERS_BRANCH_ID ***
begin   
 execute immediate '
  ALTER TABLE FINMON.USERS MODIFY (BRANCH_ID CONSTRAINT NK_USERS_BRANCH_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_USERS_VDP_TLF ***
begin   
 execute immediate '
  ALTER TABLE FINMON.USERS MODIFY (VDP_TLF CONSTRAINT NK_USERS_VDP_TLF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_USERS_VDP_KEY ***
begin   
 execute immediate '
  ALTER TABLE FINMON.USERS MODIFY (VDP_KEY CONSTRAINT NK_USERS_VDP_KEY NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_USERS_VDP_TYPE ***
begin   
 execute immediate '
  ALTER TABLE FINMON.USERS MODIFY (VDP_TYPE CONSTRAINT NK_USERS_VDP_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_USERS_VDP_NM1 ***
begin   
 execute immediate '
  ALTER TABLE FINMON.USERS MODIFY (VDP_NM1 CONSTRAINT NK_USERS_VDP_NM1 NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_USERS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX FINMON.XPK_USERS ON FINMON.USERS (BRANCH_ID, ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE USERS ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  USERS ***
grant SELECT                                                                 on USERS           to BARS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/FINMON/Table/USERS.sql =========*** End *** =====
PROMPT ===================================================================================== 
