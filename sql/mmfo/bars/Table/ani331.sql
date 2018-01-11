

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ANI331.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ANI331 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ANI331'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ANI331'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ANI331'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ANI331 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ANI331 
   (	ID NUMBER(*,0), 
	NBS CHAR(4)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ANI331 ***
 exec bpa.alter_policies('ANI331');


COMMENT ON TABLE BARS.ANI331 IS 'Группы отчета "Динаміка основних показників ліквідності" и бал/счета';
COMMENT ON COLUMN BARS.ANI331.ID IS 'Код Группы ';
COMMENT ON COLUMN BARS.ANI331.NBS IS 'бал.сч ';




PROMPT *** Create  constraint PK_ANI331 ***
begin   
 execute immediate '
  ALTER TABLE BARS.ANI331 ADD CONSTRAINT PK_ANI331 PRIMARY KEY (ID, NBS)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_ANI331 ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_ANI331 ON BARS.ANI331 (ID, NBS) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  ANI331 ***
grant SELECT                                                                 on ANI331          to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on ANI331          to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ANI331          to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on ANI331          to START1;
grant SELECT                                                                 on ANI331          to UPLD;



PROMPT *** Create SYNONYM  to ANI331 ***

  CREATE OR REPLACE PUBLIC SYNONYM ANI331 FOR BARS.ANI331;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ANI331.sql =========*** End *** ======
PROMPT ===================================================================================== 
