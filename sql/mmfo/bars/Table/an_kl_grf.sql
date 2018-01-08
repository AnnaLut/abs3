

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/AN_KL_GRF.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to AN_KL_GRF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''AN_KL_GRF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''AN_KL_GRF'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''AN_KL_GRF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table AN_KL_GRF ***
begin 
  execute immediate '
  CREATE TABLE BARS.AN_KL_GRF 
   (	GRF VARCHAR2(3), 
	NAME VARCHAR2(30), 
	FRM VARCHAR2(250), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to AN_KL_GRF ***
 exec bpa.alter_policies('AN_KL_GRF');


COMMENT ON TABLE BARS.AN_KL_GRF IS '';
COMMENT ON COLUMN BARS.AN_KL_GRF.GRF IS '';
COMMENT ON COLUMN BARS.AN_KL_GRF.NAME IS '';
COMMENT ON COLUMN BARS.AN_KL_GRF.FRM IS '';
COMMENT ON COLUMN BARS.AN_KL_GRF.KF IS '';




PROMPT *** Create  constraint SYS_C009766 ***
begin   
 execute immediate '
  ALTER TABLE BARS.AN_KL_GRF MODIFY (GRF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ANKLGRF_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AN_KL_GRF MODIFY (KF CONSTRAINT CC_ANKLGRF_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_AN_KL_GRF ***
begin   
 execute immediate '
  ALTER TABLE BARS.AN_KL_GRF ADD CONSTRAINT XPK_AN_KL_GRF PRIMARY KEY (KF, GRF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_AN_KL_GRF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_AN_KL_GRF ON BARS.AN_KL_GRF (KF, GRF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  AN_KL_GRF ***
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on AN_KL_GRF       to AN_KL;
grant SELECT                                                                 on AN_KL_GRF       to BARSREADER_ROLE;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on AN_KL_GRF       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on AN_KL_GRF       to BARS_DM;
grant SELECT                                                                 on AN_KL_GRF       to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on AN_KL_GRF       to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on AN_KL_GRF       to WR_REFREAD;



PROMPT *** Create SYNONYM  to AN_KL_GRF ***

  CREATE OR REPLACE PUBLIC SYNONYM AN_KL_GRF FOR BARS.AN_KL_GRF;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/AN_KL_GRF.sql =========*** End *** ===
PROMPT ===================================================================================== 
