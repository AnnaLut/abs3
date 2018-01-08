

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACC_OVER_COMIS.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACC_OVER_COMIS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACC_OVER_COMIS'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ACC_OVER_COMIS'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ACC_OVER_COMIS'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACC_OVER_COMIS ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACC_OVER_COMIS 
   (	ACC NUMBER, 
	SUM NUMBER, 
	FDAT DATE, 
	WORKED NUMBER DEFAULT 0, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACC_OVER_COMIS ***
 exec bpa.alter_policies('ACC_OVER_COMIS');


COMMENT ON TABLE BARS.ACC_OVER_COMIS IS '';
COMMENT ON COLUMN BARS.ACC_OVER_COMIS.ACC IS '';
COMMENT ON COLUMN BARS.ACC_OVER_COMIS.SUM IS '';
COMMENT ON COLUMN BARS.ACC_OVER_COMIS.FDAT IS '';
COMMENT ON COLUMN BARS.ACC_OVER_COMIS.WORKED IS '';
COMMENT ON COLUMN BARS.ACC_OVER_COMIS.KF IS '';




PROMPT *** Create  constraint XPK_ACC_OVER_COMIS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_COMIS ADD CONSTRAINT XPK_ACC_OVER_COMIS PRIMARY KEY (ACC, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOVERCOMIS_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_COMIS ADD CONSTRAINT FK_ACCOVERCOMIS_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_ACCOVERCOMIS_ACCOUNTS ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_COMIS ADD CONSTRAINT FK_ACCOVERCOMIS_ACCOUNTS FOREIGN KEY (KF, ACC)
	  REFERENCES BARS.ACCOUNTS (KF, ACC) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007441 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_COMIS MODIFY (WORKED NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCOVERCOMIS_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_OVER_COMIS MODIFY (KF CONSTRAINT CC_ACCOVERCOMIS_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_ACC_OVER_COMIS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_ACC_OVER_COMIS ON BARS.ACC_OVER_COMIS (ACC, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACC_OVER_COMIS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_COMIS  to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_COMIS  to BARS009;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_COMIS  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACC_OVER_COMIS  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_COMIS  to START1;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_COMIS  to TECH005;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_OVER_COMIS  to TECH006;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ACC_OVER_COMIS  to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to ACC_OVER_COMIS ***

  CREATE OR REPLACE PUBLIC SYNONYM ACC_OVER_COMIS FOR BARS.ACC_OVER_COMIS;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACC_OVER_COMIS.sql =========*** End **
PROMPT ===================================================================================== 
