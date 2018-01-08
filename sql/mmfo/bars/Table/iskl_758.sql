

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/ISKL_758.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to ISKL_758 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''ISKL_758'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''ISKL_758'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''ISKL_758'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table ISKL_758 ***
begin 
  execute immediate '
  CREATE TABLE BARS.ISKL_758 
   (	TXT VARCHAR2(110)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to ISKL_758 ***
 exec bpa.alter_policies('ISKL_758');


COMMENT ON TABLE BARS.ISKL_758 IS '';
COMMENT ON COLUMN BARS.ISKL_758.TXT IS '';



PROMPT *** Create  grants  ISKL_758 ***
grant SELECT                                                                 on ISKL_758        to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on ISKL_758        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on ISKL_758        to BARS_DM;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on ISKL_758        to START1;
grant SELECT                                                                 on ISKL_758        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/ISKL_758.sql =========*** End *** ====
PROMPT ===================================================================================== 
