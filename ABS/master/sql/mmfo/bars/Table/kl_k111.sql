

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K111.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K111 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_K111'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K111'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K111'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K111 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K111 
   (	K111 VARCHAR2(2), 
	K112 VARCHAR2(1), 
	K113 VARCHAR2(2), 
	K114 VARCHAR2(2), 
	TXT VARCHAR2(144), 
	TXT27 VARCHAR2(108), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	D_MODE DATE, 
	K113_OLD VARCHAR2(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_K111 ***
 exec bpa.alter_policies('KL_K111');


COMMENT ON TABLE BARS.KL_K111 IS '';
COMMENT ON COLUMN BARS.KL_K111.K111 IS '';
COMMENT ON COLUMN BARS.KL_K111.K112 IS '';
COMMENT ON COLUMN BARS.KL_K111.K113 IS '';
COMMENT ON COLUMN BARS.KL_K111.K114 IS '';
COMMENT ON COLUMN BARS.KL_K111.TXT IS '';
COMMENT ON COLUMN BARS.KL_K111.TXT27 IS '';
COMMENT ON COLUMN BARS.KL_K111.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_K111.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_K111.D_MODE IS '';
COMMENT ON COLUMN BARS.KL_K111.K113_OLD IS '';



PROMPT *** Create  grants  KL_K111 ***
grant SELECT                                                                 on KL_K111         to BARSREADER_ROLE;
grant SELECT                                                                 on KL_K111         to BARS_DM;
grant SELECT                                                                 on KL_K111         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K111.sql =========*** End *** =====
PROMPT ===================================================================================== 
