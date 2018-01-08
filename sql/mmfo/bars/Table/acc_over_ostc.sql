

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACC_OVER_OSTC.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACC_OVER_OSTC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACC_OVER_OSTC'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ACC_OVER_OSTC'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ACC_OVER_OSTC'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACC_OVER_OSTC ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACC_OVER_OSTC 
   (	ND NUMBER, 
	DAT DATE, 
	ACCO NUMBER, 
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




PROMPT *** ALTER_POLICIES to ACC_OVER_OSTC ***
 exec bpa.alter_policies('ACC_OVER_OSTC');


COMMENT ON TABLE BARS.ACC_OVER_OSTC IS '';
COMMENT ON COLUMN BARS.ACC_OVER_OSTC.ND IS '';
COMMENT ON COLUMN BARS.ACC_OVER_OSTC.DAT IS '';
COMMENT ON COLUMN BARS.ACC_OVER_OSTC.ACCO IS '';
COMMENT ON COLUMN BARS.ACC_OVER_OSTC.TYPE IS '';
COMMENT ON COLUMN BARS.ACC_OVER_OSTC.KF IS '';




PROMPT *** Create  constraint XPK_ACC_OVER_OSTC ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_OSTC ADD CONSTRAINT XPK_ACC_OVER_OSTC PRIMARY KEY (ND, DAT, TYPE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOVEROSTC_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_OSTC ADD CONSTRAINT FK_ACCOVEROSTC_ACCOUNTS FOREIGN KEY (KF, ACCO)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOVEROSTC_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_OSTC ADD CONSTRAINT FK_ACCOVEROSTC_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOVEROSTC_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_OSTC MODIFY (KF CONSTRAINT CC_ACCOVEROSTC_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ACC_OVER_OSTC ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ACC_OVER_OSTC ON BARS.ACC_OVER_OSTC (ND, DAT, TYPE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACC_OVER_OSTC ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_OSTC   to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_OSTC   to BARS009;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_OSTC   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACC_OVER_OSTC   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_OSTC   to TECH005;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_OSTC   to TECH006;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ACC_OVER_OSTC   to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to ACC_OVER_OSTC ***

  CREATE OR REPLACE PUBLIC SYNONYM ACC_OVER_OSTC FOR BARS.ACC_OVER_OSTC;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACC_OVER_OSTC.sql =========*** End ***
PROMPT ===================================================================================== 
