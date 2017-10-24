

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/AN2K.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to AN2K ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''AN2K'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''AN2K'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''AN2K'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table AN2K ***
begin 
  execute immediate '
  CREATE TABLE BARS.AN2K 
   (	RNK NUMBER(38,0), 
	FDAT DATE, 
	OSTA NUMBER, 
	OSTP NUMBER, 
	DOSQ NUMBER, 
	KOSQ NUMBER, 
	SUM6 NUMBER, 
	SUM7 NUMBER, 
	TRCN NUMBER(38,0), 
	REZ7 NUMBER, 
	CUSTTYPE NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to AN2K ***
 exec bpa.alter_policies('AN2K');


COMMENT ON TABLE BARS.AN2K IS '';
COMMENT ON COLUMN BARS.AN2K.RNK IS '';
COMMENT ON COLUMN BARS.AN2K.FDAT IS '';
COMMENT ON COLUMN BARS.AN2K.OSTA IS '';
COMMENT ON COLUMN BARS.AN2K.OSTP IS '';
COMMENT ON COLUMN BARS.AN2K.DOSQ IS '';
COMMENT ON COLUMN BARS.AN2K.KOSQ IS '';
COMMENT ON COLUMN BARS.AN2K.SUM6 IS '';
COMMENT ON COLUMN BARS.AN2K.SUM7 IS '';
COMMENT ON COLUMN BARS.AN2K.TRCN IS '';
COMMENT ON COLUMN BARS.AN2K.REZ7 IS '';
COMMENT ON COLUMN BARS.AN2K.CUSTTYPE IS '';
COMMENT ON COLUMN BARS.AN2K.KF IS '';




PROMPT *** Create  constraint SYS_C005845 ***
begin   
 execute immediate '
  ALTER TABLE BARS.AN2K MODIFY (RNK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005846 ***
begin   
 execute immediate '
  ALTER TABLE BARS.AN2K MODIFY (FDAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_AN2K_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AN2K MODIFY (KF CONSTRAINT CC_AN2K_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_AN2K ***
begin   
 execute immediate '
  ALTER TABLE BARS.AN2K ADD CONSTRAINT XPK_AN2K PRIMARY KEY (KF, RNK, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_AN2K ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_AN2K ON BARS.AN2K (KF, RNK, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  AN2K ***
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on AN2K            to AN_KL;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on AN2K            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on AN2K            to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on AN2K            to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to AN2K ***

  CREATE OR REPLACE PUBLIC SYNONYM AN2K FOR BARS.AN2K;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/AN2K.sql =========*** End *** ========
PROMPT ===================================================================================== 
