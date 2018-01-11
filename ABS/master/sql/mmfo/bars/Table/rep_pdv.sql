

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REP_PDV.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REP_PDV ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REP_PDV'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REP_PDV'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''REP_PDV'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REP_PDV ***
begin 
  execute immediate '
  CREATE TABLE BARS.REP_PDV 
   (	ID NUMBER(*,0) DEFAULT 0, 
	NN NUMBER(*,0), 
	NBS_DT CHAR(4), 
	OB22_DT CHAR(2), 
	NBS_KT CHAR(4), 
	OB22_KT CHAR(2), 
	NLS_DT VARCHAR2(14), 
	NLS_KT VARCHAR2(14), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REP_PDV ***
 exec bpa.alter_policies('REP_PDV');


COMMENT ON TABLE BARS.REP_PDV IS '';
COMMENT ON COLUMN BARS.REP_PDV.KF IS '';
COMMENT ON COLUMN BARS.REP_PDV.ID IS '';
COMMENT ON COLUMN BARS.REP_PDV.NN IS '';
COMMENT ON COLUMN BARS.REP_PDV.NBS_DT IS '';
COMMENT ON COLUMN BARS.REP_PDV.OB22_DT IS '';
COMMENT ON COLUMN BARS.REP_PDV.NBS_KT IS '';
COMMENT ON COLUMN BARS.REP_PDV.OB22_KT IS '';
COMMENT ON COLUMN BARS.REP_PDV.NLS_DT IS '';
COMMENT ON COLUMN BARS.REP_PDV.NLS_KT IS '';




PROMPT *** Create  constraint XPK_REP_PDV ***
begin   
 execute immediate '
  ALTER TABLE BARS.REP_PDV ADD CONSTRAINT XPK_REP_PDV PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007696 ***
begin   
 execute immediate '
  ALTER TABLE BARS.REP_PDV MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_REP_PDV ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_REP_PDV ON BARS.REP_PDV (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index IDX_REP_PDV_NN ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_REP_PDV_NN ON BARS.REP_PDV (NN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REP_PDV ***
grant SELECT                                                                 on REP_PDV         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REP_PDV         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REP_PDV         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on REP_PDV         to NALOG;
grant SELECT                                                                 on REP_PDV         to UPLD;
grant FLASHBACK,SELECT                                                       on REP_PDV         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REP_PDV.sql =========*** End *** =====
PROMPT ===================================================================================== 
