

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_S010.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_S010 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_S010'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S010'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S010'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_S010 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_S010 
   (	S010 CHAR(1), 
	TXT VARCHAR2(27), 
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




PROMPT *** ALTER_POLICIES to KL_S010 ***
 exec bpa.alter_policies('KL_S010');


COMMENT ON TABLE BARS.KL_S010 IS '';
COMMENT ON COLUMN BARS.KL_S010.S010 IS '';
COMMENT ON COLUMN BARS.KL_S010.TXT IS '';
COMMENT ON COLUMN BARS.KL_S010.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_S010.D_CLOSE IS '';



PROMPT *** Create  grants  KL_S010 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_S010         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_S010         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_S010         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_S010.sql =========*** End *** =====
PROMPT ===================================================================================== 
