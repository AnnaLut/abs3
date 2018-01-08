

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K074.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K074 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_K074'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K074'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K074'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K074 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K074 
   (	K074 CHAR(1), 
	TXT VARCHAR2(27), 
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




PROMPT *** ALTER_POLICIES to KL_K074 ***
 exec bpa.alter_policies('KL_K074');


COMMENT ON TABLE BARS.KL_K074 IS '';
COMMENT ON COLUMN BARS.KL_K074.K074 IS '';
COMMENT ON COLUMN BARS.KL_K074.TXT IS '';
COMMENT ON COLUMN BARS.KL_K074.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_K074.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_K074.D_MODE IS '';



PROMPT *** Create  grants  KL_K074 ***
grant SELECT                                                                 on KL_K074         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_K074         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_K074         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_K074         to START1;
grant SELECT                                                                 on KL_K074         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K074.sql =========*** End *** =====
PROMPT ===================================================================================== 
