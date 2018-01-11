

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_IREP.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_IREP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_IREP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_IREP'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''TMP_IREP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_IREP ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_IREP 
   (	KODP VARCHAR2(35), 
	DATF DATE DEFAULT SYSDATE, 
	KODF CHAR(2), 
	ZNAP VARCHAR2(70), 
	NBUC VARCHAR2(20) DEFAULT ''0'', 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''), 
	ERR_MSG VARCHAR2(1000), 
	FL_MOD NUMBER DEFAULT 0
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_IREP ***
 exec bpa.alter_policies('TMP_IREP');


COMMENT ON TABLE BARS.TMP_IREP IS '';
COMMENT ON COLUMN BARS.TMP_IREP.KODP IS '';
COMMENT ON COLUMN BARS.TMP_IREP.DATF IS '';
COMMENT ON COLUMN BARS.TMP_IREP.KODF IS '';
COMMENT ON COLUMN BARS.TMP_IREP.ZNAP IS '';
COMMENT ON COLUMN BARS.TMP_IREP.NBUC IS '';
COMMENT ON COLUMN BARS.TMP_IREP.KF IS '';
COMMENT ON COLUMN BARS.TMP_IREP.ERR_MSG IS '';
COMMENT ON COLUMN BARS.TMP_IREP.FL_MOD IS '';




PROMPT *** Create  constraint XPK_TMP_IREP ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_IREP ADD CONSTRAINT XPK_TMP_IREP PRIMARY KEY (KF, KODP, DATF, KODF, NBUC)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_TMP_IREP_KODP ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_IREP MODIFY (KODP CONSTRAINT NK_TMP_IREP_KODP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_TMP_IREP_DATF ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_IREP MODIFY (DATF CONSTRAINT NK_TMP_IREP_DATF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_TMP_IREP_KODF ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_IREP MODIFY (KODF CONSTRAINT NK_TMP_IREP_KODF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TMPIREP_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_IREP MODIFY (KF CONSTRAINT CC_TMPIREP_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_TMP_IREP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_TMP_IREP ON BARS.TMP_IREP (KF, KODP, DATF, KODF, NBUC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_IREP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_IREP        to ABS_ADMIN;
grant SELECT                                                                 on TMP_IREP        to BARSREADER_ROLE;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on TMP_IREP        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_IREP        to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on TMP_IREP        to RPBN002;
grant SELECT                                                                 on TMP_IREP        to START1;
grant SELECT                                                                 on TMP_IREP        to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_IREP        to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to TMP_IREP ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_IREP FOR BARS.TMP_IREP;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_IREP.sql =========*** End *** ====
PROMPT ===================================================================================== 
