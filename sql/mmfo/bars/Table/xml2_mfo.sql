

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML2_MFO.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML2_MFO ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XML2_MFO'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''XML2_MFO'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''XML2_MFO'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML2_MFO ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML2_MFO 
   (	MFO VARCHAR2(6), 
	BR3 VARCHAR2(10), 
	NAMEX VARCHAR2(100), 
	BM NUMBER(*,0), 
	NLS VARCHAR2(14)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XML2_MFO ***
 exec bpa.alter_policies('XML2_MFO');


COMMENT ON TABLE BARS.XML2_MFO IS '';
COMMENT ON COLUMN BARS.XML2_MFO.MFO IS '';
COMMENT ON COLUMN BARS.XML2_MFO.BR3 IS '';
COMMENT ON COLUMN BARS.XML2_MFO.NAMEX IS '';
COMMENT ON COLUMN BARS.XML2_MFO.BM IS '';
COMMENT ON COLUMN BARS.XML2_MFO.NLS IS '';




PROMPT *** Create  constraint FK_XML2MFO ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML2_MFO ADD CONSTRAINT FK_XML2MFO FOREIGN KEY (BM)
	  REFERENCES BARS.XML2_BM (BM) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_XML2MFO ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML2_MFO ADD CONSTRAINT XPK_XML2MFO PRIMARY KEY (MFO, BR3, BM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_XML2MFO ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_XML2MFO ON BARS.XML2_MFO (MFO, BR3, BM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XML2_MFO ***
grant DELETE,INSERT,SELECT,UPDATE                                            on XML2_MFO        to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on XML2_MFO        to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on XML2_MFO        to PYOD001;
grant FLASHBACK,SELECT                                                       on XML2_MFO        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML2_MFO.sql =========*** End *** ====
PROMPT ===================================================================================== 
