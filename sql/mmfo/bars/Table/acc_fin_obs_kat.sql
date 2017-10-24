

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ACC_FIN_OBS_KAT.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ACC_FIN_OBS_KAT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ACC_FIN_OBS_KAT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ACC_FIN_OBS_KAT'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ACC_FIN_OBS_KAT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ACC_FIN_OBS_KAT ***
begin 
  execute immediate '
  CREATE TABLE BARS.ACC_FIN_OBS_KAT 
   (	ACC NUMBER(*,0), 
	FIN NUMBER, 
	OBS NUMBER, 
	KAT NUMBER, 
	K NUMBER, 
	PR NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ACC_FIN_OBS_KAT ***
 exec bpa.alter_policies('ACC_FIN_OBS_KAT');


COMMENT ON TABLE BARS.ACC_FIN_OBS_KAT IS '';
COMMENT ON COLUMN BARS.ACC_FIN_OBS_KAT.ACC IS '';
COMMENT ON COLUMN BARS.ACC_FIN_OBS_KAT.FIN IS '';
COMMENT ON COLUMN BARS.ACC_FIN_OBS_KAT.OBS IS '';
COMMENT ON COLUMN BARS.ACC_FIN_OBS_KAT.KAT IS '';
COMMENT ON COLUMN BARS.ACC_FIN_OBS_KAT.K IS '';
COMMENT ON COLUMN BARS.ACC_FIN_OBS_KAT.PR IS '';




PROMPT *** Create  constraint PK_ACCFINOBSKAT ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_FIN_OBS_KAT ADD CONSTRAINT PK_ACCFINOBSKAT PRIMARY KEY (ACC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FINOBSKAT_ACC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ACC_FIN_OBS_KAT MODIFY (ACC CONSTRAINT CC_FINOBSKAT_ACC_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ACCFINOBSKAT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ACCFINOBSKAT ON BARS.ACC_FIN_OBS_KAT (ACC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ACC_FIN_OBS_KAT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_FIN_OBS_KAT to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ACC_FIN_OBS_KAT to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ACC_FIN_OBS_KAT to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ACC_FIN_OBS_KAT.sql =========*** End *
PROMPT ===================================================================================== 
