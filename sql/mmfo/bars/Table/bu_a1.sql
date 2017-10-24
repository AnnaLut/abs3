

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BU_A1.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BU_A1 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BU_A1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.BU_A1 
   (	A1 NUMBER(*,0), 
	NAME VARCHAR2(90)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BU_A1 ***
 exec bpa.alter_policies('BU_A1');


COMMENT ON TABLE BARS.BU_A1 IS '';
COMMENT ON COLUMN BARS.BU_A1.A1 IS '';
COMMENT ON COLUMN BARS.BU_A1.NAME IS '';



PROMPT *** Create  grants  BU_A1 ***
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on BU_A1           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BU_A1           to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on BU_A1           to BU;
grant FLASHBACK,SELECT                                                       on BU_A1           to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BU_A1.sql =========*** End *** =======
PROMPT ===================================================================================== 
