

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ANI_2620.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ANI_2620 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ANI_2620'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ANI_2620'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ANI_2620'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ANI_2620 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ANI_2620 
   (	NBS CHAR(4), 
	OB22 CHAR(2)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ANI_2620 ***
 exec bpa.alter_policies('ANI_2620');


COMMENT ON TABLE BARS.ANI_2620 IS '';
COMMENT ON COLUMN BARS.ANI_2620.NBS IS '';
COMMENT ON COLUMN BARS.ANI_2620.OB22 IS '';



PROMPT *** Create  grants  ANI_2620 ***
grant SELECT                                                                 on ANI_2620        to BARSREADER_ROLE;
grant SELECT                                                                 on ANI_2620        to BARS_DM;
grant SELECT                                                                 on ANI_2620        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ANI_2620.sql =========*** End *** ====
PROMPT ===================================================================================== 
