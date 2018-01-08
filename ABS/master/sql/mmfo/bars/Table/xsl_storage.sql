

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XSL_STORAGE.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XSL_STORAGE ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XSL_STORAGE'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''XSL_STORAGE'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''XSL_STORAGE'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XSL_STORAGE ***
begin 
  execute immediate '
  CREATE TABLE BARS.XSL_STORAGE 
   (	URI VARCHAR2(255), 
	XSL_DATA CLOB
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND 
 LOB (XSL_DATA) STORE AS BASICFILE (
  TABLESPACE BRSDYND ENABLE STORAGE IN ROW CHUNK 8192 RETENTION 
  NOCACHE LOGGING ) ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XSL_STORAGE ***
 exec bpa.alter_policies('XSL_STORAGE');


COMMENT ON TABLE BARS.XSL_STORAGE IS '';
COMMENT ON COLUMN BARS.XSL_STORAGE.URI IS '';
COMMENT ON COLUMN BARS.XSL_STORAGE.XSL_DATA IS '';




PROMPT *** Create  constraint XPK_XSL_STORAGE ***
begin   
 execute immediate '
  ALTER TABLE BARS.XSL_STORAGE ADD CONSTRAINT XPK_XSL_STORAGE PRIMARY KEY (URI)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_XSL_STORAGE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_XSL_STORAGE ON BARS.XSL_STORAGE (URI) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XSL_STORAGE ***
grant SELECT                                                                 on XSL_STORAGE     to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on XSL_STORAGE     to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on XSL_STORAGE     to START1;
grant SELECT                                                                 on XSL_STORAGE     to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XSL_STORAGE.sql =========*** End *** =
PROMPT ===================================================================================== 
