

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_DEB.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_DEB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_DEB'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''REZ_DEB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_DEB ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ_DEB 
   (	NBS VARCHAR2(4), 
	DEB NUMBER(*,0), 
	PR NUMBER(*,0), 
	PR2 NUMBER(*,0), 
	TXT VARCHAR2(200), 
	TIPA NUMBER(*,0), 
	TIPA_FV NUMBER(*,0), 
	D_CLOSE DATE, 
	GRUPA NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REZ_DEB ***
 exec bpa.alter_policies('REZ_DEB');


COMMENT ON TABLE BARS.REZ_DEB IS 'Кредитний ризик 351';
COMMENT ON COLUMN BARS.REZ_DEB.NBS IS 'Бал.рах.';
COMMENT ON COLUMN BARS.REZ_DEB.DEB IS 'Тип дебіторки';
COMMENT ON COLUMN BARS.REZ_DEB.PR IS '';
COMMENT ON COLUMN BARS.REZ_DEB.PR2 IS '';
COMMENT ON COLUMN BARS.REZ_DEB.TXT IS '';
COMMENT ON COLUMN BARS.REZ_DEB.TIPA IS 'Тип активу (по REZ_TIPA)';
COMMENT ON COLUMN BARS.REZ_DEB.TIPA_FV IS 'Тип активу для прийому від FV';
COMMENT ON COLUMN BARS.REZ_DEB.D_CLOSE IS 'Группування рахунків для різних цілей';
COMMENT ON COLUMN BARS.REZ_DEB.GRUPA IS '';




PROMPT *** Create  constraint PK_REZ_DEB ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_DEB ADD CONSTRAINT PK_REZ_DEB PRIMARY KEY (NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_REZ_DEB ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REZ_DEB ON BARS.REZ_DEB (NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/




PROMPT *** Create  index I1_REZ_DEB ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_REZ_DEB ON BARS.REZ_DEB (NBS, DEB) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  index I2_REZ_DEB ***
begin   
 execute immediate '
  CREATE INDEX BARS.I1_REZ_DEB ON BARS.REZ_DEB (GRUPA, DEB) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  REZ_DEB ***
grant SELECT                                                                 on REZ_DEB         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REZ_DEB         to RCC_DEAL;
grant SELECT                                                                 on REZ_DEB         to START1;
grant SELECT                                                                 on REZ_DEB         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_DEB.sql =========*** End *** =====
PROMPT ===================================================================================== 
