

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TARIF_HISTORY.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TARIF_HISTORY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TARIF_HISTORY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TARIF_HISTORY'', ''FILIAL'' , ''M'', ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''TARIF_HISTORY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TARIF_HISTORY ***
begin 
  execute immediate '
  CREATE TABLE BARS.TARIF_HISTORY 
   (	IDS NUMBER, 
	KOD NUMBER(22,0), 
	TAR NUMBER(22,0), 
	PR NUMBER(20,4), 
	SMIN NUMBER(22,0), 
	SMAX NUMBER(22,0), 
	NBS_OB22 CHAR(6), 
	DAT_OPEN DATE, 
	FL NUMBER(*,0) DEFAULT 0, 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TARIF_HISTORY ***
 exec bpa.alter_policies('TARIF_HISTORY');


COMMENT ON TABLE BARS.TARIF_HISTORY IS '';
COMMENT ON COLUMN BARS.TARIF_HISTORY.IDS IS '';
COMMENT ON COLUMN BARS.TARIF_HISTORY.KOD IS '';
COMMENT ON COLUMN BARS.TARIF_HISTORY.TAR IS '';
COMMENT ON COLUMN BARS.TARIF_HISTORY.PR IS '';
COMMENT ON COLUMN BARS.TARIF_HISTORY.SMIN IS '';
COMMENT ON COLUMN BARS.TARIF_HISTORY.SMAX IS '';
COMMENT ON COLUMN BARS.TARIF_HISTORY.NBS_OB22 IS '';
COMMENT ON COLUMN BARS.TARIF_HISTORY.DAT_OPEN IS '';
COMMENT ON COLUMN BARS.TARIF_HISTORY.FL IS '';
COMMENT ON COLUMN BARS.TARIF_HISTORY.KF IS '';




PROMPT *** Create  constraint PK_TARIF_HISTORY ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_HISTORY ADD CONSTRAINT PK_TARIF_HISTORY PRIMARY KEY (IDS, KOD, DAT_OPEN, KF)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_TARIFHISTORY_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_HISTORY ADD CONSTRAINT FK_TARIFHISTORY_KF FOREIGN KEY (KF)
	  REFERENCES BARS.BANKS$BASE (MFO) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005565 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_HISTORY MODIFY (IDS NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005566 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_HISTORY MODIFY (KOD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005567 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_HISTORY MODIFY (TAR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005568 ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_HISTORY MODIFY (PR NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_TARIFHISTORY_KF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.TARIF_HISTORY MODIFY (KF CONSTRAINT CC_TARIFHISTORY_KF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TARIF_HISTORY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TARIF_HISTORY ON BARS.TARIF_HISTORY (IDS, KOD, DAT_OPEN, KF) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TARIF_HISTORY ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TARIF_HISTORY   to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TARIF_HISTORY   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TARIF_HISTORY   to BARS_DM;
grant SELECT                                                                 on TARIF_HISTORY   to START1;
grant FLASHBACK,SELECT                                                       on TARIF_HISTORY   to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TARIF_HISTORY.sql =========*** End ***
PROMPT ===================================================================================== 
