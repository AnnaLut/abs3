

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SEC_LOGINS.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SEC_LOGINS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SEC_LOGINS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SEC_LOGINS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SEC_LOGINS ***
begin 
  execute immediate '
  CREATE TABLE BARS.SEC_LOGINS 
   (	SECID VARCHAR2(32), 
	TASKID NUMBER(5,0), 
	ORALOGIN VARCHAR2(32), 
	ORAPASSWORD VARCHAR2(32)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SEC_LOGINS ***
 exec bpa.alter_policies('SEC_LOGINS');


COMMENT ON TABLE BARS.SEC_LOGINS IS '';
COMMENT ON COLUMN BARS.SEC_LOGINS.SECID IS '';
COMMENT ON COLUMN BARS.SEC_LOGINS.TASKID IS '';
COMMENT ON COLUMN BARS.SEC_LOGINS.ORALOGIN IS '';
COMMENT ON COLUMN BARS.SEC_LOGINS.ORAPASSWORD IS '';




PROMPT *** Create  constraint CC_SECLOGINS_SECID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_LOGINS MODIFY (SECID CONSTRAINT CC_SECLOGINS_SECID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECLOGINS_TASKID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_LOGINS MODIFY (TASKID CONSTRAINT CC_SECLOGINS_TASKID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECLOGINS_ORALOGIN_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_LOGINS MODIFY (ORALOGIN CONSTRAINT CC_SECLOGINS_ORALOGIN_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_SECLOGINS_ORAPASSWORD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_LOGINS MODIFY (ORAPASSWORD CONSTRAINT CC_SECLOGINS_ORAPASSWORD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SECLOGINS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEC_LOGINS ADD CONSTRAINT PK_SECLOGINS PRIMARY KEY (SECID, TASKID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SECLOGINS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SECLOGINS ON BARS.SEC_LOGINS (SECID, TASKID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SEC_LOGINS ***
grant SELECT                                                                 on SEC_LOGINS      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SEC_LOGINS      to BARS_DM;
grant SELECT                                                                 on SEC_LOGINS      to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SEC_LOGINS      to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SEC_LOGINS.sql =========*** End *** ==
PROMPT ===================================================================================== 
