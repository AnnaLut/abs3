

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_GRP_KAT.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_GRP_KAT ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_GRP_KAT ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_GRP_KAT 
   (	GRP NUMBER(38,0), 
	KAT NUMBER(38,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_GRP_KAT ***
 exec bpa.alter_policies('TMP_GRP_KAT');


COMMENT ON TABLE BARS.TMP_GRP_KAT IS '';
COMMENT ON COLUMN BARS.TMP_GRP_KAT.GRP IS '';
COMMENT ON COLUMN BARS.TMP_GRP_KAT.KAT IS '';




PROMPT *** Create  constraint PK_TMPGRPKAT ***
begin   
 execute immediate '
  ALTER TABLE BARS.TMP_GRP_KAT ADD CONSTRAINT PK_TMPGRPKAT PRIMARY KEY (GRP)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_TMPGRPKAT ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_TMPGRPKAT ON BARS.TMP_GRP_KAT (GRP) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  TMP_GRP_KAT ***
grant SELECT                                                                 on TMP_GRP_KAT     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_GRP_KAT     to BARS_DM;
grant SELECT                                                                 on TMP_GRP_KAT     to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_GRP_KAT.sql =========*** End *** =
PROMPT ===================================================================================== 
