

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_NU0B22.sql =========*** Run *** ==
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_NU0B22 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_NU0B22'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_NU0B22'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_NU0B22'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_NU0B22 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_NU0B22 
   (	ACC NUMBER, 
	NLS VARCHAR2(15), 
	NMS VARCHAR2(70)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_NU0B22 ***
 exec bpa.alter_policies('TMP_NU0B22');


COMMENT ON TABLE BARS.TMP_NU0B22 IS '';
COMMENT ON COLUMN BARS.TMP_NU0B22.ACC IS '';
COMMENT ON COLUMN BARS.TMP_NU0B22.NLS IS '';
COMMENT ON COLUMN BARS.TMP_NU0B22.NMS IS '';



PROMPT *** Create  grants  TMP_NU0B22 ***
grant SELECT                                                                 on TMP_NU0B22      to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_NU0B22      to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_NU0B22      to START1;
grant SELECT                                                                 on TMP_NU0B22      to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_NU0B22.sql =========*** End *** ==
PROMPT ===================================================================================== 
