

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DWH_CBIREP_QUERY_STATUSES.sql ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DWH_CBIREP_QUERY_STATUSES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DWH_CBIREP_QUERY_STATUSES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DWH_CBIREP_QUERY_STATUSES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DWH_CBIREP_QUERY_STATUSES ***
begin 
  execute immediate '
  CREATE TABLE BARS.DWH_CBIREP_QUERY_STATUSES 
   (	ID VARCHAR2(100), 
	NAME VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DWH_CBIREP_QUERY_STATUSES ***
 exec bpa.alter_policies('DWH_CBIREP_QUERY_STATUSES');


COMMENT ON TABLE BARS.DWH_CBIREP_QUERY_STATUSES IS 'статусы заявки на формирование отчета';
COMMENT ON COLUMN BARS.DWH_CBIREP_QUERY_STATUSES.ID IS 'идентификатор';
COMMENT ON COLUMN BARS.DWH_CBIREP_QUERY_STATUSES.NAME IS 'наименование';




PROMPT *** Create  constraint PK_DWHCBIREPQSTATS ***
begin   
 execute immediate '
  ALTER TABLE BARS.DWH_CBIREP_QUERY_STATUSES ADD CONSTRAINT PK_DWHCBIREPQSTATS PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_DWHCBIREPQSTATS_NAME_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.DWH_CBIREP_QUERY_STATUSES MODIFY (NAME CONSTRAINT CC_DWHCBIREPQSTATS_NAME_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_DWHCBIREPQSTATS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_DWHCBIREPQSTATS ON BARS.DWH_CBIREP_QUERY_STATUSES (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DWH_CBIREP_QUERY_STATUSES ***
grant DELETE,INSERT,SELECT,UPDATE                                            on DWH_CBIREP_QUERY_STATUSES to BARS_ACCESS_DEFROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DWH_CBIREP_QUERY_STATUSES.sql ========
PROMPT ===================================================================================== 
