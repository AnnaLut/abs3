

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STO_DAT.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STO_DAT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STO_DAT'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''STO_DAT'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''STO_DAT'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STO_DAT ***
begin 
  execute immediate '
  CREATE TABLE BARS.STO_DAT 
   (	IDD NUMBER(*,0), 
	DAT DATE, 
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




PROMPT *** ALTER_POLICIES to STO_DAT ***
 exec bpa.alter_policies('STO_DAT');


COMMENT ON TABLE BARS.STO_DAT IS '';
COMMENT ON COLUMN BARS.STO_DAT.IDD IS '';
COMMENT ON COLUMN BARS.STO_DAT.DAT IS '';
COMMENT ON COLUMN BARS.STO_DAT.REF IS 'Референс документу';
COMMENT ON COLUMN BARS.STO_DAT.KF IS '';




PROMPT *** Create  constraint PK_STODAT ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DAT ADD CONSTRAINT PK_STODAT PRIMARY KEY (IDD, DAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STODAT_IDD_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DAT MODIFY (IDD CONSTRAINT CC_STODAT_IDD_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STODAT_DAT_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DAT MODIFY (DAT CONSTRAINT CC_STODAT_DAT_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_STODAT_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DAT MODIFY (KF CONSTRAINT CC_STODAT_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_STODAT ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_STODAT ON BARS.STO_DAT (KF, REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STODAT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STODAT ON BARS.STO_DAT (IDD, DAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STO_DAT ***
grant SELECT                                                                 on STO_DAT         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on STO_DAT         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STO_DAT         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on STO_DAT         to STO;
grant SELECT                                                                 on STO_DAT         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STO_DAT         to WR_ALL_RIGHTS;
grant SELECT                                                                 on STO_DAT         to WR_CHCKINNR_ALL;
grant SELECT                                                                 on STO_DAT         to WR_CHCKINNR_SELF;
grant SELECT                                                                 on STO_DAT         to WR_CHCKINNR_TOBO;
grant SELECT                                                                 on STO_DAT         to WR_DOCLIST_SALDO;
grant SELECT                                                                 on STO_DAT         to WR_DOCLIST_TOBO;
grant SELECT                                                                 on STO_DAT         to WR_DOCLIST_USER;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STO_DAT.sql =========*** End *** =====
PROMPT ===================================================================================== 
