

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_S030.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_S030 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_S030'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S030'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S030'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_S030 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_S030 
   (	S030 CHAR(1), 
	TXT VARCHAR2(48), 
	D_CLOSE DATE, 
	D_OPEN DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_S030 ***
 exec bpa.alter_policies('KL_S030');


COMMENT ON TABLE BARS.KL_S030 IS '';
COMMENT ON COLUMN BARS.KL_S030.S030 IS '';
COMMENT ON COLUMN BARS.KL_S030.TXT IS '';
COMMENT ON COLUMN BARS.KL_S030.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_S030.D_OPEN IS '';



PROMPT *** Create  grants  KL_S030 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_S030         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_S030         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_S030         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_S030.sql =========*** End *** =====
PROMPT ===================================================================================== 
