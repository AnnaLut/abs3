

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K140.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K140 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_K140'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K140'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K140'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K140 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K140 
   (	K140 VARCHAR2(1), 
	TXT VARCHAR2(165), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	D_MODE DATE, 
	K140SR VARCHAR2(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_K140 ***
 exec bpa.alter_policies('KL_K140');


COMMENT ON TABLE BARS.KL_K140 IS '';
COMMENT ON COLUMN BARS.KL_K140.K140 IS '';
COMMENT ON COLUMN BARS.KL_K140.TXT IS '';
COMMENT ON COLUMN BARS.KL_K140.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_K140.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_K140.D_MODE IS '';
COMMENT ON COLUMN BARS.KL_K140.K140SR IS '';



PROMPT *** Create  grants  KL_K140 ***
grant SELECT                                                                 on KL_K140         to BARSREADER_ROLE;
grant SELECT                                                                 on KL_K140         to UPLD;
grant FLASHBACK,SELECT                                                       on KL_K140         to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K140.sql =========*** End *** =====
PROMPT ===================================================================================== 
