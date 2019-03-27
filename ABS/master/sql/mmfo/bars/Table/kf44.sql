

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KF44.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KF44 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KF44'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KF44'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KF44'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KF44 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KF44 
   (	KOD CHAR(2), 
	NAIM VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KF44 ***
 exec bpa.alter_policies('KF44');


COMMENT ON TABLE BARS.KF44 IS '���� ���i� �����i� ��� 䠩�� #44';
COMMENT ON COLUMN BARS.KF44.KOD IS '';
COMMENT ON COLUMN BARS.KF44.NAIM IS '';




PROMPT *** Create  constraint XPK_KF44 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF44 ADD CONSTRAINT XPK_KF44 PRIMARY KEY (KOD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006754 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF44 MODIFY (KOD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_KF44 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_KF44 ON BARS.KF44 (KOD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KF44 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KF44            to ABS_ADMIN;
grant SELECT                                                                 on KF44            to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KF44            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KF44            to BARS_DM;
grant SELECT                                                                 on KF44            to PYOD001;
grant SELECT                                                                 on KF44            to RPBN002;
grant DELETE,INSERT,SELECT,UPDATE                                            on KF44            to SALGL;
grant SELECT                                                                 on KF44            to START1;
grant SELECT                                                                 on KF44            to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KF44            to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to KF44 ***

  CREATE OR REPLACE PUBLIC SYNONYM KF44 FOR BARS.KF44;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KF44.sql =========*** End *** ========
PROMPT ===================================================================================== 