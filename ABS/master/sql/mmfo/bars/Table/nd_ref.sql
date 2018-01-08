

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ND_REF.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ND_REF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ND_REF'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ND_REF'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ND_REF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ND_REF ***
begin 
  execute immediate '
  CREATE TABLE BARS.ND_REF 
   (	ND NUMBER(38,0), 
	REF NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ND_REF ***
 exec bpa.alter_policies('ND_REF');


COMMENT ON TABLE BARS.ND_REF IS 'Связка договоров и references';
COMMENT ON COLUMN BARS.ND_REF.ND IS 'Номер договора';
COMMENT ON COLUMN BARS.ND_REF.REF IS 'Внутренний номер references';
COMMENT ON COLUMN BARS.ND_REF.KF IS '';




PROMPT *** Create  constraint PK_NDREF ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_REF ADD CONSTRAINT PK_NDREF PRIMARY KEY (ND, REF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NDREF_ND_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_REF MODIFY (ND CONSTRAINT CC_NDREF_ND_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NDREF_REF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_REF MODIFY (REF CONSTRAINT CC_NDREF_REF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NDREF_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_REF MODIFY (KF CONSTRAINT CC_NDREF_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NDREF ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NDREF ON BARS.ND_REF (ND, REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ND_REF ***
grant DELETE,INSERT,SELECT,UPDATE                                            on ND_REF          to ABS_ADMIN;
grant SELECT                                                                 on ND_REF          to BARSREADER_ROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on ND_REF          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ND_REF          to BARS_DM;
grant SELECT                                                                 on ND_REF          to CC_DOC;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on ND_REF          to RCC_DEAL;
grant SELECT                                                                 on ND_REF          to RPBN001;
grant SELECT                                                                 on ND_REF          to START1;
grant SELECT                                                                 on ND_REF          to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ND_REF          to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ND_REF.sql =========*** End *** ======
PROMPT ===================================================================================== 
