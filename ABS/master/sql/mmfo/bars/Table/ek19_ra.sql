

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EK19_RA.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EK19_RA ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EK19_RA'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EK19_RA'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EK19_RA'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EK19_RA ***
begin 
  execute immediate '
  CREATE TABLE BARS.EK19_RA 
   (	NLS VARCHAR2(15), 
	NAME VARCHAR2(40), 
	PAP NUMBER(*,0), 
	PROC NUMBER(5,2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EK19_RA ***
 exec bpa.alter_policies('EK19_RA');


COMMENT ON TABLE BARS.EK19_RA IS '';
COMMENT ON COLUMN BARS.EK19_RA.NLS IS '';
COMMENT ON COLUMN BARS.EK19_RA.NAME IS '';
COMMENT ON COLUMN BARS.EK19_RA.PAP IS '';
COMMENT ON COLUMN BARS.EK19_RA.PROC IS '';



PROMPT *** Create  grants  EK19_RA ***
grant SELECT                                                                 on EK19_RA         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on EK19_RA         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EK19_RA         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on EK19_RA         to EK19_RA;
grant SELECT                                                                 on EK19_RA         to UPLD;
grant FLASHBACK,SELECT                                                       on EK19_RA         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EK19_RA.sql =========*** End *** =====
PROMPT ===================================================================================== 
