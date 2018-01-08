

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CONTRACTS_JOURNALN.sql =========*** Ru
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CONTRACTS_JOURNALN ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CONTRACTS_JOURNALN'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CONTRACTS_JOURNALN'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CONTRACTS_JOURNALN'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CONTRACTS_JOURNALN ***
begin 
  execute immediate '
  CREATE TABLE BARS.CONTRACTS_JOURNALN 
   (	DAT DATE, 
	USERID NUMBER, 
	ACTION_ID NUMBER, 
	IMPEXP NUMBER, 
	PID NUMBER, 
	IDT NUMBER, 
	IDP NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CONTRACTS_JOURNALN ***
 exec bpa.alter_policies('CONTRACTS_JOURNALN');


COMMENT ON TABLE BARS.CONTRACTS_JOURNALN IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNALN.DAT IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNALN.USERID IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNALN.ACTION_ID IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNALN.IMPEXP IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNALN.PID IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNALN.IDT IS '';
COMMENT ON COLUMN BARS.CONTRACTS_JOURNALN.IDP IS '';



PROMPT *** Create  grants  CONTRACTS_JOURNALN ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CONTRACTS_JOURNALN to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CONTRACTS_JOURNALN to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CONTRACTS_JOURNALN to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CONTRACTS_JOURNALN.sql =========*** En
PROMPT ===================================================================================== 
