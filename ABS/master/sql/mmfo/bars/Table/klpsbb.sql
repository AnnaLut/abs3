

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KLPSBB.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KLPSBB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KLPSBB'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KLPSBB'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KLPSBB'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KLPSBB ***
begin 
  execute immediate '
  CREATE TABLE BARS.KLPSBB 
   (	SAB CHAR(4), 
	TIP VARCHAR2(10), 
	IDB VARCHAR2(254), 
	IDD VARCHAR2(254), 
	IDO VARCHAR2(254), 
	IDS VARCHAR2(254), 
	BLK CHAR(1), 
	FLAG CHAR(1), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KLPSBB ***
 exec bpa.alter_policies('KLPSBB');


COMMENT ON TABLE BARS.KLPSBB IS '';
COMMENT ON COLUMN BARS.KLPSBB.SAB IS '';
COMMENT ON COLUMN BARS.KLPSBB.TIP IS '';
COMMENT ON COLUMN BARS.KLPSBB.IDB IS '';
COMMENT ON COLUMN BARS.KLPSBB.IDD IS '';
COMMENT ON COLUMN BARS.KLPSBB.IDO IS '';
COMMENT ON COLUMN BARS.KLPSBB.IDS IS '';
COMMENT ON COLUMN BARS.KLPSBB.BLK IS '';
COMMENT ON COLUMN BARS.KLPSBB.FLAG IS '';
COMMENT ON COLUMN BARS.KLPSBB.KF IS '';




PROMPT *** Create  constraint SYS_C009230 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPSBB MODIFY (SAB NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLPSBB_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPSBB MODIFY (KF CONSTRAINT CC_KLPSBB_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_KLPSBB ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPSBB ADD CONSTRAINT PK_KLPSBB PRIMARY KEY (KF, SAB)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0011199 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLPSBB ADD UNIQUE (SAB)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KLPSBB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KLPSBB ON BARS.KLPSBB (KF, SAB) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index SYS_C0011199 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.SYS_C0011199 ON BARS.KLPSBB (SAB) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KLPSBB ***
grant SELECT                                                                 on KLPSBB          to BARSREADER_ROLE;
grant SELECT                                                                 on KLPSBB          to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on KLPSBB          to OPERKKK;
grant SELECT                                                                 on KLPSBB          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KLPSBB          to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to KLPSBB ***

  CREATE OR REPLACE PUBLIC SYNONYM KLPSBB FOR BARS.KLPSBB;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KLPSBB.sql =========*** End *** ======
PROMPT ===================================================================================== 
