

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BU_C2.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BU_C2 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BU_C2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.BU_C2 
   (	C2 NUMBER(*,0), 
	NAME VARCHAR2(90)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BU_C2 ***
 exec bpa.alter_policies('BU_C2');


COMMENT ON TABLE BARS.BU_C2 IS '';
COMMENT ON COLUMN BARS.BU_C2.C2 IS '';
COMMENT ON COLUMN BARS.BU_C2.NAME IS '';



PROMPT *** Create  grants  BU_C2 ***
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on BU_C2           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BU_C2           to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on BU_C2           to BU;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BU_C2.sql =========*** End *** =======
PROMPT ===================================================================================== 
