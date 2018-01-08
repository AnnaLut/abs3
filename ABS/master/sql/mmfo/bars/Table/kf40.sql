

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KF40.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KF40 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KF40'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KF40'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KF40'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KF40 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KF40 
   (	KOD CHAR(2), 
	NAIM VARCHAR2(80)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KF40 ***
 exec bpa.alter_policies('KF40');


COMMENT ON TABLE BARS.KF40 IS 'Коди видiв операцiй';
COMMENT ON COLUMN BARS.KF40.KOD IS '';
COMMENT ON COLUMN BARS.KF40.NAIM IS '';




PROMPT *** Create  constraint XPK_KF40 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF40 ADD CONSTRAINT XPK_KF40 PRIMARY KEY (KOD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C008711 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF40 MODIFY (KOD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_KF40 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_KF40 ON BARS.KF40 (KOD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KF40 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KF40            to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on KF40            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KF40            to BARS_DM;
grant SELECT                                                                 on KF40            to PYOD001;
grant SELECT                                                                 on KF40            to RPBN002;
grant DELETE,INSERT,SELECT,UPDATE                                            on KF40            to SALGL;
grant SELECT                                                                 on KF40            to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KF40            to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to KF40 ***

  CREATE OR REPLACE PUBLIC SYNONYM KF40 FOR BARS.KF40;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KF40.sql =========*** End *** ========
PROMPT ===================================================================================== 
