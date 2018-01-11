

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/STRU_SB.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to STRU_SB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''STRU_SB'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''STRU_SB'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''STRU_SB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table STRU_SB ***
begin 
  execute immediate '
  CREATE TABLE BARS.STRU_SB 
   (	NAME CHAR(8), 
	POLE CHAR(10), 
	TYP CHAR(2), 
	LEN NUMBER(*,0), 
	DEC NUMBER(*,0), 
	TXT VARCHAR2(144)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to STRU_SB ***
 exec bpa.alter_policies('STRU_SB');


COMMENT ON TABLE BARS.STRU_SB IS '';
COMMENT ON COLUMN BARS.STRU_SB.NAME IS '';
COMMENT ON COLUMN BARS.STRU_SB.POLE IS '';
COMMENT ON COLUMN BARS.STRU_SB.TYP IS '';
COMMENT ON COLUMN BARS.STRU_SB.LEN IS '';
COMMENT ON COLUMN BARS.STRU_SB.DEC IS '';
COMMENT ON COLUMN BARS.STRU_SB.TXT IS '';



PROMPT *** Create  grants  STRU_SB ***
grant SELECT                                                                 on STRU_SB         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on STRU_SB         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on STRU_SB         to START1;
grant SELECT                                                                 on STRU_SB         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/STRU_SB.sql =========*** End *** =====
PROMPT ===================================================================================== 
