

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TERRITORY.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TERRITORY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TERRITORY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TERRITORY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TERRITORY ***
begin 
  execute immediate '
  CREATE TABLE BARS.TERRITORY 
   (	ID NUMBER, 
	WORLD_PART VARCHAR2(20), 
	COUNTRY VARCHAR2(20), 
	REGION VARCHAR2(35), 
	DISTRICT VARCHAR2(35), 
	CITY VARCHAR2(35)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TERRITORY ***
 exec bpa.alter_policies('TERRITORY');


COMMENT ON TABLE BARS.TERRITORY IS '';
COMMENT ON COLUMN BARS.TERRITORY.ID IS '';
COMMENT ON COLUMN BARS.TERRITORY.WORLD_PART IS '';
COMMENT ON COLUMN BARS.TERRITORY.COUNTRY IS '';
COMMENT ON COLUMN BARS.TERRITORY.REGION IS '';
COMMENT ON COLUMN BARS.TERRITORY.DISTRICT IS '';
COMMENT ON COLUMN BARS.TERRITORY.CITY IS '';




PROMPT *** Create  constraint PK_TERRITORY ***
begin   
 execute immediate '
  ALTER TABLE BARS.TERRITORY ADD CONSTRAINT PK_TERRITORY PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TERRITORY ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TERRITORY ON BARS.TERRITORY (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLD ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TERRITORY ***
grant SELECT                                                                 on TERRITORY       to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on TERRITORY       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TERRITORY       to BARS_DM;
grant SELECT                                                                 on TERRITORY       to CIG_ROLE;
grant SELECT                                                                 on TERRITORY       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TERRITORY.sql =========*** End *** ===
PROMPT ===================================================================================== 
