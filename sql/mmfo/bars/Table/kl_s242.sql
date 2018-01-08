

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KL_S242.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KL_S242 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KL_S242'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S242'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KL_S242'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KL_S242 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KL_S242 
   (	S242 CHAR(1), 
	TXT VARCHAR2(48)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KL_S242 ***
 exec bpa.alter_policies('KL_S242');


COMMENT ON TABLE BARS.KL_S242 IS '';
COMMENT ON COLUMN BARS.KL_S242.S242 IS '';
COMMENT ON COLUMN BARS.KL_S242.TXT IS '';



PROMPT *** Create  grants  KL_S242 ***
grant SELECT                                                                 on KL_S242         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_S242         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KL_S242         to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KL_S242         to START1;
grant SELECT                                                                 on KL_S242         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KL_S242.sql =========*** End *** =====
PROMPT ===================================================================================== 
