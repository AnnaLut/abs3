

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/BOP_COUNT.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to BOP_COUNT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''BOP_COUNT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''BOP_COUNT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''BOP_COUNT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table BOP_COUNT ***
begin 
  execute immediate '
  CREATE TABLE BARS.BOP_COUNT 
   (	ISO_COUNTR VARCHAR2(3), 
	KODC VARCHAR2(3), 
	COUNTRY VARCHAR2(36), 
	PR VARCHAR2(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to BOP_COUNT ***
 exec bpa.alter_policies('BOP_COUNT');


COMMENT ON TABLE BARS.BOP_COUNT IS '';
COMMENT ON COLUMN BARS.BOP_COUNT.ISO_COUNTR IS '';
COMMENT ON COLUMN BARS.BOP_COUNT.KODC IS '';
COMMENT ON COLUMN BARS.BOP_COUNT.COUNTRY IS '';
COMMENT ON COLUMN BARS.BOP_COUNT.PR IS '';



PROMPT *** Create  grants  BOP_COUNT ***
grant SELECT                                                                 on BOP_COUNT       to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/BOP_COUNT.sql =========*** End *** ===
PROMPT ===================================================================================== 
