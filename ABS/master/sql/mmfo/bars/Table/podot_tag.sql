

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PODOT_TAG.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PODOT_TAG ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PODOT_TAG'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PODOT_TAG'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PODOT_TAG'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PODOT_TAG ***
begin 
  execute immediate '
  CREATE TABLE BARS.PODOT_TAG 
   (	TAG VARCHAR2(5), 
	COMM VARCHAR2(50)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PODOT_TAG ***
 exec bpa.alter_policies('PODOT_TAG');


COMMENT ON TABLE BARS.PODOT_TAG IS '';
COMMENT ON COLUMN BARS.PODOT_TAG.TAG IS '';
COMMENT ON COLUMN BARS.PODOT_TAG.COMM IS '';



PROMPT *** Create  grants  PODOT_TAG ***
grant DELETE,INSERT,SELECT,UPDATE                                            on PODOT_TAG       to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PODOT_TAG       to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PODOT_TAG.sql =========*** End *** ===
PROMPT ===================================================================================== 
