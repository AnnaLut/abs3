

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/XML2_ID.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to XML2_ID ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''XML2_ID'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''XML2_ID'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''XML2_ID'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table XML2_ID ***
begin 
  execute immediate '
  CREATE TABLE BARS.XML2_ID 
   (	PROVID VARCHAR2(10), 
	SERVID VARCHAR2(11), 
	NAME VARCHAR2(160), 
	BM NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to XML2_ID ***
 exec bpa.alter_policies('XML2_ID');


COMMENT ON TABLE BARS.XML2_ID IS '';
COMMENT ON COLUMN BARS.XML2_ID.PROVID IS '';
COMMENT ON COLUMN BARS.XML2_ID.SERVID IS '';
COMMENT ON COLUMN BARS.XML2_ID.NAME IS '';
COMMENT ON COLUMN BARS.XML2_ID.BM IS '';




PROMPT *** Create  constraint FK_XML2ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML2_ID ADD CONSTRAINT FK_XML2ID FOREIGN KEY (BM)
	  REFERENCES BARS.XML2_BM (BM) ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint XPK_XML2ID ***
begin   
 execute immediate '
  ALTER TABLE BARS.XML2_ID ADD CONSTRAINT XPK_XML2ID PRIMARY KEY (PROVID, SERVID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_XML2ID ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_XML2ID ON BARS.XML2_ID (PROVID, SERVID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  XML2_ID ***
grant DELETE,INSERT,SELECT,UPDATE                                            on XML2_ID         to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on XML2_ID         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on XML2_ID         to BARS_DM;
grant DELETE,SELECT,UPDATE                                                   on XML2_ID         to PYOD001;
grant FLASHBACK,SELECT                                                       on XML2_ID         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/XML2_ID.sql =========*** End *** =====
PROMPT ===================================================================================== 
