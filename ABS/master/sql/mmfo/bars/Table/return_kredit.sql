

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/RETURN_KREDIT.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to RETURN_KREDIT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''RETURN_KREDIT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''RETURN_KREDIT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''RETURN_KREDIT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table RETURN_KREDIT ***
begin 
  execute immediate '
  CREATE TABLE BARS.RETURN_KREDIT 
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




PROMPT *** ALTER_POLICIES to RETURN_KREDIT ***
 exec bpa.alter_policies('RETURN_KREDIT');


COMMENT ON TABLE BARS.RETURN_KREDIT IS '';
COMMENT ON COLUMN BARS.RETURN_KREDIT.CODE IS '';
COMMENT ON COLUMN BARS.RETURN_KREDIT.TXT IS '';



PROMPT *** Create  grants  RETURN_KREDIT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on RETURN_KREDIT   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on RETURN_KREDIT   to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on RETURN_KREDIT   to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/RETURN_KREDIT.sql =========*** End ***
PROMPT ===================================================================================== 
