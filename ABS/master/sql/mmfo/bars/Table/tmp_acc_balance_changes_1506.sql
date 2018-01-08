

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_ACC_BALANCE_CHANGES_1506.sql =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_ACC_BALANCE_CHANGES_1506 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_ACC_BALANCE_CHANGES_1506 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_ACC_BALANCE_CHANGES_1506 
   (	ID NUMBER(*,0), 
	CHANGE_TIME DATE, 
	RNK NUMBER(*,0), 
	ACC NUMBER(*,0), 
	OSTC NUMBER, 
	DOS_DELTA NUMBER, 
	KOS_DELTA NUMBER, 
	REF NUMBER, 
	NLSB VARCHAR2(14), 
	TT VARCHAR2(3), 
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




PROMPT *** ALTER_POLICIES to TMP_ACC_BALANCE_CHANGES_1506 ***
 exec bpa.alter_policies('TMP_ACC_BALANCE_CHANGES_1506');


COMMENT ON TABLE BARS.TMP_ACC_BALANCE_CHANGES_1506 IS '';
COMMENT ON COLUMN BARS.TMP_ACC_BALANCE_CHANGES_1506.ID IS '';
COMMENT ON COLUMN BARS.TMP_ACC_BALANCE_CHANGES_1506.CHANGE_TIME IS '';
COMMENT ON COLUMN BARS.TMP_ACC_BALANCE_CHANGES_1506.RNK IS '';
COMMENT ON COLUMN BARS.TMP_ACC_BALANCE_CHANGES_1506.ACC IS '';
COMMENT ON COLUMN BARS.TMP_ACC_BALANCE_CHANGES_1506.OSTC IS '';
COMMENT ON COLUMN BARS.TMP_ACC_BALANCE_CHANGES_1506.DOS_DELTA IS '';
COMMENT ON COLUMN BARS.TMP_ACC_BALANCE_CHANGES_1506.KOS_DELTA IS '';
COMMENT ON COLUMN BARS.TMP_ACC_BALANCE_CHANGES_1506.REF IS '';
COMMENT ON COLUMN BARS.TMP_ACC_BALANCE_CHANGES_1506.NLSB IS '';
COMMENT ON COLUMN BARS.TMP_ACC_BALANCE_CHANGES_1506.TT IS '';
COMMENT ON COLUMN BARS.TMP_ACC_BALANCE_CHANGES_1506.NLSA IS '';
COMMENT ON COLUMN BARS.TMP_ACC_BALANCE_CHANGES_1506.KF IS '';




PROMPT *** Create  constraint SYS_C00135439 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ACC_BALANCE_CHANGES_1506 MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00135440 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ACC_BALANCE_CHANGES_1506 MODIFY (CHANGE_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00135441 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ACC_BALANCE_CHANGES_1506 MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00135442 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ACC_BALANCE_CHANGES_1506 MODIFY (ACC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00135443 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ACC_BALANCE_CHANGES_1506 MODIFY (OSTC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00135444 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ACC_BALANCE_CHANGES_1506 MODIFY (DOS_DELTA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C00135445 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_ACC_BALANCE_CHANGES_1506 MODIFY (KOS_DELTA NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_ACC_BALANCE_CHANGES_1506 ***
grant SELECT                                                                 on TMP_ACC_BALANCE_CHANGES_1506 to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_ACC_BALANCE_CHANGES_1506.sql =====
PROMPT ===================================================================================== 
