

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SEGMENT_OF_BUSINESS.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SEGMENT_OF_BUSINESS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SEGMENT_OF_BUSINESS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SEGMENT_OF_BUSINESS'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SEGMENT_OF_BUSINESS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SEGMENT_OF_BUSINESS ***
begin 
  execute immediate '
  CREATE TABLE BARS.SEGMENT_OF_BUSINESS 
   (	ID NUMBER(5,0), 
	SEGMENT_CODE VARCHAR2(30 CHAR), 
	SEGMENT_NAME VARCHAR2(300 CHAR)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SEGMENT_OF_BUSINESS ***
 exec bpa.alter_policies('SEGMENT_OF_BUSINESS');


COMMENT ON TABLE BARS.SEGMENT_OF_BUSINESS IS '';
COMMENT ON COLUMN BARS.SEGMENT_OF_BUSINESS.ID IS '';
COMMENT ON COLUMN BARS.SEGMENT_OF_BUSINESS.SEGMENT_CODE IS '';
COMMENT ON COLUMN BARS.SEGMENT_OF_BUSINESS.SEGMENT_NAME IS '';




PROMPT *** Create  constraint CC_BUSN_SEG_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEGMENT_OF_BUSINESS ADD CONSTRAINT CC_BUSN_SEG_NAME_NN CHECK (SEGMENT_NAME IS NOT NULL) DEFERRABLE INITIALLY DEFERRED ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_SEGMENT_OF_BUSINESS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEGMENT_OF_BUSINESS ADD CONSTRAINT PK_SEGMENT_OF_BUSINESS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint UK_SEGMENT_OF_BUSINESS ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEGMENT_OF_BUSINESS ADD CONSTRAINT UK_SEGMENT_OF_BUSINESS UNIQUE (SEGMENT_CODE)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BUSN_SEG_ID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEGMENT_OF_BUSINESS MODIFY (ID CONSTRAINT CC_BUSN_SEG_ID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BUSN_SEG_CODE_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.SEGMENT_OF_BUSINESS MODIFY (SEGMENT_CODE CONSTRAINT CC_BUSN_SEG_CODE_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_SEGMENT_OF_BUSINESS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_SEGMENT_OF_BUSINESS ON BARS.SEGMENT_OF_BUSINESS (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index UK_SEGMENT_OF_BUSINESS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.UK_SEGMENT_OF_BUSINESS ON BARS.SEGMENT_OF_BUSINESS (SEGMENT_CODE) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  SEGMENT_OF_BUSINESS ***
grant SELECT                                                                 on SEGMENT_OF_BUSINESS to BARSREADER_ROLE;
grant SELECT                                                                 on SEGMENT_OF_BUSINESS to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SEGMENT_OF_BUSINESS.sql =========*** E
PROMPT ===================================================================================== 
