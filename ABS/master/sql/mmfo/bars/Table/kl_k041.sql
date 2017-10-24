

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K041.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K041 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_K041'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K041'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K041'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K041 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K041 
   (	K041 CHAR(1), 
	R032 CHAR(1), 
	S120 CHAR(1), 
	TXT VARCHAR2(48)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_K041 ***
 exec bpa.alter_policies('KL_K041');


COMMENT ON TABLE BARS.KL_K041 IS 'Классификатор НБУ (KL_K041)';
COMMENT ON COLUMN BARS.KL_K041.K041 IS '';
COMMENT ON COLUMN BARS.KL_K041.R032 IS '';
COMMENT ON COLUMN BARS.KL_K041.S120 IS '';
COMMENT ON COLUMN BARS.KL_K041.TXT IS '';



PROMPT *** Create  grants  KL_K041 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_K041         to ABS_ADMIN;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_K041         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_K041         to BARS_DM;
grant SELECT                                                                 on KL_K041         to START1;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KL_K041         to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K041.sql =========*** End *** =====
PROMPT ===================================================================================== 
