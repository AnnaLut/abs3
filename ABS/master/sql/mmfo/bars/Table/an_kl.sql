

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/AN_KL.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to AN_KL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''AN_KL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''AN_KL'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''AN_KL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table AN_KL ***
begin 
  execute immediate '
  CREATE TABLE BARS.AN_KL 
   (	ID NUMBER(*,0), 
	DK NUMBER(*,0), 
	NLS VARCHAR2(20), 
	NAME VARCHAR2(35), 
	IDP NUMBER(*,0), 
	NLSM VARCHAR2(20), 
	KV NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to AN_KL ***
 exec bpa.alter_policies('AN_KL');


COMMENT ON TABLE BARS.AN_KL IS '';
COMMENT ON COLUMN BARS.AN_KL.ID IS '';
COMMENT ON COLUMN BARS.AN_KL.DK IS '';
COMMENT ON COLUMN BARS.AN_KL.NLS IS '';
COMMENT ON COLUMN BARS.AN_KL.NAME IS '';
COMMENT ON COLUMN BARS.AN_KL.IDP IS '';
COMMENT ON COLUMN BARS.AN_KL.NLSM IS '';
COMMENT ON COLUMN BARS.AN_KL.KV IS '';
COMMENT ON COLUMN BARS.AN_KL.KF IS '';




PROMPT *** Create  constraint CC_ANKL_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.AN_KL MODIFY (KF CONSTRAINT CC_ANKL_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_AN_KLI ***
begin   
 execute immediate '
  ALTER TABLE BARS.AN_KL ADD CONSTRAINT XPK_AN_KLI PRIMARY KEY (KF, ID, IDP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_AN_KLI ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_AN_KLI ON BARS.AN_KL (KF, ID, IDP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  AN_KL ***
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on AN_KL           to AN_KL;
grant SELECT                                                                 on AN_KL           to BARSREADER_ROLE;
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on AN_KL           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on AN_KL           to BARS_DM;
grant SELECT                                                                 on AN_KL           to START1;
grant SELECT                                                                 on AN_KL           to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on AN_KL           to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on AN_KL           to WR_REFREAD;



PROMPT *** Create SYNONYM  to AN_KL ***

  CREATE OR REPLACE PUBLIC SYNONYM AN_KL FOR BARS.AN_KL;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/AN_KL.sql =========*** End *** =======
PROMPT ===================================================================================== 
