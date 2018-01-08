

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KLP_FILES.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KLP_FILES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KLP_FILES'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KLP_FILES'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KLP_FILES'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KLP_FILES ***
begin 
  execute immediate '
  CREATE TABLE BARS.KLP_FILES 
   (	FN VARCHAR2(12), 
	BODY LONG RAW, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KLP_FILES ***
 exec bpa.alter_policies('KLP_FILES');


COMMENT ON TABLE BARS.KLP_FILES IS '';
COMMENT ON COLUMN BARS.KLP_FILES.FN IS '';
COMMENT ON COLUMN BARS.KLP_FILES.BODY IS '';
COMMENT ON COLUMN BARS.KLP_FILES.KF IS '';




PROMPT *** Create  constraint PK_KLPFILES ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_FILES ADD CONSTRAINT PK_KLPFILES PRIMARY KEY (KF, FN)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLPFILES_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_FILES ADD CONSTRAINT FK_KLPFILES_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C009294 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_FILES MODIFY (FN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLPFILES_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_FILES MODIFY (KF CONSTRAINT CC_KLPFILES_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KLPFILES ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KLPFILES ON BARS.KLP_FILES (KF, FN) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KLP_FILES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KLP_FILES       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KLP_FILES       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KLP_FILES       to TECH_MOM1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KLP_FILES       to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to KLP_FILES ***

  CREATE OR REPLACE PUBLIC SYNONYM KLP_FILES FOR BARS.KLP_FILES;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KLP_FILES.sql =========*** End *** ===
PROMPT ===================================================================================== 
