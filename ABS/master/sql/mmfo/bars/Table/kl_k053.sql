

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K053.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K053 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_K053'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K053'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K053'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K053 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K053 
   (	K050 CHAR(3), 
	K053 CHAR(1), 
	TXT VARCHAR2(96), 
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




PROMPT *** ALTER_POLICIES to KL_K053 ***
 exec bpa.alter_policies('KL_K053');


COMMENT ON TABLE BARS.KL_K053 IS '';
COMMENT ON COLUMN BARS.KL_K053.K050 IS '';
COMMENT ON COLUMN BARS.KL_K053.K053 IS '';
COMMENT ON COLUMN BARS.KL_K053.TXT IS '';
COMMENT ON COLUMN BARS.KL_K053.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_K053.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_K053.D_MODE IS '';



PROMPT *** Create  grants  KL_K053 ***
grant SELECT                                                                 on KL_K053         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_K053         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_K053         to START1;
grant SELECT                                                                 on KL_K053         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K053.sql =========*** End *** =====
PROMPT ===================================================================================== 
