

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ANI_SP_KD.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ANI_SP_KD ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ANI_SP_KD'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ANI_SP_KD'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ANI_SP_KD'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ANI_SP_KD ***
begin 
  execute immediate '
  CREATE TABLE BARS.ANI_SP_KD 
   (	FDAT DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ANI_SP_KD ***
 exec bpa.alter_policies('ANI_SP_KD');


COMMENT ON TABLE BARS.ANI_SP_KD IS '';
COMMENT ON COLUMN BARS.ANI_SP_KD.FDAT IS '';



PROMPT *** Create  grants  ANI_SP_KD ***
grant SELECT                                                                 on ANI_SP_KD       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ANI_SP_KD       to BARS_DM;
grant SELECT                                                                 on ANI_SP_KD       to SALGL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ANI_SP_KD.sql =========*** End *** ===
PROMPT ===================================================================================== 
