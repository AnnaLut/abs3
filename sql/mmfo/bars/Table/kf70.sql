

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KF70.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KF70 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KF70'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KF70'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KF70'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KF70 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KF70 
   (	KOD CHAR(2), 
	NAIM VARCHAR2(45)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KF70 ***
 exec bpa.alter_policies('KF70');


COMMENT ON TABLE BARS.KF70 IS 'Коди i назви кодiв файлу #70';
COMMENT ON COLUMN BARS.KF70.KOD IS '';
COMMENT ON COLUMN BARS.KF70.NAIM IS '';




PROMPT *** Create  constraint XPK_KF70 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF70 ADD CONSTRAINT XPK_KF70 PRIMARY KEY (KOD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007392 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF70 MODIFY (KOD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_KF70 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_KF70 ON BARS.KF70 (KOD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KF70 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KF70            to ABS_ADMIN;
grant SELECT                                                                 on KF70            to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KF70            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KF70            to BARS_DM;
grant SELECT                                                                 on KF70            to RPBN002;
grant DELETE,INSERT,SELECT,UPDATE                                            on KF70            to SALGL;
grant SELECT                                                                 on KF70            to START1;
grant SELECT                                                                 on KF70            to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KF70            to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to KF70 ***

  CREATE OR REPLACE PUBLIC SYNONYM KF70 FOR BARS.KF70;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KF70.sql =========*** End *** ========
PROMPT ===================================================================================== 
