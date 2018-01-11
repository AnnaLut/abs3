

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SPRORGAN.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SPRORGAN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SPRORGAN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SPRORGAN'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''SPRORGAN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SPRORGAN ***
begin 
  execute immediate '
  CREATE TABLE BARS.SPRORGAN 
   (	KOD_ORG CHAR(8), 
	NAZVA VARCHAR2(250)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SPRORGAN ***
 exec bpa.alter_policies('SPRORGAN');


COMMENT ON TABLE BARS.SPRORGAN IS '';
COMMENT ON COLUMN BARS.SPRORGAN.KOD_ORG IS '';
COMMENT ON COLUMN BARS.SPRORGAN.NAZVA IS '';



PROMPT *** Create  grants  SPRORGAN ***
grant SELECT                                                                 on SPRORGAN        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SPRORGAN        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SPRORGAN        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on SPRORGAN        to START1;
grant SELECT                                                                 on SPRORGAN        to UPLD;
grant FLASHBACK,SELECT                                                       on SPRORGAN        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SPRORGAN.sql =========*** End *** ====
PROMPT ===================================================================================== 
