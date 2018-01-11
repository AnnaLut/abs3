

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K113.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K113 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_K113'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K113'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K113'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K113 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K113 
   (	K112 CHAR(1), 
	K113 CHAR(2), 
	TXT VARCHAR2(96), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	D_MODE DATE, 
	K113_OLD CHAR(2)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_K113 ***
 exec bpa.alter_policies('KL_K113');


COMMENT ON TABLE BARS.KL_K113 IS '';
COMMENT ON COLUMN BARS.KL_K113.K112 IS '';
COMMENT ON COLUMN BARS.KL_K113.K113 IS '';
COMMENT ON COLUMN BARS.KL_K113.TXT IS '';
COMMENT ON COLUMN BARS.KL_K113.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_K113.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_K113.D_MODE IS '';
COMMENT ON COLUMN BARS.KL_K113.K113_OLD IS '';



PROMPT *** Create  grants  KL_K113 ***
grant SELECT                                                                 on KL_K113         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_K113         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_K113         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_K113         to START1;
grant SELECT                                                                 on KL_K113         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K113.sql =========*** End *** =====
PROMPT ===================================================================================== 
