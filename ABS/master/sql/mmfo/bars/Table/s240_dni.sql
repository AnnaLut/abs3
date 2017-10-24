

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S240_DNI.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S240_DNI ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''S240_DNI'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''S240_DNI'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''S240_DNI'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S240_DNI ***
begin 
  execute immediate '
  CREATE TABLE BARS.S240_DNI 
   (	S240 CHAR(1), 
	DNI NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S240_DNI ***
 exec bpa.alter_policies('S240_DNI');


COMMENT ON TABLE BARS.S240_DNI IS 'S240 та довжина перiодiв в днях';
COMMENT ON COLUMN BARS.S240_DNI.S240 IS 'S240';
COMMENT ON COLUMN BARS.S240_DNI.DNI IS 'Днiв в перiодi';




PROMPT *** Create  constraint XPK_S240DNI ***
begin   
 execute immediate '
  ALTER TABLE BARS.S240_DNI ADD CONSTRAINT XPK_S240DNI PRIMARY KEY (S240)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/




PROMPT *** Create  index XPK_S240DNI ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_S240DNI ON BARS.S240_DNI (S240) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  S240_DNI ***
grant DELETE,INSERT,SELECT,UPDATE                                            on S240_DNI        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on S240_DNI        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on S240_DNI        to SALGL;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on S240_DNI        to WR_ALL_RIGHTS;



PROMPT *** Create SYNONYM  to S240_DNI ***

  CREATE OR REPLACE PUBLIC SYNONYM S240_DNI FOR BARS.S240_DNI;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S240_DNI.sql =========*** End *** ====
PROMPT ===================================================================================== 
