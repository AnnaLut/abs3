

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ANI_67.sql =========*** Run *** ======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ANI_67 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ANI_67'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ANI_67'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ANI_67'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ANI_67 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ANI_67 
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




PROMPT *** ALTER_POLICIES to ANI_67 ***
 exec bpa.alter_policies('ANI_67');


COMMENT ON TABLE BARS.ANI_67 IS '';
COMMENT ON COLUMN BARS.ANI_67.NBS IS '';
COMMENT ON COLUMN BARS.ANI_67.OB22 IS '';



PROMPT *** Create  grants  ANI_67 ***
grant SELECT                                                                 on ANI_67          to BARS_DM;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ANI_67.sql =========*** End *** ======
PROMPT ===================================================================================== 
