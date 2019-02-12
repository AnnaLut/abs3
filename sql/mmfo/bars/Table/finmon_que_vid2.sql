

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FINMON_QUE_VID2.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FINMON_QUE_VID2 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FINMON_QUE_VID2'', ''CENTER'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''FINMON_QUE_VID2'', ''FILIAL'' , ''M'', ''M'', ''M'', ''M'');
               bpa.alter_policy_info(''FINMON_QUE_VID2'', ''WHOLE'' , null, ''E'', ''E'', ''E'');
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FINMON_QUE_VID2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.FINMON_QUE_VID2 
   (	ID NUMBER, 
	VID VARCHAR2(4), 
	COMM VARCHAR2(254), 
	KF VARCHAR2(6) DEFAULT sys_context(''bars_context'',''user_mfo''),
    ORDER_ID number
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

prompt add order_id
begin
    execute immediate 'alter table finmon_que_vid2 add order_id number';    
exception
    when others then
        if sqlcode = -1430 then null; else raise; end if;
end;
/

PROMPT *** ALTER_POLICIES to FINMON_QUE_VID2 ***
 exec bpa.alter_policies('FINMON_QUE_VID2');


COMMENT ON TABLE BARS.FINMON_QUE_VID2 IS 'ФМ. Коды признаков операций подпадающих под мониторинг';
COMMENT ON COLUMN BARS.FINMON_QUE_VID2.ID IS 'ID документа';
COMMENT ON COLUMN BARS.FINMON_QUE_VID2.VID IS 'Код признака операции подпадающей под мониторинг';
COMMENT ON COLUMN BARS.FINMON_QUE_VID2.COMM IS 'Комментарий';
COMMENT ON COLUMN BARS.FINMON_QUE_VID2.KF IS '';
COMMENT ON COLUMN BARS.FINMON_QUE_VID2.order_id IS 'Порядок кодов / их значимость (asc)';




PROMPT *** Create  constraint XPK_FINMONQUEVID2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_QUE_VID2 ADD CONSTRAINT XPK_FINMONQUEVID2 PRIMARY KEY (ID, VID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_FINMONQUEVID2_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_QUE_VID2 MODIFY (ID CONSTRAINT NK_FINMONQUEVID2_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint NK_FINMONQUEVID2_VID ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_QUE_VID2 MODIFY (VID CONSTRAINT NK_FINMONQUEVID2_VID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FINMONQUEVID2_KF ***
begin   
 execute immediate '
  ALTER TABLE BARS.FINMON_QUE_VID2 MODIFY (KF CONSTRAINT CC_FINMONQUEVID2_KF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_FINMONQUEVID2 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_FINMONQUEVID2 ON BARS.FINMON_QUE_VID2 (ID, VID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FINMON_QUE_VID2 ***
grant SELECT                                                                 on FINMON_QUE_VID2 to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on FINMON_QUE_VID2 to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FINMON_QUE_VID2 to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INDEX,INSERT,ON COMMIT REFRESH,QUERY REWRITE,REFERENCES,SELECT,UPDATE on FINMON_QUE_VID2 to FINMON;
grant SELECT                                                                 on FINMON_QUE_VID2 to UPLD;



PROMPT *** Create SYNONYM  to FINMON_QUE_VID2 ***

  CREATE OR REPLACE PUBLIC SYNONYM FINMON_QUE_VID2 FOR BARS.FINMON_QUE_VID2;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FINMON_QUE_VID2.sql =========*** End *
PROMPT ===================================================================================== 
