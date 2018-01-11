

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DBO_TT_OPERATIONKIND.sql =========*** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DBO_TT_OPERATIONKIND ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DBO_TT_OPERATIONKIND'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DBO_TT_OPERATIONKIND'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DBO_TT_OPERATIONKIND ***
begin 
  execute immediate '
  CREATE TABLE BARS.DBO_TT_OPERATIONKIND 
   (	ID NUMBER(38,0), 
	OPERATION_KIND NUMBER(38,0), 
	TT VARCHAR2(3), 
	NAME_OPERATION VARCHAR2(400)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DBO_TT_OPERATIONKIND ***
 exec bpa.alter_policies('DBO_TT_OPERATIONKIND');


COMMENT ON TABLE BARS.DBO_TT_OPERATIONKIND IS '';
COMMENT ON COLUMN BARS.DBO_TT_OPERATIONKIND.ID IS '';
COMMENT ON COLUMN BARS.DBO_TT_OPERATIONKIND.OPERATION_KIND IS '';
COMMENT ON COLUMN BARS.DBO_TT_OPERATIONKIND.TT IS '';
COMMENT ON COLUMN BARS.DBO_TT_OPERATIONKIND.NAME_OPERATION IS '';




PROMPT *** Create  constraint DBO_TT_OPERATIONKIND_PK ***
begin   
 execute immediate '
  ALTER TABLE BARS.DBO_TT_OPERATIONKIND ADD CONSTRAINT DBO_TT_OPERATIONKIND_PK PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index DBO_TT_OPERATIONKIND_PK ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.DBO_TT_OPERATIONKIND_PK ON BARS.DBO_TT_OPERATIONKIND (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  DBO_TT_OPERATIONKIND ***
grant SELECT                                                                 on DBO_TT_OPERATIONKIND to BARSREADER_ROLE;
grant SELECT                                                                 on DBO_TT_OPERATIONKIND to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DBO_TT_OPERATIONKIND to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DBO_TT_OPERATIONKIND.sql =========*** 
PROMPT ===================================================================================== 
