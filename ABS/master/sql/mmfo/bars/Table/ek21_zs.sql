

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EK21_ZS.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EK21_ZS ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EK21_ZS'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EK21_ZS'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EK21_ZS'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EK21_ZS ***
begin 
  execute immediate '
  CREATE TABLE BARS.EK21_ZS 
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




PROMPT *** ALTER_POLICIES to EK21_ZS ***
 exec bpa.alter_policies('EK21_ZS');


COMMENT ON TABLE BARS.EK21_ZS IS '';
COMMENT ON COLUMN BARS.EK21_ZS.NBS IS '';
COMMENT ON COLUMN BARS.EK21_ZS.NAME IS '';
COMMENT ON COLUMN BARS.EK21_ZS.PAP IS '';



PROMPT *** Create  grants  EK21_ZS ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on EK21_ZS         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EK21_ZS         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on EK21_ZS         to EK21_ZS;
grant FLASHBACK,SELECT                                                       on EK21_ZS         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EK21_ZS.sql =========*** End *** =====
PROMPT ===================================================================================== 
