

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BIC.sql =========*** Run *** =========
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BIC ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BIC'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BIC'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BIC'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BIC ***
begin 
  execute immediate '
  CREATE TABLE BARS.BIC 
   (	GROUP_C NUMBER(*,0), 
	CLI_KOD NUMBER(*,0), 
	ID VARCHAR2(14), 
	NAME VARCHAR2(38), 
	K_INBANK CHAR(10)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BIC ***
 exec bpa.alter_policies('BIC');


COMMENT ON TABLE BARS.BIC IS '';
COMMENT ON COLUMN BARS.BIC.GROUP_C IS '';
COMMENT ON COLUMN BARS.BIC.CLI_KOD IS '';
COMMENT ON COLUMN BARS.BIC.ID IS '';
COMMENT ON COLUMN BARS.BIC.NAME IS '';
COMMENT ON COLUMN BARS.BIC.K_INBANK IS '';



PROMPT *** Create  grants  BIC ***
grant SELECT                                                                 on BIC             to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on BIC             to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on BIC             to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on BIC             to START1;
grant SELECT                                                                 on BIC             to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BIC.sql =========*** End *** =========
PROMPT ===================================================================================== 
