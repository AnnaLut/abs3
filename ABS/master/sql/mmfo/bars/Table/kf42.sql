

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KF42.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KF42 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KF42'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KF42'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KF42'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KF42 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KF42 
   (	KOD CHAR(2), 
	NAIM VARCHAR2(60)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KF42 ***
 exec bpa.alter_policies('KF42');


COMMENT ON TABLE BARS.KF42 IS 'Коди i назви кодiв файлу #42';
COMMENT ON COLUMN BARS.KF42.KOD IS '';
COMMENT ON COLUMN BARS.KF42.NAIM IS '';




PROMPT *** Create  constraint XPK_KF42 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF42 ADD CONSTRAINT XPK_KF42 PRIMARY KEY (KOD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C007244 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF42 MODIFY (KOD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_KF42 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_KF42 ON BARS.KF42 (KOD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KF42 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KF42            to ABS_ADMIN;
grant SELECT                                                                 on KF42            to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KF42            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KF42            to BARS_DM;
grant SELECT                                                                 on KF42            to RPBN002;
grant DELETE,INSERT,SELECT,UPDATE                                            on KF42            to SALGL;
grant SELECT                                                                 on KF42            to START1;
grant SELECT                                                                 on KF42            to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KF42            to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to KF42 ***

  CREATE OR REPLACE PUBLIC SYNONYM KF42 FOR BARS.KF42;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KF42.sql =========*** End *** ========
PROMPT ===================================================================================== 
