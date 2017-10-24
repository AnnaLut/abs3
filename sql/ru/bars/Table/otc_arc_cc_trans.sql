

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTC_ARC_CC_TRANS.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTC_ARC_CC_TRANS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTC_ARC_CC_TRANS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTC_ARC_CC_TRANS ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTC_ARC_CC_TRANS 
   (	DAT_OTC DATE, 
	NPP NUMBER(*,0), 
	REF NUMBER(*,0), 
	ACC NUMBER(*,0), 
	FDAT DATE, 
	SV NUMBER, 
	SZ NUMBER, 
	D_PLAN DATE, 
	D_FAKT DATE, 
	DAPP DATE, 
	REFP NUMBER(*,0), 
	COMM VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTC_ARC_CC_TRANS ***
 exec bpa.alter_policies('OTC_ARC_CC_TRANS');


COMMENT ON TABLE BARS.OTC_ARC_CC_TRANS IS '';
COMMENT ON COLUMN BARS.OTC_ARC_CC_TRANS.DAT_OTC IS '';
COMMENT ON COLUMN BARS.OTC_ARC_CC_TRANS.NPP IS '';
COMMENT ON COLUMN BARS.OTC_ARC_CC_TRANS.REF IS '';
COMMENT ON COLUMN BARS.OTC_ARC_CC_TRANS.ACC IS '';
COMMENT ON COLUMN BARS.OTC_ARC_CC_TRANS.FDAT IS '';
COMMENT ON COLUMN BARS.OTC_ARC_CC_TRANS.SV IS '';
COMMENT ON COLUMN BARS.OTC_ARC_CC_TRANS.SZ IS '';
COMMENT ON COLUMN BARS.OTC_ARC_CC_TRANS.D_PLAN IS '';
COMMENT ON COLUMN BARS.OTC_ARC_CC_TRANS.D_FAKT IS '';
COMMENT ON COLUMN BARS.OTC_ARC_CC_TRANS.DAPP IS '';
COMMENT ON COLUMN BARS.OTC_ARC_CC_TRANS.REFP IS '';
COMMENT ON COLUMN BARS.OTC_ARC_CC_TRANS.COMM IS '';




PROMPT *** Create  constraint PK_OTC_ARC_CC_TRANS ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTC_ARC_CC_TRANS ADD CONSTRAINT PK_OTC_ARC_CC_TRANS PRIMARY KEY (DAT_OTC, NPP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OTC_ARC_CC_TRANS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OTC_ARC_CC_TRANS ON BARS.OTC_ARC_CC_TRANS (DAT_OTC, NPP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_OTC_ARC_CC_TRANS ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_OTC_ARC_CC_TRANS ON BARS.OTC_ARC_CC_TRANS (DAT_OTC, ACC, FDAT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTC_ARC_CC_TRANS.sql =========*** End 
PROMPT ===================================================================================== 
