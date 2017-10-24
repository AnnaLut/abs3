

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K072.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K072 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_K072'', ''FILIAL'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K072 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K072 
   (	K072 CHAR(1), 
	K075 CHAR(1), 
	K073 CHAR(1), 
	K071 CHAR(1), 
	K074 CHAR(1), 
	K070 VARCHAR2(35), 
	TXT VARCHAR2(123), 
	TXT27 VARCHAR2(54), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	D_MODE DATE, 
	K030 CHAR(1)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_K072 ***
 exec bpa.alter_policies('KL_K072');


COMMENT ON TABLE BARS.KL_K072 IS '';
COMMENT ON COLUMN BARS.KL_K072.K072 IS '';
COMMENT ON COLUMN BARS.KL_K072.K075 IS '';
COMMENT ON COLUMN BARS.KL_K072.K073 IS '';
COMMENT ON COLUMN BARS.KL_K072.K071 IS '';
COMMENT ON COLUMN BARS.KL_K072.K074 IS '';
COMMENT ON COLUMN BARS.KL_K072.K070 IS '';
COMMENT ON COLUMN BARS.KL_K072.TXT IS '';
COMMENT ON COLUMN BARS.KL_K072.TXT27 IS '';
COMMENT ON COLUMN BARS.KL_K072.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_K072.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_K072.D_MODE IS '';
COMMENT ON COLUMN BARS.KL_K072.K030 IS '';



PROMPT *** Create  grants  KL_K072 ***
grant SELECT                                                                 on KL_K072         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_K072         to KL_K072;
grant SELECT                                                                 on KL_K072         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K072.sql =========*** End *** =====
PROMPT ===================================================================================== 
