

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CBIREP_QUERY_STATUSES.sql =========***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CBIREP_QUERY_STATUSES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CBIREP_QUERY_STATUSES'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''CBIREP_QUERY_STATUSES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CBIREP_QUERY_STATUSES ***
begin 
  execute immediate '
  CREATE TABLE BARS.CBIREP_QUERY_STATUSES 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CBIREP_QUERY_STATUSES ***
 exec bpa.alter_policies('CBIREP_QUERY_STATUSES');


COMMENT ON TABLE BARS.CBIREP_QUERY_STATUSES IS '������� ������ �� ������������ ������';
COMMENT ON COLUMN BARS.CBIREP_QUERY_STATUSES.ID IS '�������������';
COMMENT ON COLUMN BARS.CBIREP_QUERY_STATUSES.NAME IS '������������';




PROMPT *** Create  constraint PK_CBIREPQSTATS ***
begin   
 execute immediate '
  ALTER TABLE BARS.CBIREP_QUERY_STATUSES ADD CONSTRAINT PK_CBIREPQSTATS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_CBIREPQSTATS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.CBIREP_QUERY_STATUSES MODIFY (NAME CONSTRAINT CC_CBIREPQSTATS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CBIREPQSTATS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CBIREPQSTATS ON BARS.CBIREP_QUERY_STATUSES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CBIREP_QUERY_STATUSES.sql =========***
PROMPT ===================================================================================== 
