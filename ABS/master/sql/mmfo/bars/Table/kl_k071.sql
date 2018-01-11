

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K071.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K071 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_K071'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K071'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K071'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K071 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K071 
   (	K071 VARCHAR2(1), 
	TXT VARCHAR2(96), 
	TXT27 VARCHAR2(54), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	D_MODE DATE, 
	K030 VARCHAR2(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_K071 ***
 exec bpa.alter_policies('KL_K071');


COMMENT ON TABLE BARS.KL_K071 IS '';
COMMENT ON COLUMN BARS.KL_K071.K071 IS '';
COMMENT ON COLUMN BARS.KL_K071.TXT IS '';
COMMENT ON COLUMN BARS.KL_K071.TXT27 IS '';
COMMENT ON COLUMN BARS.KL_K071.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_K071.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_K071.D_MODE IS '';
COMMENT ON COLUMN BARS.KL_K071.K030 IS '';



PROMPT *** Create  grants  KL_K071 ***
grant SELECT                                                                 on KL_K071         to BARSREADER_ROLE;
grant SELECT                                                                 on KL_K071         to BARS_DM;
grant SELECT                                                                 on KL_K071         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K071.sql =========*** End *** =====
PROMPT ===================================================================================== 
