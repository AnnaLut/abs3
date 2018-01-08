

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_OBPCMOVBAL.sql =========*** Run **
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_OBPCMOVBAL ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TMP_OBPCMOVBAL'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_OBPCMOVBAL'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TMP_OBPCMOVBAL'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_OBPCMOVBAL ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_OBPCMOVBAL 
   (	REF NUMBER, 
	PDAT DATE
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_OBPCMOVBAL ***
 exec bpa.alter_policies('TMP_OBPCMOVBAL');


COMMENT ON TABLE BARS.TMP_OBPCMOVBAL IS '';
COMMENT ON COLUMN BARS.TMP_OBPCMOVBAL.REF IS '';
COMMENT ON COLUMN BARS.TMP_OBPCMOVBAL.PDAT IS '';



PROMPT *** Create  grants  TMP_OBPCMOVBAL ***
grant SELECT                                                                 on TMP_OBPCMOVBAL  to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_OBPCMOVBAL  to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_OBPCMOVBAL  to START1;
grant SELECT                                                                 on TMP_OBPCMOVBAL  to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_OBPCMOVBAL.sql =========*** End **
PROMPT ===================================================================================== 
