

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/MAKW_GRP.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to MAKW_GRP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''MAKW_GRP'', ''CENTER'' , ''B'', ''B'', ''B'', null);
               bpa.alter_policy_info(''MAKW_GRP'', ''FILIAL'' , ''B'', ''B'', ''B'', null);
               bpa.alter_policy_info(''MAKW_GRP'', ''WHOLE'' , ''B'', ''B'', ''B'', null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table MAKW_GRP ***
begin 
  execute immediate '
  CREATE TABLE BARS.MAKW_GRP 
   (	GRP NUMBER, 
	NAME VARCHAR2(160 CHAR), 
	BRANCH VARCHAR2(22 CHAR) DEFAULT SYS_CONTEXT (''bars_context'',''user_branch'')
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to MAKW_GRP ***
 exec bpa.alter_policies('MAKW_GRP');


COMMENT ON TABLE BARS.MAKW_GRP IS '';
COMMENT ON COLUMN BARS.MAKW_GRP.GRP IS 'ГРУПА МАКЕТІІВ';
COMMENT ON COLUMN BARS.MAKW_GRP.NAME IS 'НАЗВА МАКЕТУ';
COMMENT ON COLUMN BARS.MAKW_GRP.BRANCH IS 'БРАНЧ';




PROMPT *** Create  constraint PK_MAKWDET_GRP ***
begin   
 execute immediate '
  ALTER TABLE BARS.MAKW_GRP ADD CONSTRAINT PK_MAKWDET_GRP PRIMARY KEY (GRP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004942 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MAKW_GRP MODIFY (GRP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004943 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MAKW_GRP MODIFY (NAME NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C004944 ***
begin   
 execute immediate '
  ALTER TABLE BARS.MAKW_GRP MODIFY (BRANCH NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_MAKWDET_GRP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_MAKWDET_GRP ON BARS.MAKW_GRP (GRP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  MAKW_GRP ***
grant SELECT                                                                 on MAKW_GRP        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on MAKW_GRP        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on MAKW_GRP        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/MAKW_GRP.sql =========*** End *** ====
PROMPT ===================================================================================== 
