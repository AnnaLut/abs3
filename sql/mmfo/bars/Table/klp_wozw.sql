

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KLP_WOZW.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KLP_WOZW ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KLP_WOZW'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KLP_WOZW'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KLP_WOZW'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KLP_WOZW ***
begin 
  execute immediate '
  CREATE TABLE BARS.KLP_WOZW 
   (	NEOM NUMBER(*,0), 
	PRWO VARCHAR2(60), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KLP_WOZW ***
 exec bpa.alter_policies('KLP_WOZW');


COMMENT ON TABLE BARS.KLP_WOZW IS '';
COMMENT ON COLUMN BARS.KLP_WOZW.NEOM IS '';
COMMENT ON COLUMN BARS.KLP_WOZW.PRWO IS '';
COMMENT ON COLUMN BARS.KLP_WOZW.KF IS '';




PROMPT *** Create  constraint SYS_C005818 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_WOZW MODIFY (NEOM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005819 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_WOZW MODIFY (PRWO NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLPWOZW_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_WOZW MODIFY (KF CONSTRAINT CC_KLPWOZW_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KLP_WOZW ***
grant SELECT                                                                 on KLP_WOZW        to BARSREADER_ROLE;
grant SELECT                                                                 on KLP_WOZW        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KLP_WOZW        to BARS_DM;
grant INSERT,SELECT                                                          on KLP_WOZW        to OPERKKK;
grant SELECT                                                                 on KLP_WOZW        to START1;
grant SELECT                                                                 on KLP_WOZW        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KLP_WOZW        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KLP_WOZW.sql =========*** End *** ====
PROMPT ===================================================================================== 
