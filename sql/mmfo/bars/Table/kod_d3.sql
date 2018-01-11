

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KOD_D3.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KOD_D3 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KOD_D3'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_D3'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KOD_D3'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KOD_D3 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KOD_D3 
   (	NA_PIDR VARCHAR2(86), 
	A NUMBER(*,0), 
	BB CHAR(6), 
	CC CHAR(6), 
	F NUMBER(*,0), 
	P NUMBER(*,0), 
	DD CHAR(5), 
	KOD NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KOD_D3 ***
 exec bpa.alter_policies('KOD_D3');


COMMENT ON TABLE BARS.KOD_D3 IS '';
COMMENT ON COLUMN BARS.KOD_D3.NA_PIDR IS '';
COMMENT ON COLUMN BARS.KOD_D3.A IS '';
COMMENT ON COLUMN BARS.KOD_D3.BB IS '';
COMMENT ON COLUMN BARS.KOD_D3.CC IS '';
COMMENT ON COLUMN BARS.KOD_D3.F IS '';
COMMENT ON COLUMN BARS.KOD_D3.P IS '';
COMMENT ON COLUMN BARS.KOD_D3.DD IS '';
COMMENT ON COLUMN BARS.KOD_D3.KOD IS '';



PROMPT *** Create  grants  KOD_D3 ***
grant SELECT                                                                 on KOD_D3          to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KOD_D3          to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KOD_D3          to START1;
grant SELECT                                                                 on KOD_D3          to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KOD_D3.sql =========*** End *** ======
PROMPT ===================================================================================== 
