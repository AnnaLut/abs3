

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ZAY_TRACK_RU.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ZAY_TRACK_RU ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ZAY_TRACK_RU'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''ZAY_TRACK_RU'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ZAY_TRACK_RU'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ZAY_TRACK_RU ***
begin 
  execute immediate '
  CREATE TABLE BARS.ZAY_TRACK_RU 
   (	MFO VARCHAR2(6), 
	TRACK_ID NUMBER(*,0), 
	REQ_ID NUMBER(*,0), 
	CHANGE_TIME DATE, 
	FIO VARCHAR2(60), 
	SOS NUMBER, 
	VIZA NUMBER, 
	VIZA_NAME VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ZAY_TRACK_RU ***
 exec bpa.alter_policies('ZAY_TRACK_RU');


COMMENT ON TABLE BARS.ZAY_TRACK_RU IS '';
COMMENT ON COLUMN BARS.ZAY_TRACK_RU.MFO IS '';
COMMENT ON COLUMN BARS.ZAY_TRACK_RU.TRACK_ID IS '';
COMMENT ON COLUMN BARS.ZAY_TRACK_RU.REQ_ID IS '';
COMMENT ON COLUMN BARS.ZAY_TRACK_RU.CHANGE_TIME IS '';
COMMENT ON COLUMN BARS.ZAY_TRACK_RU.FIO IS '';
COMMENT ON COLUMN BARS.ZAY_TRACK_RU.SOS IS '';
COMMENT ON COLUMN BARS.ZAY_TRACK_RU.VIZA IS '';
COMMENT ON COLUMN BARS.ZAY_TRACK_RU.VIZA_NAME IS '';




PROMPT *** Create  constraint PK_ZAYTRACKRU ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_TRACK_RU ADD CONSTRAINT PK_ZAYTRACKRU PRIMARY KEY (MFO, TRACK_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD  ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYTRACKRU_MFO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_TRACK_RU MODIFY (MFO CONSTRAINT CC_ZAYTRACKRU_MFO_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYTRACKRU_TRACKID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_TRACK_RU MODIFY (TRACK_ID CONSTRAINT CC_ZAYTRACKRU_TRACKID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYTRACKRU_REQID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_TRACK_RU MODIFY (REQ_ID CONSTRAINT CC_ZAYTRACKRU_REQID_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYTRACKRU_CHTIME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_TRACK_RU MODIFY (CHANGE_TIME CONSTRAINT CC_ZAYTRACKRU_CHTIME_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYTRACKRU_FIO_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_TRACK_RU MODIFY (FIO CONSTRAINT CC_ZAYTRACKRU_FIO_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYTRACKRU_SOS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_TRACK_RU MODIFY (SOS CONSTRAINT CC_ZAYTRACKRU_SOS_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_ZAYTRACKRU_VIZA_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.ZAY_TRACK_RU MODIFY (VIZA CONSTRAINT CC_ZAYTRACKRU_VIZA_NN NOT NULL ENABLE NOVALIDATE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ZAYTRACKRU ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ZAYTRACKRU ON BARS.ZAY_TRACK_RU (MFO, TRACK_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ZAY_TRACK_RU ***
grant SELECT                                                                 on ZAY_TRACK_RU    to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAY_TRACK_RU    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ZAY_TRACK_RU    to BARS_DM;
grant SELECT                                                                 on ZAY_TRACK_RU    to UPLD;
grant DELETE,INSERT,SELECT,UPDATE                                            on ZAY_TRACK_RU    to ZAY;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ZAY_TRACK_RU.sql =========*** End *** 
PROMPT ===================================================================================== 
