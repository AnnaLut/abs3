

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_NBU.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_NBU ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_NBU'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_NBU'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''TMP_NBU'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_NBU ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_NBU 
   (	KODP VARCHAR2(35), 
	DATF DATE DEFAULT SYSDATE, 
	KODF CHAR(2), 
	ZNAP VARCHAR2(254), 
	NBUC VARCHAR2(30) DEFAULT ''0'', 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	ERR_MSG VARCHAR2(1000), 
	FL_MOD NUMBER DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_NBU ***
 exec bpa.alter_policies('TMP_NBU');


COMMENT ON TABLE BARS.TMP_NBU IS '';
COMMENT ON COLUMN BARS.TMP_NBU.KODP IS '';
COMMENT ON COLUMN BARS.TMP_NBU.DATF IS '';
COMMENT ON COLUMN BARS.TMP_NBU.KODF IS '';
COMMENT ON COLUMN BARS.TMP_NBU.ZNAP IS '';
COMMENT ON COLUMN BARS.TMP_NBU.NBUC IS '';
COMMENT ON COLUMN BARS.TMP_NBU.KF IS '';
COMMENT ON COLUMN BARS.TMP_NBU.ERR_MSG IS '';
COMMENT ON COLUMN BARS.TMP_NBU.FL_MOD IS '';




PROMPT *** Create  constraint NK_TMP_NBU_DATF ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_NBU MODIFY (DATF CONSTRAINT NK_TMP_NBU_DATF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_TMP_NBU_KODP ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_NBU MODIFY (KODP CONSTRAINT NK_TMP_NBU_KODP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_TMP_NBU_KODF ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_NBU MODIFY (KODF CONSTRAINT NK_TMP_NBU_KODF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMP_NBU_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_NBU MODIFY (KF CONSTRAINT CC_TMP_NBU_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_TMP_NBU ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_NBU ADD CONSTRAINT XPK_TMP_NBU PRIMARY KEY (KF, KODP, DATF, KODF, NBUC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_TMP_NBU ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_TMP_NBU ON BARS.TMP_NBU (DATF, KODF, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_TMP_NBU ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_TMP_NBU ON BARS.TMP_NBU (KF, KODP, DATF, KODF, NBUC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_NBU ***
grant SELECT                                                                 on TMP_NBU         to BARSREADER_ROLE;
grant SELECT                                                                 on TMP_NBU         to BARSUPL;
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on TMP_NBU         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_NBU         to BARS_DM;
grant SELECT                                                                 on TMP_NBU         to RPBN001;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_NBU         to RPBN002;
grant ALTER,DEBUG,DELETE,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on TMP_NBU         to SALGL;
grant SELECT                                                                 on TMP_NBU         to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_NBU         to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to TMP_NBU ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_NBU FOR BARS.TMP_NBU;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_NBU.sql =========*** End *** =====
PROMPT ===================================================================================== 
