PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REZ_ND_CP.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REZ_ND_CP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REZ_ND_CP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REZ_ND_CP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REZ_ND_CP ***
begin 
  execute immediate '
  CREATE TABLE BARS.REZ_ND_CP 
   (	ND NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/

PROMPT *** ALTER_POLICIES to REZ_ND_CP ***
 exec bpa.alter_policies('REZ_ND_CP');


COMMENT ON TABLE BARS.REZ_ND_CP IS 'Угоди для яких не формується дооцінка';
COMMENT ON COLUMN BARS.REZ_ND_CP.ND IS 'РЕФ.УГОДИ';

PROMPT *** Create  constraint PK_REZ_ND_CP ***
begin   
 execute immediate '
  ALTER TABLE BARS.REZ_ND_CP ADD CONSTRAINT PK_REZ_ND_CP PRIMARY KEY (ND)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/

PROMPT *** Create  index PK_REZ_ND_CP ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_REZ_ND_CP ON BARS.REZ_ND_CP (ND) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/

PROMPT *** Create  grants  REZ_ND_CP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on REZ_ND_CP    to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on REZ_ND_CP    to START1;

PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REZ_ND_CP.sql =========*** End *** 
PROMPT ===================================================================================== 
