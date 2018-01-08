

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_KOD.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_KOD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_KOD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_KOD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_KOD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_KOD ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_KOD 
   (	NAME VARCHAR2(160), 
	ORD NUMBER(*,0), 
	KOD VARCHAR2(4), 
	IDF NUMBER(*,0), 
	FM CHAR(1) DEFAULT ''0''
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_KOD ***
 exec bpa.alter_policies('FIN_KOD');


COMMENT ON TABLE BARS.FIN_KOD IS '';
COMMENT ON COLUMN BARS.FIN_KOD.FM IS '';
COMMENT ON COLUMN BARS.FIN_KOD.NAME IS '';
COMMENT ON COLUMN BARS.FIN_KOD.ORD IS '';
COMMENT ON COLUMN BARS.FIN_KOD.KOD IS '';
COMMENT ON COLUMN BARS.FIN_KOD.IDF IS '';




PROMPT *** Create  constraint PK_FINKOD ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_KOD ADD CONSTRAINT PK_FINKOD PRIMARY KEY (KOD, IDF, FM)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FINKOD_KOD ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_KOD MODIFY (KOD CONSTRAINT CC_FINKOD_KOD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_FINKOD_IDF ***
begin   
 execute immediate '
  ALTER TABLE BARS.FIN_KOD MODIFY (IDF CONSTRAINT CC_FINKOD_IDF NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_FINKOD ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_FINKOD ON BARS.FIN_KOD (KOD, IDF, FM) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  FIN_KOD ***
grant SELECT                                                                 on FIN_KOD         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on FIN_KOD         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_KOD         to BARS_DM;
grant SELECT                                                                 on FIN_KOD         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_KOD.sql =========*** End *** =====
PROMPT ===================================================================================== 
