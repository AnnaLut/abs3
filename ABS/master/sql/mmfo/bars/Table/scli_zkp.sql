

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/SCLI_ZKP.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to SCLI_ZKP ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''SCLI_ZKP'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''SCLI_ZKP'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''SCLI_ZKP'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table SCLI_ZKP ***
begin 
  execute immediate '
  CREATE TABLE BARS.SCLI_ZKP 
   (	ZKPO VARCHAR2(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSMDLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to SCLI_ZKP ***
 exec bpa.alter_policies('SCLI_ZKP');


COMMENT ON TABLE BARS.SCLI_ZKP IS '';
COMMENT ON COLUMN BARS.SCLI_ZKP.ZKPO IS '';



PROMPT *** Create  grants  SCLI_ZKP ***
grant SELECT                                                                 on SCLI_ZKP        to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on SCLI_ZKP        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on SCLI_ZKP        to BARS_DM;
grant SELECT                                                                 on SCLI_ZKP        to RPBN001;
grant SELECT                                                                 on SCLI_ZKP        to SALGL;
grant SELECT                                                                 on SCLI_ZKP        to START1;
grant SELECT                                                                 on SCLI_ZKP        to UPLD;
grant FLASHBACK,SELECT                                                       on SCLI_ZKP        to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/SCLI_ZKP.sql =========*** End *** ====
PROMPT ===================================================================================== 
