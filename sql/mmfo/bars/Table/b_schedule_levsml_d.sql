

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/B_SCHEDULE_LEVSML_D.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to B_SCHEDULE_LEVSML_D ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''B_SCHEDULE_LEVSML_D'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''B_SCHEDULE_LEVSML_D'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''B_SCHEDULE_LEVSML_D'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table B_SCHEDULE_LEVSML_D ***
begin 
  execute immediate '
  CREATE TABLE BARS.B_SCHEDULE_LEVSML_D 
   (	IDL NUMBER, 
	NAMEL VARCHAR2(150)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to B_SCHEDULE_LEVSML_D ***
 exec bpa.alter_policies('B_SCHEDULE_LEVSML_D');


COMMENT ON TABLE BARS.B_SCHEDULE_LEVSML_D IS 'Штатний розклад. Відділи (рівень 3).';
COMMENT ON COLUMN BARS.B_SCHEDULE_LEVSML_D.IDL IS '';
COMMENT ON COLUMN BARS.B_SCHEDULE_LEVSML_D.NAMEL IS '';




PROMPT *** Create  constraint PK_BSHEDLEVSML_D ***
begin   
 execute immediate '
  ALTER TABLE BARS.B_SCHEDULE_LEVSML_D ADD CONSTRAINT PK_BSHEDLEVSML_D PRIMARY KEY (IDL)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  constraint CC_BSHEDLEVSML_D_IDL_NN ***
begin   
 execute immediate '
  ALTER TABLE BARS.B_SCHEDULE_LEVSML_D MODIFY (IDL CONSTRAINT CC_BSHEDLEVSML_D_IDL_NN NOT NULL ENABLE)';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index PK_BSHEDLEVSML_D_IDL ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.PK_BSHEDLEVSML_D_IDL ON BARS.B_SCHEDULE_LEVSML_D (IDL) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYND ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  B_SCHEDULE_LEVSML_D ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on B_SCHEDULE_LEVSML_D to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on B_SCHEDULE_LEVSML_D to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on B_SCHEDULE_LEVSML_D to START1;
grant FLASHBACK,SELECT                                                       on B_SCHEDULE_LEVSML_D to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/B_SCHEDULE_LEVSML_D.sql =========*** E
PROMPT ===================================================================================== 
