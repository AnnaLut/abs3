

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K092.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K092 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_K092'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K092'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K092'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K092 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K092 
   (	K092 CHAR(1), 
	K093 CHAR(1), 
	TXT VARCHAR2(48), 
	TXT27 VARCHAR2(27)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_K092 ***
 exec bpa.alter_policies('KL_K092');


COMMENT ON TABLE BARS.KL_K092 IS '';
COMMENT ON COLUMN BARS.KL_K092.K092 IS '';
COMMENT ON COLUMN BARS.KL_K092.K093 IS '';
COMMENT ON COLUMN BARS.KL_K092.TXT IS '';
COMMENT ON COLUMN BARS.KL_K092.TXT27 IS '';



PROMPT *** Create  grants  KL_K092 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_K092         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_K092         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_K092         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K092.sql =========*** End *** =====
PROMPT ===================================================================================== 
