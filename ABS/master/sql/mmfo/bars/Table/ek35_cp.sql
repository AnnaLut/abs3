

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EK35_CP.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EK35_CP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EK35_CP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EK35_CP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EK35_CP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EK35_CP ***
begin 
  execute immediate '
  CREATE TABLE BARS.EK35_CP 
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




PROMPT *** ALTER_POLICIES to EK35_CP ***
 exec bpa.alter_policies('EK35_CP');


COMMENT ON TABLE BARS.EK35_CP IS '';
COMMENT ON COLUMN BARS.EK35_CP.NBS IS '';
COMMENT ON COLUMN BARS.EK35_CP.NAME IS '';
COMMENT ON COLUMN BARS.EK35_CP.PAP IS '';



PROMPT *** Create  grants  EK35_CP ***
grant SELECT                                                                 on EK35_CP         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on EK35_CP         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EK35_CP         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on EK35_CP         to EK35_CP;
grant SELECT                                                                 on EK35_CP         to UPLD;
grant FLASHBACK,SELECT                                                       on EK35_CP         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EK35_CP.sql =========*** End *** =====
PROMPT ===================================================================================== 
