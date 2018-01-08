

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PATCHES.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PATCHES ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PATCHES'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PATCHES'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PATCHES'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PATCHES ***
begin 
  execute immediate '
  CREATE TABLE BARS.PATCHES 
   (	PATCH_NUMBER VARCHAR2(7), 
	PATCH_VERSION VARCHAR2(3), 
	APPLY_DATE DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PATCHES ***
 exec bpa.alter_policies('PATCHES');


COMMENT ON TABLE BARS.PATCHES IS '';
COMMENT ON COLUMN BARS.PATCHES.PATCH_NUMBER IS '';
COMMENT ON COLUMN BARS.PATCHES.PATCH_VERSION IS '';
COMMENT ON COLUMN BARS.PATCHES.APPLY_DATE IS '';



PROMPT *** Create  grants  PATCHES ***
grant SELECT                                                                 on PATCHES         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PATCHES         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PATCHES         to START1;
grant SELECT                                                                 on PATCHES         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PATCHES.sql =========*** End *** =====
PROMPT ===================================================================================== 
