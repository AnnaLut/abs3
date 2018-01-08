

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BU_B2.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BU_B2 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BU_B2 ***
begin 
  execute immediate '
  CREATE TABLE BARS.BU_B2 
   (	B2 NUMBER(*,0), 
	NAME VARCHAR2(90)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BU_B2 ***
 exec bpa.alter_policies('BU_B2');


COMMENT ON TABLE BARS.BU_B2 IS '';
COMMENT ON COLUMN BARS.BU_B2.B2 IS '';
COMMENT ON COLUMN BARS.BU_B2.NAME IS '';



PROMPT *** Create  grants  BU_B2 ***
grant ALTER,DELETE,FLASHBACK,INSERT,SELECT,UPDATE                            on BU_B2           to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BU_B2           to BARS_DM;
grant ALTER,DELETE,INSERT,SELECT,UPDATE                                      on BU_B2           to BU;
grant FLASHBACK,SELECT                                                       on BU_B2           to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BU_B2.sql =========*** End *** =======
PROMPT ===================================================================================== 
