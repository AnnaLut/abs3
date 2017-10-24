

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML2_BR3.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML2_BR3 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XML2_BR3'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''XML2_BR3'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''XML2_BR3'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML2_BR3 ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML2_BR3 
   (	BR3 VARCHAR2(10), 
	NAMEX VARCHAR2(100), 
	BRANCH VARCHAR2(30)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XML2_BR3 ***
 exec bpa.alter_policies('XML2_BR3');


COMMENT ON TABLE BARS.XML2_BR3 IS '';
COMMENT ON COLUMN BARS.XML2_BR3.BR3 IS '';
COMMENT ON COLUMN BARS.XML2_BR3.NAMEX IS '';
COMMENT ON COLUMN BARS.XML2_BR3.BRANCH IS '';




PROMPT *** Create  constraint XPK_XML2BR3 ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML2_BR3 ADD CONSTRAINT XPK_XML2BR3 PRIMARY KEY (BR3)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_XML2BR3 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_XML2BR3 ON BARS.XML2_BR3 (BR3) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XML2_BR3 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on XML2_BR3        to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on XML2_BR3        to BARS_ACCESS_DEFROLE;
grant DELETE,SELECT,UPDATE                                                   on XML2_BR3        to PYOD001;
grant FLASHBACK,SELECT                                                       on XML2_BR3        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML2_BR3.sql =========*** End *** ====
PROMPT ===================================================================================== 
