

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/INS_MAPPING_PURPOSE.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to INS_MAPPING_PURPOSE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''INS_MAPPING_PURPOSE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''INS_MAPPING_PURPOSE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table INS_MAPPING_PURPOSE ***
begin 
  execute immediate '
  CREATE TABLE BARS.INS_MAPPING_PURPOSE 
   (	OKPO_IC VARCHAR2(400), 
	MASK VARCHAR2(4000), 
	EXT_ID NUMBER, 
	EXT_CODE VARCHAR2(30), 
	EWA_TYPE_ID VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to INS_MAPPING_PURPOSE ***
 exec bpa.alter_policies('INS_MAPPING_PURPOSE');


COMMENT ON TABLE BARS.INS_MAPPING_PURPOSE IS '';
COMMENT ON COLUMN BARS.INS_MAPPING_PURPOSE.OKPO_IC IS '';
COMMENT ON COLUMN BARS.INS_MAPPING_PURPOSE.MASK IS '';
COMMENT ON COLUMN BARS.INS_MAPPING_PURPOSE.EXT_ID IS '';
COMMENT ON COLUMN BARS.INS_MAPPING_PURPOSE.EXT_CODE IS '';
COMMENT ON COLUMN BARS.INS_MAPPING_PURPOSE.EWA_TYPE_ID IS '';




PROMPT *** Create  index I_MAP_PURP_OKPOIC_EXTID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.I_MAP_PURP_OKPOIC_EXTID ON BARS.INS_MAPPING_PURPOSE (EXT_ID, CASE  WHEN EXT_ID IS NULL THEN NULL ELSE OKPO_IC END ) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSMDLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  INS_MAPPING_PURPOSE ***
grant SELECT                                                                 on INS_MAPPING_PURPOSE to BARSREADER_ROLE;
grant SELECT                                                                 on INS_MAPPING_PURPOSE to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/INS_MAPPING_PURPOSE.sql =========*** E
PROMPT ===================================================================================== 
