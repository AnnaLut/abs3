

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FINMON_QUE_VID3.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FINMON_QUE_VID3 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FINMON_QUE_VID3'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''FINMON_QUE_VID3'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''FINMON_QUE_VID3'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FINMON_QUE_VID3 ***
begin 
  execute immediate '
  CREATE TABLE BARS.FINMON_QUE_VID3 
   (	ID NUMBER(22,0), 
	VID VARCHAR2(3), 
	COMM VARCHAR2(254), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FINMON_QUE_VID3 ***
 exec bpa.alter_policies('FINMON_QUE_VID3');


COMMENT ON TABLE BARS.FINMON_QUE_VID3 IS 'ФМ. Коды признаков операций по внутрн. мониторингу';
COMMENT ON COLUMN BARS.FINMON_QUE_VID3.ID IS 'ID документа';
COMMENT ON COLUMN BARS.FINMON_QUE_VID3.VID IS 'Код признака оперции по внутрн. мониторингу';
COMMENT ON COLUMN BARS.FINMON_QUE_VID3.COMM IS 'Комментарий';
COMMENT ON COLUMN BARS.FINMON_QUE_VID3.KF IS '';




PROMPT *** Create  constraint XPK_FINMONQUEVID3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_QUE_VID3 ADD CONSTRAINT XPK_FINMONQUEVID3 PRIMARY KEY (ID, VID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_FINMONQUEVID3_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_QUE_VID3 MODIFY (ID CONSTRAINT NK_FINMONQUEVID3_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_FINMONQUEVID3_VID ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_QUE_VID3 MODIFY (VID CONSTRAINT NK_FINMONQUEVID3_VID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FINMONQUEVID3_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_QUE_VID3 MODIFY (KF CONSTRAINT CC_FINMONQUEVID3_KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FINMONQUEVID3 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FINMONQUEVID3 ON BARS.FINMON_QUE_VID3 (ID, VID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FINMON_QUE_VID3 ***
grant SELECT                                                                 on FINMON_QUE_VID3 to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on FINMON_QUE_VID3 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FINMON_QUE_VID3 to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on FINMON_QUE_VID3 to FINMON;
grant SELECT                                                                 on FINMON_QUE_VID3 to UPLD;



PROMPT *** Create SYNONYM  to FINMON_QUE_VID3 ***

  CREATE OR REPLACE PUBLIC SYNONYM FINMON_QUE_VID3 FOR BARS.FINMON_QUE_VID3;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FINMON_QUE_VID3.sql =========*** End *
PROMPT ===================================================================================== 
