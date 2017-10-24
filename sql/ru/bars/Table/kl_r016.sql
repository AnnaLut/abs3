

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_R016.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_R016 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_R016'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_R016'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_R016 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_R016 
   (	R016 VARCHAR2(2), 
	TXT VARCHAR2(64), 
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




PROMPT *** ALTER_POLICIES to KL_R016 ***
 exec bpa.alter_policies('KL_R016');


COMMENT ON TABLE BARS.KL_R016 IS '';
COMMENT ON COLUMN BARS.KL_R016.R016 IS '';
COMMENT ON COLUMN BARS.KL_R016.TXT IS '';
COMMENT ON COLUMN BARS.KL_R016.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_R016.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_R016.D_MODE IS '';



PROMPT *** Create  grants  KL_R016 ***
grant SELECT                                                                 on KL_R016         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_R016         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_R016.sql =========*** End *** =====
PROMPT ===================================================================================== 
