

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KF_OB40.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KF_OB40 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KF_OB40'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KF_OB40'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KF_OB40'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KF_OB40 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KF_OB40 
   (	KOD CHAR(2), 
	NAIM VARCHAR2(60)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KF_OB40 ***
 exec bpa.alter_policies('KF_OB40');


COMMENT ON TABLE BARS.KF_OB40 IS 'Довiдник показникiв для файла @40 (внутрiшнi файли ОБ)';
COMMENT ON COLUMN BARS.KF_OB40.KOD IS 'Код показника';
COMMENT ON COLUMN BARS.KF_OB40.NAIM IS 'Назва показника';




PROMPT *** Create  constraint XPK_KF_OB40 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF_OB40 ADD CONSTRAINT XPK_KF_OB40 PRIMARY KEY (KOD)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint SYS_C006010 ***
begin   
 execute immediate '
  ALTER TABLE BARS.KF_OB40 MODIFY (KOD NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_KF_OB40 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_KF_OB40 ON BARS.KF_OB40 (KOD) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KF_OB40 ***
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on KF_OB40         to ABS_ADMIN;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on KF_OB40         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KF_OB40         to BARS_DM;
grant SELECT                                                                 on KF_OB40         to PYOD001;
grant SELECT                                                                 on KF_OB40         to RPBN002;
grant SELECT                                                                 on KF_OB40         to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KF_OB40         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KF_OB40.sql =========*** End *** =====
PROMPT ===================================================================================== 
