

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_K013.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_K013 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_K013'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K013'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_K013'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_K013 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_K013 
   (	K013 VARCHAR2(1), 
	TXT VARCHAR2(60), 
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




PROMPT *** ALTER_POLICIES to KL_K013 ***
 exec bpa.alter_policies('KL_K013');


COMMENT ON TABLE BARS.KL_K013 IS '';
COMMENT ON COLUMN BARS.KL_K013.K013 IS '';
COMMENT ON COLUMN BARS.KL_K013.TXT IS '';
COMMENT ON COLUMN BARS.KL_K013.D_OPEN IS '';
COMMENT ON COLUMN BARS.KL_K013.D_CLOSE IS '';
COMMENT ON COLUMN BARS.KL_K013.D_MODE IS '';



PROMPT *** Create  grants  KL_K013 ***
grant SELECT                                                                 on KL_K013         to BARSUPL;
grant SELECT                                                                 on KL_K013         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_K013         to BARS_DM;
grant SELECT                                                                 on KL_K013         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_K013.sql =========*** End *** =====
PROMPT ===================================================================================== 
