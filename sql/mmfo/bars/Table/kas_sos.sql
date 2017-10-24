

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KAS_SOS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KAS_SOS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KAS_SOS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KAS_SOS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KAS_SOS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KAS_SOS ***
begin 
  execute immediate '
  CREATE TABLE BARS.KAS_SOS 
   (	SOS NUMBER(*,0), 
	NAME VARCHAR2(25)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KAS_SOS ***
 exec bpa.alter_policies('KAS_SOS');


COMMENT ON TABLE BARS.KAS_SOS IS 'Стан касових заявок';
COMMENT ON COLUMN BARS.KAS_SOS.SOS IS 'Код';
COMMENT ON COLUMN BARS.KAS_SOS.NAME IS 'Назва';




PROMPT *** Create  constraint PK_KAS_SOS ***
begin   
 execute immediate '
  ALTER TABLE BARS.KAS_SOS ADD CONSTRAINT PK_KAS_SOS PRIMARY KEY (SOS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_KAS_SOS ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_KAS_SOS ON BARS.KAS_SOS (SOS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KAS_SOS ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KAS_SOS         to ABS_ADMIN;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KAS_SOS         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KAS_SOS         to PYOD001;
grant FLASHBACK,SELECT                                                       on KAS_SOS         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KAS_SOS.sql =========*** End *** =====
PROMPT ===================================================================================== 
