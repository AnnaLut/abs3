

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/S_NP.sql =========*** Run *** ========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to S_NP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''S_NP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''S_NP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''S_NP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table S_NP ***
begin 
  execute immediate '
  CREATE TABLE BARS.S_NP 
   (	K_NP CHAR(3), 
	N_NP VARCHAR2(160)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to S_NP ***
 exec bpa.alter_policies('S_NP');


COMMENT ON TABLE BARS.S_NP IS '';
COMMENT ON COLUMN BARS.S_NP.K_NP IS '';
COMMENT ON COLUMN BARS.S_NP.N_NP IS '';



PROMPT *** Create  grants  S_NP ***
grant SELECT                                                                 on S_NP            to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on S_NP            to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on S_NP            to START1;
grant SELECT                                                                 on S_NP            to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/S_NP.sql =========*** End *** ========
PROMPT ===================================================================================== 
