

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_S200.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_S200 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_S200'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S200'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S200'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_S200 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_S200 
   (	S200 CHAR(1), 
	TXT VARCHAR2(48)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_S200 ***
 exec bpa.alter_policies('KL_S200');


COMMENT ON TABLE BARS.KL_S200 IS '';
COMMENT ON COLUMN BARS.KL_S200.S200 IS '';
COMMENT ON COLUMN BARS.KL_S200.TXT IS '';



PROMPT *** Create  grants  KL_S200 ***
grant SELECT                                                                 on KL_S200         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_S200         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_S200         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_S200         to START1;
grant SELECT                                                                 on KL_S200         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_S200.sql =========*** End *** =====
PROMPT ===================================================================================== 
