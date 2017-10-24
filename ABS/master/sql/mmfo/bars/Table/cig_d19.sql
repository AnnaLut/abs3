

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIG_D19.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIG_D19 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIG_D19'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIG_D19'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CIG_D19'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIG_D19 ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIG_D19 
   (	ID NUMBER(*,0), 
	KOD VARCHAR2(10), 
	TXT VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIG_D19 ***
 exec bpa.alter_policies('CIG_D19');


COMMENT ON TABLE BARS.CIG_D19 IS 'D19 - Спосіб платежу';
COMMENT ON COLUMN BARS.CIG_D19.ID IS '';
COMMENT ON COLUMN BARS.CIG_D19.KOD IS '';
COMMENT ON COLUMN BARS.CIG_D19.TXT IS '';




PROMPT *** Create  constraint PK_CIG_D19 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_D19 ADD CONSTRAINT PK_CIG_D19 PRIMARY KEY (KOD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_CIG_D19_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_D19 ADD CONSTRAINT UK_CIG_D19_ID UNIQUE (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_CIG_D19_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_CIG_D19_ID ON BARS.CIG_D19 (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIG_D19 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIG_D19 ON BARS.CIG_D19 (KOD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIG_D19 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIG_D19         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIG_D19         to BARS_DM;
grant SELECT                                                                 on CIG_D19         to CIG_ROLE;



PROMPT *** Create SYNONYM  to CIG_D19 ***

  CREATE OR REPLACE PUBLIC SYNONYM CIG_D19 FOR BARS.CIG_D19;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIG_D19.sql =========*** End *** =====
PROMPT ===================================================================================== 
