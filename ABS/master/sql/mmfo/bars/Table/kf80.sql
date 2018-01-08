

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KF80.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KF80 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KF80'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KF80'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KF80'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KF80 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KF80 
   (	KOD CHAR(3), 
	NAIM VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KF80 ***
 exec bpa.alter_policies('KF80');


COMMENT ON TABLE BARS.KF80 IS '';
COMMENT ON COLUMN BARS.KF80.KOD IS '';
COMMENT ON COLUMN BARS.KF80.NAIM IS '';




PROMPT *** Create  constraint XPK_KF80 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF80 ADD CONSTRAINT XPK_KF80 PRIMARY KEY (KOD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006663 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF80 MODIFY (KOD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_KF80 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_KF80 ON BARS.KF80 (KOD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KF80 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KF80            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KF80            to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KF80            to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KF80.sql =========*** End *** ========
PROMPT ===================================================================================== 
