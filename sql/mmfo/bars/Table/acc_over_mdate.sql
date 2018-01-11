

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACC_OVER_MDATE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACC_OVER_MDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACC_OVER_MDATE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ACC_OVER_MDATE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ACC_OVER_MDATE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACC_OVER_MDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACC_OVER_MDATE 
   (	ND NUMBER, 
	MDATE DATE, 
	ACCO NUMBER, 
	BDATE DATE, 
	TYPE NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACC_OVER_MDATE ***
 exec bpa.alter_policies('ACC_OVER_MDATE');


COMMENT ON TABLE BARS.ACC_OVER_MDATE IS '';
COMMENT ON COLUMN BARS.ACC_OVER_MDATE.ND IS '';
COMMENT ON COLUMN BARS.ACC_OVER_MDATE.MDATE IS '';
COMMENT ON COLUMN BARS.ACC_OVER_MDATE.ACCO IS '';
COMMENT ON COLUMN BARS.ACC_OVER_MDATE.BDATE IS '';
COMMENT ON COLUMN BARS.ACC_OVER_MDATE.TYPE IS '';
COMMENT ON COLUMN BARS.ACC_OVER_MDATE.KF IS '';




PROMPT *** Create  constraint XPK_ACC_OVER_MDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_MDATE ADD CONSTRAINT XPK_ACC_OVER_MDATE PRIMARY KEY (ND, MDATE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_ACC_OVER_MDATE_ND ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_MDATE MODIFY (ND CONSTRAINT NK_ACC_OVER_MDATE_ND NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_ACC_OVER_MDATE_MDATE ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_MDATE MODIFY (MDATE CONSTRAINT NK_ACC_OVER_MDATE_MDATE NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOVERMDATE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_MDATE MODIFY (KF CONSTRAINT CC_ACCOVERMDATE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ACC_OVER_MDATE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ACC_OVER_MDATE ON BARS.ACC_OVER_MDATE (ND, MDATE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACC_OVER_MDATE ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_MDATE  to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_MDATE  to BARS009;
grant SELECT                                                                 on ACC_OVER_MDATE  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_MDATE  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACC_OVER_MDATE  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_MDATE  to TECH005;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_MDATE  to TECH006;
grant SELECT                                                                 on ACC_OVER_MDATE  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ACC_OVER_MDATE  to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to ACC_OVER_MDATE ***

  CREATE OR REPLACE PUBLIC SYNONYM ACC_OVER_MDATE FOR BARS.ACC_OVER_MDATE;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACC_OVER_MDATE.sql =========*** End **
PROMPT ===================================================================================== 
