

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KF32.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KF32 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KF32'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KF32'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KF32'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KF32 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KF32 
   (	KOD CHAR(3), 
	NAIM VARCHAR2(45)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KF32 ***
 exec bpa.alter_policies('KF32');


COMMENT ON TABLE BARS.KF32 IS '';
COMMENT ON COLUMN BARS.KF32.KOD IS '';
COMMENT ON COLUMN BARS.KF32.NAIM IS '';




PROMPT *** Create  constraint XPK_KF32 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF32 ADD CONSTRAINT XPK_KF32 PRIMARY KEY (KOD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007963 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF32 MODIFY (KOD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_KF32 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_KF32 ON BARS.KF32 (KOD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KF32 ***
grant SELECT                                                                 on KF32            to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KF32            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KF32            to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KF32            to START1;
grant SELECT                                                                 on KF32            to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KF32.sql =========*** End *** ========
PROMPT ===================================================================================== 
