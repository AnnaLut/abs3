

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_FLAG_BLK.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_FLAG_BLK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_FLAG_BLK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_FLAG_BLK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_FLAG_BLK ***
begin 
  execute immediate '
  CREATE TABLE BARS.OTCN_FLAG_BLK 
   (	TP NUMBER, 
	DATF DATE, 
	KODF VARCHAR2(2), 
	ISP NUMBER, 
	DAT_BLK DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_FLAG_BLK ***
 exec bpa.alter_policies('OTCN_FLAG_BLK');


COMMENT ON TABLE BARS.OTCN_FLAG_BLK IS '';
COMMENT ON COLUMN BARS.OTCN_FLAG_BLK.TP IS '';
COMMENT ON COLUMN BARS.OTCN_FLAG_BLK.DATF IS '';
COMMENT ON COLUMN BARS.OTCN_FLAG_BLK.KODF IS '';
COMMENT ON COLUMN BARS.OTCN_FLAG_BLK.ISP IS '';
COMMENT ON COLUMN BARS.OTCN_FLAG_BLK.DAT_BLK IS '';




PROMPT *** Create  constraint PK_OTCN_FLAG_BLK ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_FLAG_BLK ADD CONSTRAINT PK_OTCN_FLAG_BLK PRIMARY KEY (KODF, DATF, TP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OTCN_FLAG_BLK_KODF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_FLAG_BLK MODIFY (KODF CONSTRAINT CC_OTCN_FLAG_BLK_KODF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OTCN_FLAG_BLK_DATF_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_FLAG_BLK MODIFY (DATF CONSTRAINT CC_OTCN_FLAG_BLK_DATF_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_OTCN_FLAG_BLK_TP_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.OTCN_FLAG_BLK MODIFY (TP CONSTRAINT CC_OTCN_FLAG_BLK_TP_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_OTCN_FLAG_BLK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_OTCN_FLAG_BLK ON BARS.OTCN_FLAG_BLK (KODF, DATF, TP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_FLAG_BLK.sql =========*** End ***
PROMPT ===================================================================================== 
