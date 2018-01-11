

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACC_BALANCE_CHANGES.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACC_BALANCE_CHANGES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACC_BALANCE_CHANGES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ACC_BALANCE_CHANGES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ACC_BALANCE_CHANGES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACC_BALANCE_CHANGES ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACC_BALANCE_CHANGES 
   (	ID NUMBER(*,0), 
	CHANGE_TIME DATE DEFAULT sysdate, 
	RNK NUMBER(*,0), 
	ACC NUMBER(*,0), 
	OSTC NUMBER, 
	DOS_DELTA NUMBER DEFAULT 0, 
	KOS_DELTA NUMBER DEFAULT 0, 
	REF NUMBER, 
	NLSB VARCHAR2(14), 
	TT VARCHAR2(3), 
	NLSA VARCHAR2(14), 
	KF VARCHAR2(6), 
	 CONSTRAINT PK_ACCBALCH PRIMARY KEY (ID) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYND 
 PCTTHRESHOLD 50';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACC_BALANCE_CHANGES ***
 exec bpa.alter_policies('ACC_BALANCE_CHANGES');


COMMENT ON TABLE BARS.ACC_BALANCE_CHANGES IS 'История изменений остатков по счетам';
COMMENT ON COLUMN BARS.ACC_BALANCE_CHANGES.ID IS '';
COMMENT ON COLUMN BARS.ACC_BALANCE_CHANGES.CHANGE_TIME IS '';
COMMENT ON COLUMN BARS.ACC_BALANCE_CHANGES.RNK IS '';
COMMENT ON COLUMN BARS.ACC_BALANCE_CHANGES.ACC IS '';
COMMENT ON COLUMN BARS.ACC_BALANCE_CHANGES.OSTC IS '';
COMMENT ON COLUMN BARS.ACC_BALANCE_CHANGES.DOS_DELTA IS '';
COMMENT ON COLUMN BARS.ACC_BALANCE_CHANGES.KOS_DELTA IS '';
COMMENT ON COLUMN BARS.ACC_BALANCE_CHANGES.REF IS '';
COMMENT ON COLUMN BARS.ACC_BALANCE_CHANGES.NLSB IS '';
COMMENT ON COLUMN BARS.ACC_BALANCE_CHANGES.TT IS '';
COMMENT ON COLUMN BARS.ACC_BALANCE_CHANGES.NLSA IS '';
COMMENT ON COLUMN BARS.ACC_BALANCE_CHANGES.KF IS '';




PROMPT *** Create  constraint CC_ACCBALCH_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_BALANCE_CHANGES MODIFY (ID CONSTRAINT CC_ACCBALCH_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCBALCH_CHTIME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_BALANCE_CHANGES MODIFY (CHANGE_TIME CONSTRAINT CC_ACCBALCH_CHTIME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCBALCH_RNK_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_BALANCE_CHANGES MODIFY (RNK CONSTRAINT CC_ACCBALCH_RNK_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCBALCH_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_BALANCE_CHANGES MODIFY (ACC CONSTRAINT CC_ACCBALCH_ACC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCBALCH_OSTC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_BALANCE_CHANGES MODIFY (OSTC CONSTRAINT CC_ACCBALCH_OSTC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCBALCH_DOSD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_BALANCE_CHANGES MODIFY (DOS_DELTA CONSTRAINT CC_ACCBALCH_DOSD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ACCBALCH_KOSD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_BALANCE_CHANGES MODIFY (KOS_DELTA CONSTRAINT CC_ACCBALCH_KOSD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_ACCBALCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_BALANCE_CHANGES ADD CONSTRAINT PK_ACCBALCH PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCBALCH ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCBALCH ON BARS.ACC_BALANCE_CHANGES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACC_BALANCE_CHANGES ***
grant SELECT                                                                 on ACC_BALANCE_CHANGES to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_BALANCE_CHANGES to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACC_BALANCE_CHANGES to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_BALANCE_CHANGES to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACC_BALANCE_CHANGES.sql =========*** E
PROMPT ===================================================================================== 
