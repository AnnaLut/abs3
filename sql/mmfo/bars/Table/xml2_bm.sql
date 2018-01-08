

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML2_BM.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML2_BM ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XML2_BM'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''XML2_BM'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''XML2_BM'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML2_BM ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML2_BM 
   (	BM NUMBER(*,0), 
	NAME VARCHAR2(35), 
	NBSA CHAR(4), 
	OB22A CHAR(2), 
	KVA NUMBER(*,0), 
	DK NUMBER(*,0), 
	NBSB CHAR(4), 
	OB22B CHAR(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XML2_BM ***
 exec bpa.alter_policies('XML2_BM');


COMMENT ON TABLE BARS.XML2_BM IS '';
COMMENT ON COLUMN BARS.XML2_BM.BM IS '';
COMMENT ON COLUMN BARS.XML2_BM.NAME IS '';
COMMENT ON COLUMN BARS.XML2_BM.NBSA IS '';
COMMENT ON COLUMN BARS.XML2_BM.OB22A IS '';
COMMENT ON COLUMN BARS.XML2_BM.KVA IS '';
COMMENT ON COLUMN BARS.XML2_BM.DK IS '';
COMMENT ON COLUMN BARS.XML2_BM.NBSB IS '';
COMMENT ON COLUMN BARS.XML2_BM.OB22B IS '';




PROMPT *** Create  constraint XPK_XML2BM ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML2_BM ADD CONSTRAINT XPK_XML2BM PRIMARY KEY (BM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_XML2BM ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_XML2BM ON BARS.XML2_BM (BM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XML2_BM ***
grant DELETE,INSERT,SELECT,UPDATE                                            on XML2_BM         to ABS_ADMIN;
grant SELECT                                                                 on XML2_BM         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on XML2_BM         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on XML2_BM         to BARS_DM;
grant DELETE,SELECT,UPDATE                                                   on XML2_BM         to PYOD001;
grant SELECT                                                                 on XML2_BM         to UPLD;
grant FLASHBACK,SELECT                                                       on XML2_BM         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML2_BM.sql =========*** End *** =====
PROMPT ===================================================================================== 
