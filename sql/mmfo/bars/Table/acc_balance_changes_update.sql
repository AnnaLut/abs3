

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACC_BALANCE_CHANGES_UPDATE.sql =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACC_BALANCE_CHANGES_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACC_BALANCE_CHANGES_UPDATE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ACC_BALANCE_CHANGES_UPDATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ACC_BALANCE_CHANGES_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACC_BALANCE_CHANGES_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACC_BALANCE_CHANGES_UPDATE 
   (	ID NUMBER(*,0), 
	CHANGE_TIME DATE DEFAULT sysdate, 
	RNK NUMBER(*,0), 
	ACC NUMBER(*,0), 
	OSTC NUMBER, 
	DOS_DELTA NUMBER DEFAULT 0, 
	KOS_DELTA NUMBER DEFAULT 0, 
	REF NUMBER, 
	TT VARCHAR2(3), 
	NLSB VARCHAR2(14), 
	NLSA VARCHAR2(14), 
	KF VARCHAR2(6)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACC_BALANCE_CHANGES_UPDATE ***
 exec bpa.alter_policies('ACC_BALANCE_CHANGES_UPDATE');


COMMENT ON TABLE BARS.ACC_BALANCE_CHANGES_UPDATE IS 'История изменений остатков по счетам';
COMMENT ON COLUMN BARS.ACC_BALANCE_CHANGES_UPDATE.ID IS '';
COMMENT ON COLUMN BARS.ACC_BALANCE_CHANGES_UPDATE.CHANGE_TIME IS '';
COMMENT ON COLUMN BARS.ACC_BALANCE_CHANGES_UPDATE.RNK IS '';
COMMENT ON COLUMN BARS.ACC_BALANCE_CHANGES_UPDATE.ACC IS '';
COMMENT ON COLUMN BARS.ACC_BALANCE_CHANGES_UPDATE.OSTC IS '';
COMMENT ON COLUMN BARS.ACC_BALANCE_CHANGES_UPDATE.DOS_DELTA IS '';
COMMENT ON COLUMN BARS.ACC_BALANCE_CHANGES_UPDATE.KOS_DELTA IS '';
COMMENT ON COLUMN BARS.ACC_BALANCE_CHANGES_UPDATE.REF IS '';
COMMENT ON COLUMN BARS.ACC_BALANCE_CHANGES_UPDATE.TT IS '';
COMMENT ON COLUMN BARS.ACC_BALANCE_CHANGES_UPDATE.NLSB IS '';
COMMENT ON COLUMN BARS.ACC_BALANCE_CHANGES_UPDATE.NLSA IS '';
COMMENT ON COLUMN BARS.ACC_BALANCE_CHANGES_UPDATE.KF IS '';




PROMPT *** Create  constraint CC_ACCBALCHUPD_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_BALANCE_CHANGES_UPDATE MODIFY (ID CONSTRAINT CC_ACCBALCHUPD_ID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCBALCHUPD_CHTIME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_BALANCE_CHANGES_UPDATE MODIFY (CHANGE_TIME CONSTRAINT CC_ACCBALCHUPD_CHTIME_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCBALCHUPD_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_BALANCE_CHANGES_UPDATE MODIFY (RNK CONSTRAINT CC_ACCBALCHUPD_RNK_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCBALCHUPD_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_BALANCE_CHANGES_UPDATE MODIFY (ACC CONSTRAINT CC_ACCBALCHUPD_ACC_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCBALCHUPD_OSTC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_BALANCE_CHANGES_UPDATE MODIFY (OSTC CONSTRAINT CC_ACCBALCHUPD_OSTC_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCBALCHUPD_DOSD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_BALANCE_CHANGES_UPDATE MODIFY (DOS_DELTA CONSTRAINT CC_ACCBALCHUPD_DOSD_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCBALCHUPD_KOSD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_BALANCE_CHANGES_UPDATE MODIFY (KOS_DELTA CONSTRAINT CC_ACCBALCHUPD_KOSD_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACC_BALANCE_CHANGES_UPDATE ***
grant SELECT                                                                 on ACC_BALANCE_CHANGES_UPDATE to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on ACC_BALANCE_CHANGES_UPDATE to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACC_BALANCE_CHANGES_UPDATE to BARS_DM;
grant SELECT                                                                 on ACC_BALANCE_CHANGES_UPDATE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACC_BALANCE_CHANGES_UPDATE.sql =======
PROMPT ===================================================================================== 
