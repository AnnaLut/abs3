

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EK31_CK.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EK31_CK ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EK31_CK'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EK31_CK'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EK31_CK'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EK31_CK ***
begin 
  execute immediate '
  CREATE TABLE BARS.EK31_CK 
   (	NBS VARCHAR2(4), 
	NAME VARCHAR2(40), 
	PAP NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EK31_CK ***
 exec bpa.alter_policies('EK31_CK');


COMMENT ON TABLE BARS.EK31_CK IS '';
COMMENT ON COLUMN BARS.EK31_CK.NBS IS '';
COMMENT ON COLUMN BARS.EK31_CK.NAME IS '';
COMMENT ON COLUMN BARS.EK31_CK.PAP IS '';



PROMPT *** Create  grants  EK31_CK ***
grant SELECT                                                                 on EK31_CK         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on EK31_CK         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EK31_CK         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on EK31_CK         to EK31_CK;
grant SELECT                                                                 on EK31_CK         to UPLD;
grant FLASHBACK,SELECT                                                       on EK31_CK         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EK31_CK.sql =========*** End *** =====
PROMPT ===================================================================================== 
