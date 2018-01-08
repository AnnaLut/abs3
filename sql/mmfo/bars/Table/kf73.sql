

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KF73.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KF73 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KF73'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KF73'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KF73'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KF73 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KF73 
   (	KOD CHAR(3), 
	NAIM VARCHAR2(70)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KF73 ***
 exec bpa.alter_policies('KF73');


COMMENT ON TABLE BARS.KF73 IS 'Довідник показників для #73-файла НБУ';
COMMENT ON COLUMN BARS.KF73.KOD IS 'Код показника';
COMMENT ON COLUMN BARS.KF73.NAIM IS 'Зміст показника';




PROMPT *** Create  constraint SYS_C005897 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF73 MODIFY (KOD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C005898 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF73 MODIFY (NAIM NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint PK_KF73 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF73 ADD CONSTRAINT PK_KF73 PRIMARY KEY (KOD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KF73 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KF73 ON BARS.KF73 (KOD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KF73 ***
grant SELECT                                                                 on KF73            to BARSUPL;
grant DELETE,INSERT,SELECT,UPDATE                                            on KF73            to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KF73            to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KF73            to DPT_ADMIN;
grant SELECT                                                                 on KF73            to PYOD001;
grant SELECT                                                                 on KF73            to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KF73            to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KF73.sql =========*** End *** ========
PROMPT ===================================================================================== 
