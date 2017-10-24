

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K091.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K091 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_K091'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K091'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K091'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K091 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K091 
   (	K090 CHAR(5), 
	K091 CHAR(2), 
	K092 CHAR(1), 
	K093 CHAR(1), 
	TXT VARCHAR2(96), 
	TXT27 VARCHAR2(54)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_K091 ***
 exec bpa.alter_policies('KL_K091');


COMMENT ON TABLE BARS.KL_K091 IS '';
COMMENT ON COLUMN BARS.KL_K091.K090 IS '';
COMMENT ON COLUMN BARS.KL_K091.K091 IS '';
COMMENT ON COLUMN BARS.KL_K091.K092 IS '';
COMMENT ON COLUMN BARS.KL_K091.K093 IS '';
COMMENT ON COLUMN BARS.KL_K091.TXT IS '';
COMMENT ON COLUMN BARS.KL_K091.TXT27 IS '';



PROMPT *** Create  grants  KL_K091 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_K091         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_K091         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_K091         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K091.sql =========*** End *** =====
PROMPT ===================================================================================== 
