

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KLP_ARCH.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KLP_ARCH ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KLP_ARCH'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KLP_ARCH'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KLP_ARCH'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KLP_ARCH ***
begin 
  execute immediate '
  CREATE TABLE BARS.KLP_ARCH 
   (	FN VARCHAR2(12), 
	TIP CHAR(3), 
	FILEDATE DATE, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KLP_ARCH ***
 exec bpa.alter_policies('KLP_ARCH');


COMMENT ON TABLE BARS.KLP_ARCH IS '';
COMMENT ON COLUMN BARS.KLP_ARCH.FN IS '';
COMMENT ON COLUMN BARS.KLP_ARCH.TIP IS '';
COMMENT ON COLUMN BARS.KLP_ARCH.FILEDATE IS '';
COMMENT ON COLUMN BARS.KLP_ARCH.KF IS '';




PROMPT *** Create  constraint PK_KLPARCH ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_ARCH ADD CONSTRAINT PK_KLPARCH PRIMARY KEY (KF, FN, TIP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_KLPARCH_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_ARCH ADD CONSTRAINT FK_KLPARCH_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006023 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_ARCH MODIFY (FN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006024 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_ARCH MODIFY (TIP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_KLPARCH_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_ARCH MODIFY (KF CONSTRAINT CC_KLPARCH_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KLPARCH ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KLPARCH ON BARS.KLP_ARCH (KF, FN, TIP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KLP_ARCH ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KLP_ARCH        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KLP_ARCH        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KLP_ARCH        to TECH_MOM1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KLP_ARCH        to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to KLP_ARCH ***

  CREATE OR REPLACE PUBLIC SYNONYM KLP_ARCH FOR BARS.KLP_ARCH;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KLP_ARCH.sql =========*** End *** ====
PROMPT ===================================================================================== 
