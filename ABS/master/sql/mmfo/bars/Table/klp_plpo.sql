

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KLP_PLPO.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KLP_PLPO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KLP_PLPO'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KLP_PLPO'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KLP_PLPO'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KLP_PLPO ***
begin 
  execute immediate '
  CREATE TABLE BARS.KLP_PLPO 
   (	OTW NUMBER(*,0), 
	TOW NUMBER(*,0), 
	DTI DATE, 
	DTO DATE, 
	MRK NUMBER(*,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KLP_PLPO ***
 exec bpa.alter_policies('KLP_PLPO');


COMMENT ON TABLE BARS.KLP_PLPO IS 'Состояние передачи/возарата полномочий по КЛИЕНТ-БАНК';
COMMENT ON COLUMN BARS.KLP_PLPO.OTW IS 'идентификатор пользователя, от которого передаются полномочия';
COMMENT ON COLUMN BARS.KLP_PLPO.TOW IS 'идентификатор пользователя, которому передаются полномочия';
COMMENT ON COLUMN BARS.KLP_PLPO.DTI IS 'дата (со временем) передачи полномочий';
COMMENT ON COLUMN BARS.KLP_PLPO.DTO IS 'дата (со временем) возврата полномочий';
COMMENT ON COLUMN BARS.KLP_PLPO.MRK IS 'отметка (0 - полномочия не переданы,
         1 - полномочия переданы,
         2 - полномочия возвращены)';
COMMENT ON COLUMN BARS.KLP_PLPO.KF IS '';




PROMPT *** Create  constraint SYS_C008766 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_PLPO MODIFY (OTW NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008767 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_PLPO MODIFY (TOW NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008768 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_PLPO MODIFY (DTI NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008769 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_PLPO MODIFY (MRK NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLPPLPO_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_PLPO MODIFY (KF CONSTRAINT CC_KLPPLPO_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KLP_PLPO ***
grant SELECT                                                                 on KLP_PLPO        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT                                                   on KLP_PLPO        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KLP_PLPO        to BARS_DM;
grant DELETE,INSERT,SELECT                                                   on KLP_PLPO        to TECH_MOM1;
grant SELECT                                                                 on KLP_PLPO        to UPLD;



PROMPT *** Create SYNONYM  to KLP_PLPO ***

  CREATE OR REPLACE PUBLIC SYNONYM KLP_PLPO FOR BARS.KLP_PLPO;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KLP_PLPO.sql =========*** End *** ====
PROMPT ===================================================================================== 
