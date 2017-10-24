

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/EK1_OZ_TMP.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to EK1_OZ_TMP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''EK1_OZ_TMP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''EK1_OZ_TMP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''EK1_OZ_TMP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table EK1_OZ_TMP ***
begin 
  execute immediate '
  CREATE TABLE BARS.EK1_OZ_TMP 
   (	NBS VARCHAR2(4), 
	NAME VARCHAR2(40), 
	PAP NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to EK1_OZ_TMP ***
 exec bpa.alter_policies('EK1_OZ_TMP');


COMMENT ON TABLE BARS.EK1_OZ_TMP IS '';
COMMENT ON COLUMN BARS.EK1_OZ_TMP.NBS IS '';
COMMENT ON COLUMN BARS.EK1_OZ_TMP.NAME IS '';
COMMENT ON COLUMN BARS.EK1_OZ_TMP.PAP IS '';



PROMPT *** Create  grants  EK1_OZ_TMP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on EK1_OZ_TMP      to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on EK1_OZ_TMP      to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on EK1_OZ_TMP      to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/EK1_OZ_TMP.sql =========*** End *** ==
PROMPT ===================================================================================== 
