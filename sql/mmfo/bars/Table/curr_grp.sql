

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CURR_GRP.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CURR_GRP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CURR_GRP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CURR_GRP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CURR_GRP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CURR_GRP ***
begin 
  execute immediate '
  CREATE TABLE BARS.CURR_GRP 
   (	GRP NUMBER(*,0), 
	NAME VARCHAR2(35), 
	LIM_POS NUMBER(24,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CURR_GRP ***
 exec bpa.alter_policies('CURR_GRP');


COMMENT ON TABLE BARS.CURR_GRP IS '';
COMMENT ON COLUMN BARS.CURR_GRP.GRP IS '';
COMMENT ON COLUMN BARS.CURR_GRP.NAME IS '';
COMMENT ON COLUMN BARS.CURR_GRP.LIM_POS IS '';




PROMPT *** Create  constraint XPK_CURR_GRP ***
begin   
 execute immediate '
  ALTER TABLE BARS.CURR_GRP ADD CONSTRAINT XPK_CURR_GRP PRIMARY KEY (GRP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008574 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CURR_GRP MODIFY (GRP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_CURR_GRP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_CURR_GRP ON BARS.CURR_GRP (GRP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CURR_GRP ***
grant SELECT                                                                 on CURR_GRP        to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CURR_GRP        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CURR_GRP        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CURR_GRP        to START1;
grant SELECT                                                                 on CURR_GRP        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CURR_GRP.sql =========*** End *** ====
PROMPT ===================================================================================== 
