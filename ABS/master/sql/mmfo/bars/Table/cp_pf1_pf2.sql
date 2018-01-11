

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_PF1_PF2.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_PF1_PF2 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_PF1_PF2'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CP_PF1_PF2'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_PF1_PF2'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_PF1_PF2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_PF1_PF2 
   (	PF1 NUMBER(*,0), 
	PF2 NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_PF1_PF2 ***
 exec bpa.alter_policies('CP_PF1_PF2');


COMMENT ON TABLE BARS.CP_PF1_PF2 IS 'Дозволен_ перем_щення м_ж портфелями';
COMMENT ON COLUMN BARS.CP_PF1_PF2.PF1 IS 'Код портфеля з';
COMMENT ON COLUMN BARS.CP_PF1_PF2.PF2 IS 'Код портфеля в';




PROMPT *** Create  constraint PK_CP_PF1PF2 ***
begin   
 execute immediate '
  ALTER TABLE BARS.CP_PF1_PF2 ADD CONSTRAINT PK_CP_PF1PF2 PRIMARY KEY (PF1, PF2)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_CP_PF1PF2 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_CP_PF1PF2 ON BARS.CP_PF1_PF2 (PF1, PF2) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  CP_PF1_PF2 ***
grant SELECT                                                                 on CP_PF1_PF2      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_PF1_PF2      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_PF1_PF2      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_PF1_PF2      to CP_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on CP_PF1_PF2      to START1;
grant SELECT                                                                 on CP_PF1_PF2      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_PF1_PF2.sql =========*** End *** ==
PROMPT ===================================================================================== 
