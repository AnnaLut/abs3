

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CRNV_QUE.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CRNV_QUE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CRNV_QUE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CRNV_QUE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CRNV_QUE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CRNV_QUE ***
begin 
  execute immediate '
  CREATE TABLE BARS.CRNV_QUE 
   (	KEY NUMBER, 
	USERID NUMBER, 
	SEND_TIME DATE, 
	BATCH_ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CRNV_QUE ***
 exec bpa.alter_policies('CRNV_QUE');


COMMENT ON TABLE BARS.CRNV_QUE IS '';
COMMENT ON COLUMN BARS.CRNV_QUE.KEY IS '';
COMMENT ON COLUMN BARS.CRNV_QUE.USERID IS '';
COMMENT ON COLUMN BARS.CRNV_QUE.SEND_TIME IS '';
COMMENT ON COLUMN BARS.CRNV_QUE.BATCH_ID IS '';




PROMPT *** Create  constraint PK_CRNV_QUE ***
begin   
 execute immediate '
  ALTER TABLE BARS.CRNV_QUE ADD CONSTRAINT PK_CRNV_QUE PRIMARY KEY (KEY)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CRNV_QUE_KEY_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CRNV_QUE MODIFY (KEY CONSTRAINT CC_CRNV_QUE_KEY_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CRNV_QUE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CRNV_QUE ON BARS.CRNV_QUE (KEY) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CRNV_QUE ***
grant SELECT                                                                 on CRNV_QUE        to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CRNV_QUE.sql =========*** End *** ====
PROMPT ===================================================================================== 
