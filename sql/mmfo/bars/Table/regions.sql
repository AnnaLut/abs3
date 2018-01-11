

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REGIONS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REGIONS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REGIONS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REGIONS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REGIONS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REGIONS ***
begin 
  execute immediate '
  CREATE TABLE BARS.REGIONS 
   (	ID NUMBER, 
	CODE CHAR(2), 
	NAME VARCHAR2(100), 
	KF VARCHAR2(6), 
	SORT_ID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REGIONS ***
 exec bpa.alter_policies('REGIONS');


COMMENT ON TABLE BARS.REGIONS IS 'Список кодів регіонів';
COMMENT ON COLUMN BARS.REGIONS.ID IS '';
COMMENT ON COLUMN BARS.REGIONS.CODE IS '';
COMMENT ON COLUMN BARS.REGIONS.NAME IS '';
COMMENT ON COLUMN BARS.REGIONS.KF IS '';
COMMENT ON COLUMN BARS.REGIONS.SORT_ID IS '';




PROMPT *** Create  constraint XPK_REGIONS ***
begin   
 execute immediate '
  ALTER TABLE BARS.REGIONS ADD CONSTRAINT XPK_REGIONS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_REGIONS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_REGIONS ON BARS.REGIONS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REGIONS ***
grant SELECT                                                                 on REGIONS         to BARSREADER_ROLE;
grant SELECT                                                                 on REGIONS         to BARS_DM;
grant SELECT                                                                 on REGIONS         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REGIONS.sql =========*** End *** =====
PROMPT ===================================================================================== 
