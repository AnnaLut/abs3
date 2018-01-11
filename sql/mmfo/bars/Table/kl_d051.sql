

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_D051.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_D051 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_D051'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_D051'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_D051'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_D051 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_D051 
   (	D051 VARCHAR2(2), 
	TXT VARCHAR2(125), 
	TXT48 VARCHAR2(48), 
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




PROMPT *** ALTER_POLICIES to KL_D051 ***
 exec bpa.alter_policies('KL_D051');


COMMENT ON TABLE BARS.KL_D051 IS '';
COMMENT ON COLUMN BARS.KL_D051.D051 IS '';
COMMENT ON COLUMN BARS.KL_D051.TXT IS '';
COMMENT ON COLUMN BARS.KL_D051.TXT48 IS '';
COMMENT ON COLUMN BARS.KL_D051.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_D051.D_CLOSE IS '';



PROMPT *** Create  grants  KL_D051 ***
grant SELECT                                                                 on KL_D051         to BARSREADER_ROLE;
grant SELECT                                                                 on KL_D051         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_D051.sql =========*** End *** =====
PROMPT ===================================================================================== 
