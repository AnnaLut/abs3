

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIG_D08.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIG_D08 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIG_D08'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIG_D08'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CIG_D08'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIG_D08 ***
begin 
  execute immediate '
  CREATE TABLE BARS.CIG_D08 
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




PROMPT *** ALTER_POLICIES to CIG_D08 ***
 exec bpa.alter_policies('CIG_D08');


COMMENT ON TABLE BARS.CIG_D08 IS 'D08 - Сімейне положення';
COMMENT ON COLUMN BARS.CIG_D08.ID IS '';
COMMENT ON COLUMN BARS.CIG_D08.KOD IS '';
COMMENT ON COLUMN BARS.CIG_D08.TXT IS '';




PROMPT *** Create  constraint PK_CIG_D08 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_D08 ADD CONSTRAINT PK_CIG_D08 PRIMARY KEY (KOD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_CIG_D08_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.CIG_D08 ADD CONSTRAINT UK_CIG_D08_ID UNIQUE (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_CIG_D08_ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_CIG_D08_ID ON BARS.CIG_D08 (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CIG_D08 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CIG_D08 ON BARS.CIG_D08 (KOD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CIG_D08 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIG_D08         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIG_D08         to BARS_DM;
grant SELECT                                                                 on CIG_D08         to CIG_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIG_D08.sql =========*** End *** =====
PROMPT ===================================================================================== 
