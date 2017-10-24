

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K016.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K016 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_K016'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K016'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K016'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K016 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K016 
   (	K016 CHAR(1), 
	TXT VARCHAR2(108), 
	D_OPEN DATE, 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_K016 ***
 exec bpa.alter_policies('KL_K016');


COMMENT ON TABLE BARS.KL_K016 IS '';
COMMENT ON COLUMN BARS.KL_K016.K016 IS '';
COMMENT ON COLUMN BARS.KL_K016.TXT IS '';
COMMENT ON COLUMN BARS.KL_K016.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_K016.D_CLOSE IS '';



PROMPT *** Create  grants  KL_K016 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_K016         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_K016         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_K016         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K016.sql =========*** End *** =====
PROMPT ===================================================================================== 
