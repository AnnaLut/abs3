

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/VOB_KOD.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to VOB_KOD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''VOB_KOD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''VOB_KOD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''VOB_KOD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table VOB_KOD ***
begin 
  execute immediate '
  CREATE TABLE BARS.VOB_KOD 
   (	ID CHAR(2), 
	NAME VARCHAR2(50)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to VOB_KOD ***
 exec bpa.alter_policies('VOB_KOD');


COMMENT ON TABLE BARS.VOB_KOD IS '';
COMMENT ON COLUMN BARS.VOB_KOD.ID IS '';
COMMENT ON COLUMN BARS.VOB_KOD.NAME IS '';




PROMPT *** Create  constraint XPK_VOB_KOD ***
begin   
 execute immediate '
  ALTER TABLE BARS.VOB_KOD ADD CONSTRAINT XPK_VOB_KOD PRIMARY KEY (ID)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005725 ***
begin   
 execute immediate '
  ALTER TABLE BARS.VOB_KOD MODIFY (ID NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_VOB_KOD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_VOB_KOD ON BARS.VOB_KOD (ID) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  VOB_KOD ***
grant SELECT                                                                 on VOB_KOD         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on VOB_KOD         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on VOB_KOD         to START1;
grant SELECT                                                                 on VOB_KOD         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/VOB_KOD.sql =========*** End *** =====
PROMPT ===================================================================================== 
