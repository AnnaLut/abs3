

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KLP_INFO.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KLP_INFO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KLP_INFO'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''KLP_INFO'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''KLP_INFO'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KLP_INFO ***
begin 
  execute immediate '
  CREATE TABLE BARS.KLP_INFO 
   (	ID NUMBER(38,0), 
	SABI VARCHAR2(250), 
	PERIOD NUMBER(38,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KLP_INFO ***
 exec bpa.alter_policies('KLP_INFO');


COMMENT ON TABLE BARS.KLP_INFO IS '';
COMMENT ON COLUMN BARS.KLP_INFO.ID IS '';
COMMENT ON COLUMN BARS.KLP_INFO.SABI IS '';
COMMENT ON COLUMN BARS.KLP_INFO.PERIOD IS '';
COMMENT ON COLUMN BARS.KLP_INFO.KF IS '';




PROMPT *** Create  constraint KLP_INFO_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_INFO ADD CONSTRAINT KLP_INFO_PK PRIMARY KEY (ID, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008648 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_INFO MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008649 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KLP_INFO MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index KLP_INFO_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.KLP_INFO_PK ON BARS.KLP_INFO (ID, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KLP_INFO ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KLP_INFO        to ABS_ADMIN;
grant SELECT                                                                 on KLP_INFO        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KLP_INFO        to BARS_ACCESS_DEFROLE;
grant UPDATE                                                                 on KLP_INFO        to BARS_CONNECT;
grant SELECT                                                                 on KLP_INFO        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KLP_INFO        to START1;
grant DELETE,INSERT,UPDATE                                                   on KLP_INFO        to TECH_MOM1;
grant SELECT                                                                 on KLP_INFO        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KLP_INFO        to WR_ALL_RIGHTS;
grant FLASHBACK,SELECT                                                       on KLP_INFO        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KLP_INFO.sql =========*** End *** ====
PROMPT ===================================================================================== 
