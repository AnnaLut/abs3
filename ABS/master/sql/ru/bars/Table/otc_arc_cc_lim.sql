

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTC_ARC_CC_LIM.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTC_ARC_CC_LIM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTC_ARC_CC_LIM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTC_ARC_CC_LIM ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTC_ARC_CC_LIM 
   (	DAT_OTC DATE, 
	ND NUMBER(10,0), 
	FDAT DATE, 
	LIM2 NUMBER(38,0), 
	ACC NUMBER(*,0), 
	SUMG NUMBER(38,0), 
	SUMO NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTC_ARC_CC_LIM ***
 exec bpa.alter_policies('OTC_ARC_CC_LIM');


COMMENT ON TABLE BARS.OTC_ARC_CC_LIM IS '';
COMMENT ON COLUMN BARS.OTC_ARC_CC_LIM.DAT_OTC IS '';
COMMENT ON COLUMN BARS.OTC_ARC_CC_LIM.ND IS '';
COMMENT ON COLUMN BARS.OTC_ARC_CC_LIM.FDAT IS '';
COMMENT ON COLUMN BARS.OTC_ARC_CC_LIM.LIM2 IS '';
COMMENT ON COLUMN BARS.OTC_ARC_CC_LIM.ACC IS '';
COMMENT ON COLUMN BARS.OTC_ARC_CC_LIM.SUMG IS '';
COMMENT ON COLUMN BARS.OTC_ARC_CC_LIM.SUMO IS '';




PROMPT *** Create  constraint PK_OTC_ARC_CC_LIM ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTC_ARC_CC_LIM ADD CONSTRAINT PK_OTC_ARC_CC_LIM PRIMARY KEY (DAT_OTC, ND, FDAT)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OTC_ARC_CC_LIM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OTC_ARC_CC_LIM ON BARS.OTC_ARC_CC_LIM (DAT_OTC, ND, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTC_ARC_CC_LIM.sql =========*** End **
PROMPT ===================================================================================== 
