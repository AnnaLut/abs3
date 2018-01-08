

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_R011_.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_R011_ ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_R011_'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_R011_'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_R011_'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_R011_ ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_R011_ 
   (	PREM CHAR(3), 
	R020 CHAR(4), 
	R020R011 CHAR(4), 
	R011 CHAR(1), 
	S181 CHAR(1), 
	S190 CHAR(1), 
	TXT VARCHAR2(192), 
	A010 CHAR(2), 
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




PROMPT *** ALTER_POLICIES to KL_R011_ ***
 exec bpa.alter_policies('KL_R011_');


COMMENT ON TABLE BARS.KL_R011_ IS '';
COMMENT ON COLUMN BARS.KL_R011_.PREM IS '';
COMMENT ON COLUMN BARS.KL_R011_.R020 IS '';
COMMENT ON COLUMN BARS.KL_R011_.R020R011 IS '';
COMMENT ON COLUMN BARS.KL_R011_.R011 IS '';
COMMENT ON COLUMN BARS.KL_R011_.S181 IS '';
COMMENT ON COLUMN BARS.KL_R011_.S190 IS '';
COMMENT ON COLUMN BARS.KL_R011_.TXT IS '';
COMMENT ON COLUMN BARS.KL_R011_.A010 IS '';
COMMENT ON COLUMN BARS.KL_R011_.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_R011_.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_R011_.D_MODE IS '';



PROMPT *** Create  grants  KL_R011_ ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_R011_        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_R011_        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_R011_        to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_R011_.sql =========*** End *** ====
PROMPT ===================================================================================== 
