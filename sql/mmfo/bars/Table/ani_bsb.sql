

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ANI_BSB.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ANI_BSB ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ANI_BSB'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ANI_BSB'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ANI_BSB'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ANI_BSB ***
begin 
  execute immediate '
  CREATE TABLE BARS.ANI_BSB 
   (	KOD VARCHAR2(10), 
	ID NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ANI_BSB ***
 exec bpa.alter_policies('ANI_BSB');


COMMENT ON TABLE BARS.ANI_BSB IS '';
COMMENT ON COLUMN BARS.ANI_BSB.KOD IS '';
COMMENT ON COLUMN BARS.ANI_BSB.ID IS '';



PROMPT *** Create  grants  ANI_BSB ***
grant SELECT                                                                 on ANI_BSB         to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ANI_BSB.sql =========*** End *** =====
PROMPT ===================================================================================== 
