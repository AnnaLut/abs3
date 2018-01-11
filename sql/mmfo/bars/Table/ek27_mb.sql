

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EK27_MB.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EK27_MB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EK27_MB'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EK27_MB'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EK27_MB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EK27_MB ***
begin 
  execute immediate '
  CREATE TABLE BARS.EK27_MB 
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




PROMPT *** ALTER_POLICIES to EK27_MB ***
 exec bpa.alter_policies('EK27_MB');


COMMENT ON TABLE BARS.EK27_MB IS '';
COMMENT ON COLUMN BARS.EK27_MB.NBS IS '';
COMMENT ON COLUMN BARS.EK27_MB.NAME IS '';
COMMENT ON COLUMN BARS.EK27_MB.PAP IS '';



PROMPT *** Create  grants  EK27_MB ***
grant SELECT                                                                 on EK27_MB         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on EK27_MB         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EK27_MB         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on EK27_MB         to EK27_MB;
grant SELECT                                                                 on EK27_MB         to UPLD;
grant FLASHBACK,SELECT                                                       on EK27_MB         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EK27_MB.sql =========*** End *** =====
PROMPT ===================================================================================== 
