

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VP.sql =========*** Run *** ==========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''VP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''VP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VP ***
begin 
  execute immediate '
  CREATE TABLE BARS.VP 
   (	VP NUMBER(*,0), 
	NAME VARCHAR2(35)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VP ***
 exec bpa.alter_policies('VP');


COMMENT ON TABLE BARS.VP IS '';
COMMENT ON COLUMN BARS.VP.VP IS '';
COMMENT ON COLUMN BARS.VP.NAME IS '';




PROMPT *** Create  constraint XPK_VP ***
begin   
 execute immediate '
  ALTER TABLE BARS.VP ADD CONSTRAINT XPK_VP PRIMARY KEY (VP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005347 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VP MODIFY (VP NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_VP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_VP ON BARS.VP (VP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  VP ***
grant SELECT                                                                 on VP              to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on VP              to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on VP              to START1;
grant SELECT                                                                 on VP              to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VP.sql =========*** End *** ==========
PROMPT ===================================================================================== 
