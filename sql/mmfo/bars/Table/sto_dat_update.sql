

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STO_DAT_UPDATE.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STO_DAT_UPDATE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STO_DAT_UPDATE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''STO_DAT_UPDATE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STO_DAT_UPDATE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STO_DAT_UPDATE ***
begin 
  execute immediate '
  CREATE TABLE BARS.STO_DAT_UPDATE 
   (	IDD NUMBER(*,0), 
	DAT DATE, 
	REF NUMBER(38,0), 
	KF VARCHAR2(6), 
	ACTION NUMBER(1,0), 
	IDUPD NUMBER, 
	WHEN TIMESTAMP (6), 
	USERID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STO_DAT_UPDATE ***
 exec bpa.alter_policies('STO_DAT_UPDATE');


COMMENT ON TABLE BARS.STO_DAT_UPDATE IS '';
COMMENT ON COLUMN BARS.STO_DAT_UPDATE.IDD IS '';
COMMENT ON COLUMN BARS.STO_DAT_UPDATE.DAT IS '';
COMMENT ON COLUMN BARS.STO_DAT_UPDATE.REF IS 'Референс документу';
COMMENT ON COLUMN BARS.STO_DAT_UPDATE.KF IS '';
COMMENT ON COLUMN BARS.STO_DAT_UPDATE.ACTION IS '';
COMMENT ON COLUMN BARS.STO_DAT_UPDATE.IDUPD IS '';
COMMENT ON COLUMN BARS.STO_DAT_UPDATE.WHEN IS '';
COMMENT ON COLUMN BARS.STO_DAT_UPDATE.USERID IS '';




PROMPT *** Create  constraint SYS_C006954 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DAT_UPDATE MODIFY (IDD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006955 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DAT_UPDATE MODIFY (DAT NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006956 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_DAT_UPDATE MODIFY (KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_STODATW ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_STODATW ON BARS.STO_DAT_UPDATE (KF, REF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STO_DAT_UPDATE ***
grant SELECT                                                                 on STO_DAT_UPDATE  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on STO_DAT_UPDATE  to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STO_DAT_UPDATE  to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on STO_DAT_UPDATE  to STO;
grant SELECT                                                                 on STO_DAT_UPDATE  to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on STO_DAT_UPDATE  to WR_ALL_RIGHTS;
grant SELECT                                                                 on STO_DAT_UPDATE  to WR_CHCKINNR_ALL;
grant SELECT                                                                 on STO_DAT_UPDATE  to WR_CHCKINNR_SELF;
grant SELECT                                                                 on STO_DAT_UPDATE  to WR_CHCKINNR_TOBO;
grant SELECT                                                                 on STO_DAT_UPDATE  to WR_DOCLIST_SALDO;
grant SELECT                                                                 on STO_DAT_UPDATE  to WR_DOCLIST_TOBO;
grant SELECT                                                                 on STO_DAT_UPDATE  to WR_DOCLIST_USER;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STO_DAT_UPDATE.sql =========*** End **
PROMPT ===================================================================================== 
