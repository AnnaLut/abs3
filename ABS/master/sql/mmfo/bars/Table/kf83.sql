

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KF83.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KF83 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KF83'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KF83'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KF83'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KF83 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KF83 
   (	KOD CHAR(2), 
	NAIM VARCHAR2(50)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KF83 ***
 exec bpa.alter_policies('KF83');


COMMENT ON TABLE BARS.KF83 IS '';
COMMENT ON COLUMN BARS.KF83.KOD IS '';
COMMENT ON COLUMN BARS.KF83.NAIM IS '';




PROMPT *** Create  constraint XPK_KF83 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF83 ADD CONSTRAINT XPK_KF83 PRIMARY KEY (KOD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007063 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF83 MODIFY (KOD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_KF83 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_KF83 ON BARS.KF83 (KOD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KF83 ***
grant SELECT                                                                 on KF83            to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KF83            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KF83            to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KF83            to START1;
grant SELECT                                                                 on KF83            to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KF83.sql =========*** End *** ========
PROMPT ===================================================================================== 
