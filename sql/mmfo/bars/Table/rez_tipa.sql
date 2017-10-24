

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_TIPA.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_TIPA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_TIPA'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''REZ_TIPA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_TIPA ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ_TIPA 
   (	TIPA NUMBER(*,0), 
	NAME VARCHAR2(120)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZ_TIPA ***
 exec bpa.alter_policies('REZ_TIPA');


COMMENT ON TABLE BARS.REZ_TIPA IS 'Дов_дник тип_в рахунк_в';
COMMENT ON COLUMN BARS.REZ_TIPA.TIPA IS 'Тип рахунку';
COMMENT ON COLUMN BARS.REZ_TIPA.NAME IS 'Назва';




PROMPT *** Create  constraint PK_REZ_TIPA ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_TIPA ADD CONSTRAINT PK_REZ_TIPA PRIMARY KEY (TIPA)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REZ_TIPA ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REZ_TIPA ON BARS.REZ_TIPA (TIPA) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REZ_TIPA ***
grant SELECT                                                                 on REZ_TIPA        to RCC_DEAL;
grant SELECT                                                                 on REZ_TIPA        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_TIPA.sql =========*** End *** ====
PROMPT ===================================================================================== 
