

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/NODES_COMPOSER.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to NODES_COMPOSER ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''NODES_COMPOSER'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''NODES_COMPOSER'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''NODES_COMPOSER'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table NODES_COMPOSER ***
begin 
  execute immediate '
  CREATE TABLE BARS.NODES_COMPOSER 
   (	URI VARCHAR2(255), 
	NUM NUMBER, 
	URI_LINK VARCHAR2(255)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to NODES_COMPOSER ***
 exec bpa.alter_policies('NODES_COMPOSER');


COMMENT ON TABLE BARS.NODES_COMPOSER IS '';
COMMENT ON COLUMN BARS.NODES_COMPOSER.URI IS '';
COMMENT ON COLUMN BARS.NODES_COMPOSER.NUM IS '';
COMMENT ON COLUMN BARS.NODES_COMPOSER.URI_LINK IS '';




PROMPT *** Create  constraint XPK_NODES_COMPOSER ***
begin   
 execute immediate '
  ALTER TABLE BARS.NODES_COMPOSER ADD CONSTRAINT XPK_NODES_COMPOSER PRIMARY KEY (URI, NUM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_NODES_COMPOSER ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_NODES_COMPOSER ON BARS.NODES_COMPOSER (URI, NUM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  NODES_COMPOSER ***
grant SELECT                                                                 on NODES_COMPOSER  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on NODES_COMPOSER  to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on NODES_COMPOSER  to START1;
grant SELECT                                                                 on NODES_COMPOSER  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/NODES_COMPOSER.sql =========*** End **
PROMPT ===================================================================================== 
