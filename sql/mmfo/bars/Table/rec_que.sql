

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
  execute immediate '
  CREATE TABLE BARS.REC_QUE 
   (	REC NUMBER(38,0), 
	REC_G NUMBER(38,0), 
	OTM NUMBER(1,0), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	FMCHECK NUMBER(38,0) DEFAULT 0, 
	 CONSTRAINT XPK_REC_QUE PRIMARY KEY (REC) ENABLE
   ) ORGANIZATION INDEX NOCOMPRESS PCTFREE 10 INITRANS 2 MAXTRANS 255 LOGGING
  TABLESPACE BRSDYNI 
 PCTTHRESHOLD 50';
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




PROMPT *** Create  constraint XPK_REC_QUE ***
begin   
 execute immediate '
  ALTER TABLE BARS.REC_QUE ADD CONSTRAINT XPK_REC_QUE PRIMARY KEY (REC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_REC_QUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_REC_QUE ON BARS.REC_QUE (REC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
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
