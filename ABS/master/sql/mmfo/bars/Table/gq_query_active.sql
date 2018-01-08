

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/GQ_QUERY_ACTIVE.sql =========*** Run *
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to GQ_QUERY_ACTIVE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''GQ_QUERY_ACTIVE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''GQ_QUERY_ACTIVE'', ''FILIAL'' , ''F'', ''F'', ''F'', ''F'');
               bpa.alter_policy_info(''GQ_QUERY_ACTIVE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table GQ_QUERY_ACTIVE ***
begin 
  execute immediate '
  CREATE TABLE BARS.GQ_QUERY_ACTIVE 
   (	QUERY_ID NUMBER(38,0), 
	BRANCH VARCHAR2(30) DEFAULT sys_context(''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to GQ_QUERY_ACTIVE ***
 exec bpa.alter_policies('GQ_QUERY_ACTIVE');


COMMENT ON TABLE BARS.GQ_QUERY_ACTIVE IS 'Інформаційні запити. Перелік активних запитів';
COMMENT ON COLUMN BARS.GQ_QUERY_ACTIVE.QUERY_ID IS '';
COMMENT ON COLUMN BARS.GQ_QUERY_ACTIVE.BRANCH IS 'Код отделения';




PROMPT *** Create  constraint PK_GQQUERYACTIVE ***
begin   
 execute immediate '
  ALTER TABLE BARS.GQ_QUERY_ACTIVE ADD CONSTRAINT PK_GQQUERYACTIVE PRIMARY KEY (QUERY_ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GQQUERYACTIVE_QUERYID_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GQ_QUERY_ACTIVE MODIFY (QUERY_ID CONSTRAINT CC_GQQUERYACTIVE_QUERYID_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_GQQUERYACTIVE_BRANCH_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.GQ_QUERY_ACTIVE MODIFY (BRANCH CONSTRAINT CC_GQQUERYACTIVE_BRANCH_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_GQQUERYACTIVE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_GQQUERYACTIVE ON BARS.GQ_QUERY_ACTIVE (QUERY_ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  GQ_QUERY_ACTIVE ***
grant SELECT                                                                 on GQ_QUERY_ACTIVE to BARSREADER_ROLE;
grant SELECT                                                                 on GQ_QUERY_ACTIVE to BARS_DM;
grant SELECT                                                                 on GQ_QUERY_ACTIVE to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on GQ_QUERY_ACTIVE to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/GQ_QUERY_ACTIVE.sql =========*** End *
PROMPT ===================================================================================== 
