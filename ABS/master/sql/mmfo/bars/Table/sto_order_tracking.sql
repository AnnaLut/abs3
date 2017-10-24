

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STO_ORDER_TRACKING.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STO_ORDER_TRACKING ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STO_ORDER_TRACKING'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STO_ORDER_TRACKING'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STO_ORDER_TRACKING ***
begin 
  execute immediate '
  CREATE TABLE BARS.STO_ORDER_TRACKING 
   (	ID NUMBER(10,0), 
	ORDER_ID NUMBER(10,0), 
	USER_ID NUMBER(10,0), 
	COMMENT_TEXT VARCHAR2(4000), 
	SYS_TIME DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STO_ORDER_TRACKING ***
 exec bpa.alter_policies('STO_ORDER_TRACKING');


COMMENT ON TABLE BARS.STO_ORDER_TRACKING IS '';
COMMENT ON COLUMN BARS.STO_ORDER_TRACKING.ID IS '';
COMMENT ON COLUMN BARS.STO_ORDER_TRACKING.ORDER_ID IS '';
COMMENT ON COLUMN BARS.STO_ORDER_TRACKING.USER_ID IS '';
COMMENT ON COLUMN BARS.STO_ORDER_TRACKING.COMMENT_TEXT IS '';
COMMENT ON COLUMN BARS.STO_ORDER_TRACKING.SYS_TIME IS '';




PROMPT *** Create  constraint FK_STO_ORDER_TRACKING_ORDER_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_ORDER_TRACKING ADD CONSTRAINT FK_STO_ORDER_TRACKING_ORDER_ID FOREIGN KEY (ORDER_ID)
	  REFERENCES BARS.STO_ORDER (ID) ENABLE NOVALIDATE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint FK_STO_ORDER_TRACKING_USER_ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_ORDER_TRACKING ADD CONSTRAINT FK_STO_ORDER_TRACKING_USER_ID FOREIGN KEY (USER_ID)
	  REFERENCES BARS.STAFF$BASE (ID) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010048 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_ORDER_TRACKING MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010049 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_ORDER_TRACKING MODIFY (ORDER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010050 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_ORDER_TRACKING MODIFY (USER_ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C0010051 ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_ORDER_TRACKING MODIFY (SYS_TIME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_STO_ORDER_TRACKING ***
begin   
 execute immediate '
  ALTER TABLE BARS.STO_ORDER_TRACKING ADD CONSTRAINT PK_STO_ORDER_TRACKING PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index I_STO_ORDER_TRACK_ORDER ***
begin   
 execute immediate '
  CREATE INDEX BARS.I_STO_ORDER_TRACK_ORDER ON BARS.STO_ORDER_TRACKING (ORDER_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_STO_ORDER_TRACKING ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_STO_ORDER_TRACKING ON BARS.STO_ORDER_TRACKING (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  STO_ORDER_TRACKING ***
grant SELECT                                                                 on STO_ORDER_TRACKING to BARSUPL;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on STO_ORDER_TRACKING to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on STO_ORDER_TRACKING to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STO_ORDER_TRACKING.sql =========*** En
PROMPT ===================================================================================== 
