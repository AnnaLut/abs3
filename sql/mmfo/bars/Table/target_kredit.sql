

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TARGET_KREDIT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TARGET_KREDIT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''TARGET_KREDIT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''TARGET_KREDIT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''TARGET_KREDIT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TARGET_KREDIT ***
begin 
  execute immediate '
  CREATE TABLE BARS.TARGET_KREDIT 
   (	CODE NUMBER, 
	TXT VARCHAR2(255)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TARGET_KREDIT ***
 exec bpa.alter_policies('TARGET_KREDIT');


COMMENT ON TABLE BARS.TARGET_KREDIT IS '';
COMMENT ON COLUMN BARS.TARGET_KREDIT.CODE IS '';
COMMENT ON COLUMN BARS.TARGET_KREDIT.TXT IS '';



PROMPT *** Create  grants  TARGET_KREDIT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TARGET_KREDIT   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TARGET_KREDIT   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on TARGET_KREDIT   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TARGET_KREDIT.sql =========*** End ***
PROMPT ===================================================================================== 
