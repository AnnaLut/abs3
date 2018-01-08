

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K112.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K112 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_K112'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K112'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K112'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K112 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K112 
   (	K112 CHAR(1), 
	K092 CHAR(1), 
	TXT VARCHAR2(96), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	D_MODE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_K112 ***
 exec bpa.alter_policies('KL_K112');


COMMENT ON TABLE BARS.KL_K112 IS '';
COMMENT ON COLUMN BARS.KL_K112.K112 IS '';
COMMENT ON COLUMN BARS.KL_K112.K092 IS '';
COMMENT ON COLUMN BARS.KL_K112.TXT IS '';
COMMENT ON COLUMN BARS.KL_K112.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_K112.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_K112.D_MODE IS '';



PROMPT *** Create  grants  KL_K112 ***
grant SELECT                                                                 on KL_K112         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_K112         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_K112         to START1;
grant SELECT                                                                 on KL_K112         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K112.sql =========*** End *** =====
PROMPT ===================================================================================== 
