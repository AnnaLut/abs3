

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_FBB.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_FBB ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_FBB ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.OTCN_FBB 
   (	TOBO VARCHAR2(30), 
	RNK NUMBER, 
	OKPO VARCHAR2(15), 
	ACC NUMBER, 
	NBS VARCHAR2(4), 
	NLS VARCHAR2(15), 
	KV NUMBER(*,0), 
	R031 VARCHAR2(1), 
	FDAT DATE, 
	OST NUMBER, 
	KOD NUMBER, 
	PR NUMBER, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_FBB ***
 exec bpa.alter_policies('OTCN_FBB');


COMMENT ON TABLE BARS.OTCN_FBB IS 'Временная таблица бал.счетов и остатков для Фонда гарантирования';
COMMENT ON COLUMN BARS.OTCN_FBB.TOBO IS '';
COMMENT ON COLUMN BARS.OTCN_FBB.RNK IS '';
COMMENT ON COLUMN BARS.OTCN_FBB.OKPO IS '';
COMMENT ON COLUMN BARS.OTCN_FBB.ACC IS '';
COMMENT ON COLUMN BARS.OTCN_FBB.NBS IS '';
COMMENT ON COLUMN BARS.OTCN_FBB.NLS IS '';
COMMENT ON COLUMN BARS.OTCN_FBB.KV IS '';
COMMENT ON COLUMN BARS.OTCN_FBB.R031 IS '';
COMMENT ON COLUMN BARS.OTCN_FBB.FDAT IS '';
COMMENT ON COLUMN BARS.OTCN_FBB.OST IS '';
COMMENT ON COLUMN BARS.OTCN_FBB.KOD IS '';
COMMENT ON COLUMN BARS.OTCN_FBB.PR IS '';
COMMENT ON COLUMN BARS.OTCN_FBB.KF IS '';




PROMPT *** Create  constraint CC_OTCNFBB_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_FBB MODIFY (KF CONSTRAINT CC_OTCNFBB_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_OTCN_FBB ***
begin   
 execute immediate '
  CREATE INDEX BARS.XPK_OTCN_FBB ON BARS.OTCN_FBB (RNK, OKPO, R031) ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  OTCN_FBB ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_FBB        to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_FBB        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OTCN_FBB        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_FBB        to RPBN002;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OTCN_FBB        to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to OTCN_FBB ***

  CREATE OR REPLACE PUBLIC SYNONYM OTCN_FBB FOR BARS.OTCN_FBB;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_FBB.sql =========*** End *** ====
PROMPT ===================================================================================== 
