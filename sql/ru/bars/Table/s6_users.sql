

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S6_USERS.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S6_USERS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''S6_USERS'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S6_USERS ***
begin 
  execute immediate '
  CREATE TABLE BARS.S6_USERS 
   (	ISP NUMBER(5,0), 
	FIO VARCHAR2(40), 
	LOGIN VARCHAR2(30), 
	HOST VARCHAR2(30), 
	PASSWORD VARCHAR2(16), 
	D_OD DATE, 
	PR_END NUMBER(3,0), 
	PR_ACT NUMBER(3,0), 
	PR_PERMIT NUMBER(3,0), 
	IKEY CHAR(8), 
	SIGN_TYPE NUMBER(3,0), 
	DEV_TYPE NUMBER(3,0), 
	ACCESS VARCHAR2(3200), 
	PR_LPMB NUMBER(3,0), 
	PR_HOST NUMBER(3,0), 
	TM_ID VARCHAR2(16), 
	TM_ADAPT NUMBER(3,0), 
	TM_TYPE NUMBER(5,0), 
	PasswordEnd DATE, 
	PasswordAdmin NUMBER(3,0), 
	PasswordTerm NUMBER(5,0), 
	BIC NUMBER(10,0), 
	DEPART NUMBER(5,0), 
	DistrSgn NUMBER(3,0), 
	EMail VARCHAR2(20), 
	Phone VARCHAR2(20), 
	RegimeBeg VARCHAR2(5), 
	RegimeEnd VARCHAR2(5), 
	AdmKey VARCHAR2(8), 
	AdmEp VARCHAR2(180)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S6_USERS ***
 exec bpa.alter_policies('S6_USERS');


COMMENT ON TABLE BARS.S6_USERS IS '';
COMMENT ON COLUMN BARS.S6_USERS.PR_ACT IS '';
COMMENT ON COLUMN BARS.S6_USERS.PR_PERMIT IS '';
COMMENT ON COLUMN BARS.S6_USERS.IKEY IS '';
COMMENT ON COLUMN BARS.S6_USERS.SIGN_TYPE IS '';
COMMENT ON COLUMN BARS.S6_USERS.DEV_TYPE IS '';
COMMENT ON COLUMN BARS.S6_USERS.ACCESS IS '';
COMMENT ON COLUMN BARS.S6_USERS.PR_LPMB IS '';
COMMENT ON COLUMN BARS.S6_USERS.PR_HOST IS '';
COMMENT ON COLUMN BARS.S6_USERS.TM_ID IS '';
COMMENT ON COLUMN BARS.S6_USERS.TM_ADAPT IS '';
COMMENT ON COLUMN BARS.S6_USERS.TM_TYPE IS '';
COMMENT ON COLUMN BARS.S6_USERS.PasswordEnd IS '';
COMMENT ON COLUMN BARS.S6_USERS.PasswordAdmin IS '';
COMMENT ON COLUMN BARS.S6_USERS.PasswordTerm IS '';
COMMENT ON COLUMN BARS.S6_USERS.BIC IS '';
COMMENT ON COLUMN BARS.S6_USERS.DEPART IS '';
COMMENT ON COLUMN BARS.S6_USERS.DistrSgn IS '';
COMMENT ON COLUMN BARS.S6_USERS.EMail IS '';
COMMENT ON COLUMN BARS.S6_USERS.Phone IS '';
COMMENT ON COLUMN BARS.S6_USERS.RegimeBeg IS '';
COMMENT ON COLUMN BARS.S6_USERS.RegimeEnd IS '';
COMMENT ON COLUMN BARS.S6_USERS.AdmKey IS '';
COMMENT ON COLUMN BARS.S6_USERS.AdmEp IS '';
COMMENT ON COLUMN BARS.S6_USERS.ISP IS '';
COMMENT ON COLUMN BARS.S6_USERS.FIO IS '';
COMMENT ON COLUMN BARS.S6_USERS.LOGIN IS '';
COMMENT ON COLUMN BARS.S6_USERS.HOST IS '';
COMMENT ON COLUMN BARS.S6_USERS.PASSWORD IS '';
COMMENT ON COLUMN BARS.S6_USERS.D_OD IS '';
COMMENT ON COLUMN BARS.S6_USERS.PR_END IS '';




PROMPT *** Create  constraint SYS_C0097523 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_USERS MODIFY (DistrSgn NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097522 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_USERS MODIFY (PR_HOST NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097521 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_USERS MODIFY (PR_LPMB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097520 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_USERS MODIFY (SIGN_TYPE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097519 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_USERS MODIFY (PR_PERMIT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097518 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_USERS MODIFY (PR_ACT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097517 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_USERS MODIFY (PR_END NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097516 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_USERS MODIFY (LOGIN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0097515 ***
begin   
 execute immediate '
  ALTER TABLE BARS.S6_USERS MODIFY (ISP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S6_USERS.sql =========*** End *** ====
PROMPT ===================================================================================== 
