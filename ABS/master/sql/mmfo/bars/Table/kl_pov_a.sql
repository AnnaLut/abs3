

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_POV_A.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_POV_A ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_POV_A'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_POV_A'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_POV_A'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_POV_A ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_POV_A 
   (	KB NUMBER, 
	RN_POV_A NUMBER, 
	ADR_POV_A VARCHAR2(70), 
	OKPO_A VARCHAR2(10), 
	NAM_A VARCHAR2(70), 
	ADR_A VARCHAR2(70), 
	NLS VARCHAR2(15), 
	KV NUMBER, 
	KO NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_POV_A ***
 exec bpa.alter_policies('KL_POV_A');


COMMENT ON TABLE BARS.KL_POV_A IS 'Классификатор счетов для пунктов обмена дейст. на агентских условиях';
COMMENT ON COLUMN BARS.KL_POV_A.KF IS '';
COMMENT ON COLUMN BARS.KL_POV_A.KB IS '';
COMMENT ON COLUMN BARS.KL_POV_A.RN_POV_A IS '';
COMMENT ON COLUMN BARS.KL_POV_A.ADR_POV_A IS '';
COMMENT ON COLUMN BARS.KL_POV_A.OKPO_A IS '';
COMMENT ON COLUMN BARS.KL_POV_A.NAM_A IS '';
COMMENT ON COLUMN BARS.KL_POV_A.ADR_A IS '';
COMMENT ON COLUMN BARS.KL_POV_A.NLS IS '';
COMMENT ON COLUMN BARS.KL_POV_A.KV IS '';
COMMENT ON COLUMN BARS.KL_POV_A.KO IS '';




PROMPT *** Create  constraint CC_KLPOVA_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_POV_A MODIFY (KF CONSTRAINT CC_KLPOVA_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006762 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KL_POV_A MODIFY (NLS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KL_POV_A ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_POV_A        to ABS_ADMIN;
grant SELECT                                                                 on KL_POV_A        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_POV_A        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_POV_A        to BARS_DM;
grant SELECT                                                                 on KL_POV_A        to RPBN002;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_POV_A        to SALGL;
grant SELECT                                                                 on KL_POV_A        to START1;
grant SELECT                                                                 on KL_POV_A        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_POV_A        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_POV_A.sql =========*** End *** ====
PROMPT ===================================================================================== 
