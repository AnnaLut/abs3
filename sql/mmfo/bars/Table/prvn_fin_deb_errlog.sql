

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PRVN_FIN_DEB_ERRLOG.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PRVN_FIN_DEB_ERRLOG ***

BEGIN 
        execute immediate
          'begin  
               bpa.alter_policy_info(''PRVN_FIN_DEB_ERRLOG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PRVN_FIN_DEB_ERRLOG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PRVN_FIN_DEB_ERRLOG'', ''WHOLE''  , null, null, null, null);
               null;
           end; 
          ';
END;
/

PROMPT *** Create  table PRVN_FIN_DEB_ERRLOG ***
begin 
  execute immediate '
  CREATE TABLE BARS.PRVN_FIN_DEB_ERRLOG
   (ORA_ERR_NUMBER$ NUMBER,
    ORA_ERR_MESG$ VARCHAR2(2000),
    ORA_ERR_ROWID$ UROWID (4000),
    ORA_ERR_OPTYP$ VARCHAR2(2),
    ORA_ERR_TAG$ VARCHAR2(2000),
    ACC_SS VARCHAR2(4000),
    ACC_SP VARCHAR2(4000),
    EFFECTDATE VARCHAR2(4000),
    KF VARCHAR2(4000),
    AGRM_ID VARCHAR2(4000)
   ) SEGMENT CREATION IMMEDIATE
     NOCOMPRESS LOGGING
     TABLESPACE BRSDYND
PARTITION BY LIST (KF)
  (PARTITION "P_FINDEBERR_300465" VALUES (''300465'') TABLESPACE BRSDYND,
   PARTITION "P_FINDEBERR_324805" VALUES (''324805'') TABLESPACE BRSDYND,
   PARTITION "P_FINDEBERR_302076" VALUES (''302076'') TABLESPACE BRSDYND,
   PARTITION "P_FINDEBERR_303398" VALUES (''303398'') TABLESPACE BRSDYND,
   PARTITION "P_FINDEBERR_305482" VALUES (''305482'') TABLESPACE BRSDYND,
   PARTITION "P_FINDEBERR_335106" VALUES (''335106'') TABLESPACE BRSDYND,
   PARTITION "P_FINDEBERR_311647" VALUES (''311647'') TABLESPACE BRSDYND,
   PARTITION "P_FINDEBERR_312356" VALUES (''312356'') TABLESPACE BRSDYND,
   PARTITION "P_FINDEBERR_313957" VALUES (''313957'') TABLESPACE BRSDYND,
   PARTITION "P_FINDEBERR_336503" VALUES (''336503'') TABLESPACE BRSDYND,
   PARTITION "P_FINDEBERR_322669" VALUES (''322669'') TABLESPACE BRSDYND,
   PARTITION "P_FINDEBERR_323475" VALUES (''323475'') TABLESPACE BRSDYND,
   PARTITION "P_FINDEBERR_304665" VALUES (''304665'') TABLESPACE BRSDYND,
   PARTITION "P_FINDEBERR_325796" VALUES (''325796'') TABLESPACE BRSDYND,
   PARTITION "P_FINDEBERR_326461" VALUES (''326461'') TABLESPACE BRSDYND,
   PARTITION "P_FINDEBERR_328845" VALUES (''328845'') TABLESPACE BRSDYND,
   PARTITION "P_FINDEBERR_331467" VALUES (''331467'') TABLESPACE BRSDYND,
   PARTITION "P_FINDEBERR_333368" VALUES (''333368'') TABLESPACE BRSDYND,
   PARTITION "P_FINDEBERR_337568" VALUES (''337568'') TABLESPACE BRSDYND,
   PARTITION "P_FINDEBERR_338545" VALUES (''338545'') TABLESPACE BRSDYND,
   PARTITION "P_FINDEBERR_351823" VALUES (''351823'') TABLESPACE BRSDYND,
   PARTITION "P_FINDEBERR_352457" VALUES (''352457'') TABLESPACE BRSDYND,
   PARTITION "P_FINDEBERR_315784" VALUES (''315784'') TABLESPACE BRSDYND,
   PARTITION "P_FINDEBERR_354507" VALUES (''354507'') TABLESPACE BRSDYND,
   PARTITION "P_FINDEBERR_356334" VALUES (''356334'') TABLESPACE BRSDYND,
   PARTITION "P_FINDEBERR_353553" VALUES (''353553'') TABLESPACE BRSDYND
  )';
exception when others then       
  if sqlcode=-955 then null; else raise; end if;
end; 
/

PROMPT *** ALTER_POLICIES to PRVN_FIN_DEB_ERRLOG ***
 exec bpa.alter_policies('PRVN_FIN_DEB_ERRLOG');

COMMENT ON TABLE BARS.PRVN_FIN_DEB_ERRLOG IS 'DML Error Logging table for "PRVN_FIN_DEB"';
COMMENT ON COLUMN BARS.PRVN_FIN_DEB_ERRLOG.ORA_ERR_NUMBER$ IS '';
COMMENT ON COLUMN BARS.PRVN_FIN_DEB_ERRLOG.ORA_ERR_MESG$ IS '';
COMMENT ON COLUMN BARS.PRVN_FIN_DEB_ERRLOG.ORA_ERR_ROWID$ IS '';
COMMENT ON COLUMN BARS.PRVN_FIN_DEB_ERRLOG.ORA_ERR_OPTYP$ IS '';
COMMENT ON COLUMN BARS.PRVN_FIN_DEB_ERRLOG.ORA_ERR_TAG$ IS '';
COMMENT ON COLUMN BARS.PRVN_FIN_DEB_ERRLOG.ACC_SS IS '';
COMMENT ON COLUMN BARS.PRVN_FIN_DEB_ERRLOG.ACC_SP IS '';
COMMENT ON COLUMN BARS.PRVN_FIN_DEB_ERRLOG.EFFECTDATE IS '';
COMMENT ON COLUMN BARS.PRVN_FIN_DEB_ERRLOG.KF IS '';
COMMENT ON COLUMN BARS.PRVN_FIN_DEB_ERRLOG.AGRM_ID IS '';

PROMPT *** Create  index IDX_FINDEBERR_TAG ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_FINDEBERR_TAG ON BARS.PRVN_FIN_DEB_ERRLOG (ORA_ERR_TAG$) LOCAL
  COMPUTE STATISTICS TABLESPACE BRSDYNI COMPRESS 1';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  grants  PRVN_FIN_DEB_ERRLOG ***
grant SELECT                                                                 on PRVN_FIN_DEB_ERRLOG to BARSREADER_ROLE;
grant SELECT                                                                 on PRVN_FIN_DEB_ERRLOG to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PRVN_FIN_DEB_ERRLOG.sql =========*** E
PROMPT ===================================================================================== 