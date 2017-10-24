

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTC_ARC_INFO.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTC_ARC_INFO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTC_ARC_INFO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTC_ARC_INFO ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTC_ARC_INFO 
   (	NPP NUMBER, 
	DAT_OTC DATE, 
	DAT_SYS DATE, 
	DAT_BANK DATE, 
	USERID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTC_ARC_INFO ***
 exec bpa.alter_policies('OTC_ARC_INFO');


COMMENT ON TABLE BARS.OTC_ARC_INFO IS '';
COMMENT ON COLUMN BARS.OTC_ARC_INFO.NPP IS '';
COMMENT ON COLUMN BARS.OTC_ARC_INFO.DAT_OTC IS '';
COMMENT ON COLUMN BARS.OTC_ARC_INFO.DAT_SYS IS '';
COMMENT ON COLUMN BARS.OTC_ARC_INFO.DAT_BANK IS '';
COMMENT ON COLUMN BARS.OTC_ARC_INFO.USERID IS '';




PROMPT *** Create  constraint PK_OTC_ARC_INFO ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTC_ARC_INFO ADD CONSTRAINT PK_OTC_ARC_INFO PRIMARY KEY (NPP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OTC_ARC_INFO ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OTC_ARC_INFO ON BARS.OTC_ARC_INFO (NPP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_OTC_ARC_INFO ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_OTC_ARC_INFO ON BARS.OTC_ARC_INFO (DAT_OTC) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTC_ARC_INFO.sql =========*** End *** 
PROMPT ===================================================================================== 
