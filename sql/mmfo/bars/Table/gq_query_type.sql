

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GQ_QUERY_TYPE.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GQ_QUERY_TYPE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GQ_QUERY_TYPE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''GQ_QUERY_TYPE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''GQ_QUERY_TYPE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GQ_QUERY_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS.GQ_QUERY_TYPE 
   (	QUERYTYPE_ID NUMBER(38,0), 
	QUERYTYPE_NAME VARCHAR2(100), 
	QUERYTYPE_STATUS NUMBER(1,0) DEFAULT 1, 
	QUERYTYPE_PROC VARCHAR2(60)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GQ_QUERY_TYPE ***
 exec bpa.alter_policies('GQ_QUERY_TYPE');


COMMENT ON TABLE BARS.GQ_QUERY_TYPE IS '';
COMMENT ON COLUMN BARS.GQ_QUERY_TYPE.QUERYTYPE_ID IS '';
COMMENT ON COLUMN BARS.GQ_QUERY_TYPE.QUERYTYPE_NAME IS '';
COMMENT ON COLUMN BARS.GQ_QUERY_TYPE.QUERYTYPE_STATUS IS '';
COMMENT ON COLUMN BARS.GQ_QUERY_TYPE.QUERYTYPE_PROC IS '';




PROMPT *** Create  constraint CC_GQQUERYTYPE_QTYPEID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GQ_QUERY_TYPE MODIFY (QUERYTYPE_ID CONSTRAINT CC_GQQUERYTYPE_QTYPEID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GQQUERYTYPE_QTYPENAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GQ_QUERY_TYPE MODIFY (QUERYTYPE_NAME CONSTRAINT CC_GQQUERYTYPE_QTYPENAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GQQUERYTYPE_QTYPESTATUS_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GQ_QUERY_TYPE MODIFY (QUERYTYPE_STATUS CONSTRAINT CC_GQQUERYTYPE_QTYPESTATUS_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GQQUERYTYPE_QTYPEPROC_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GQ_QUERY_TYPE MODIFY (QUERYTYPE_PROC CONSTRAINT CC_GQQUERYTYPE_QTYPEPROC_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  GQ_QUERY_TYPE ***
grant SELECT                                                                 on GQ_QUERY_TYPE   to BARS_DM;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on GQ_QUERY_TYPE   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GQ_QUERY_TYPE.sql =========*** End ***
PROMPT ===================================================================================== 
