

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REC_QUE.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REC_QUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REC_QUE'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''REC_QUE'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''REC_QUE'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REC_QUE ***
begin 
  execute immediate q'[
  CREATE TABLE BARS.REC_QUE 
   (	REC NUMBER(38,0), 
	REC_G NUMBER(38,0), 
	OTM NUMBER(1,0), 
	KF VARCHAR2(6) DEFAULT sys_context('bars_context','user_mfo'), 
	FMCHECK NUMBER(38,0) DEFAULT 0, 
	 CONSTRAINT XPK_REC_QUE PRIMARY KEY (KF, REC) ENABLE
   ) ORGANIZATION INDEX 
   PARTITION BY LIST (KF)
( PARTITION KF_300465 VALUES ('300465')
, PARTITION KF_302076 VALUES ('302076')
, PARTITION KF_303398 VALUES ('303398')
, PARTITION KF_304665 VALUES ('304665')
, PARTITION KF_305482 VALUES ('305482')
, PARTITION KF_311647 VALUES ('311647')
, PARTITION KF_312356 VALUES ('312356')
, PARTITION KF_313957 VALUES ('313957')
, PARTITION KF_315784 VALUES ('315784')
, PARTITION KF_322669 VALUES ('322669')
, PARTITION KF_323475 VALUES ('323475')
, PARTITION KF_324805 VALUES ('324805')
, PARTITION KF_325796 VALUES ('325796')
, PARTITION KF_326461 VALUES ('326461')
, PARTITION KF_328845 VALUES ('328845')
, PARTITION KF_331467 VALUES ('331467')
, PARTITION KF_333368 VALUES ('333368')
, PARTITION KF_335106 VALUES ('335106')
, PARTITION KF_336503 VALUES ('336503')
, PARTITION KF_337568 VALUES ('337568')
, PARTITION KF_338545 VALUES ('338545')
, PARTITION KF_351823 VALUES ('351823')
, PARTITION KF_352457 VALUES ('352457')
, PARTITION KF_353553 VALUES ('353553')
, PARTITION KF_354507 VALUES ('354507')
, PARTITION KF_356334 VALUES ('356334')
)
tablespace brsdyni pctfree 30]';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REC_QUE ***
 exec bpa.alter_policies('REC_QUE');


COMMENT ON TABLE BARS.REC_QUE IS '';
COMMENT ON COLUMN BARS.REC_QUE.REC IS '';
COMMENT ON COLUMN BARS.REC_QUE.REC_G IS '';
COMMENT ON COLUMN BARS.REC_QUE.OTM IS '';
COMMENT ON COLUMN BARS.REC_QUE.KF IS '';
COMMENT ON COLUMN BARS.REC_QUE.FMCHECK IS '1-проверено фин.мониторингом';




PROMPT *** Create  constraint CC_REC_QUE_REC ***
begin   
 execute immediate '
  ALTER TABLE BARS.REC_QUE MODIFY (REC CONSTRAINT CC_REC_QUE_REC NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_RECQUE_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.REC_QUE MODIFY (KF CONSTRAINT CC_RECQUE_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/


PROMPT *** Create  index XIE_REC_QUE_REC_G ***
begin   
 execute immediate '
  CREATE INDEX BARS.XIE_REC_QUE_REC_G ON BARS.REC_QUE (REC_G) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REC_QUE ***
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on REC_QUE         to BARS014;
grant SELECT                                                                 on REC_QUE         to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on REC_QUE         to BARS_ACCESS_DEFROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REC_QUE         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REC_QUE.sql =========*** End *** =====
PROMPT ===================================================================================== 
