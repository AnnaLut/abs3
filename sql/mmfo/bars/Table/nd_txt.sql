

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ND_TXT.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ND_TXT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ND_TXT'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ND_TXT'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''ND_TXT'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ND_TXT ***
begin 
  execute immediate '
  CREATE TABLE BARS.ND_TXT 
   (	ND NUMBER(*,0), 
	TAG VARCHAR2(8), 
	TXT VARCHAR2(4000), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ND_TXT ***
 exec bpa.alter_policies('ND_TXT');


COMMENT ON TABLE BARS.ND_TXT IS '';
COMMENT ON COLUMN BARS.ND_TXT.ND IS '';
COMMENT ON COLUMN BARS.ND_TXT.TAG IS '';
COMMENT ON COLUMN BARS.ND_TXT.TXT IS '';
COMMENT ON COLUMN BARS.ND_TXT.KF IS '';




PROMPT *** Create  constraint PK_NDTXT ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_TXT ADD CONSTRAINT PK_NDTXT PRIMARY KEY (ND, TAG, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_ND_TXT_ND ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_TXT MODIFY (ND CONSTRAINT NK_ND_TXT_ND NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_ND_TXT_TAG ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_TXT MODIFY (TAG CONSTRAINT NK_ND_TXT_TAG NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_NDTXT_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ND_TXT MODIFY (KF CONSTRAINT CC_NDTXT_KF_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_NDTXT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_NDTXT ON BARS.ND_TXT (ND, TAG, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ND_TXT ***
grant SELECT                                                                 on ND_TXT          to BARSREADER_ROLE;
grant SELECT                                                                 on ND_TXT          to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on ND_TXT          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ND_TXT          to BARS_DM;
grant SELECT                                                                 on ND_TXT          to DEP_SKRN;
grant DELETE,INSERT,SELECT,UPDATE                                            on ND_TXT          to RCC_DEAL;
grant SELECT                                                                 on ND_TXT          to UPLD;
grant SELECT                                                                 on ND_TXT          to WCS_SYNC_USER;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on ND_TXT          to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to ND_TXT ***

  CREATE OR REPLACE PUBLIC SYNONYM ND_TXT FOR BARS.ND_TXT;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ND_TXT.sql =========*** End *** ======
PROMPT ===================================================================================== 
