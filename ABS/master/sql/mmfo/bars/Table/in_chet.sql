

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/IN_CHET.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to IN_CHET ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''IN_CHET'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''IN_CHET'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''IN_CHET'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table IN_CHET ***
begin 
  execute immediate '
  CREATE TABLE BARS.IN_CHET 
   (	C_CNT NUMBER(*,0), 
	NAME_CNT VARCHAR2(27)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to IN_CHET ***
 exec bpa.alter_policies('IN_CHET');


COMMENT ON TABLE BARS.IN_CHET IS '';
COMMENT ON COLUMN BARS.IN_CHET.C_CNT IS '';
COMMENT ON COLUMN BARS.IN_CHET.NAME_CNT IS '';



PROMPT *** Create  grants  IN_CHET ***
grant SELECT                                                                 on IN_CHET         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on IN_CHET         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on IN_CHET         to START1;
grant SELECT                                                                 on IN_CHET         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/IN_CHET.sql =========*** End *** =====
PROMPT ===================================================================================== 
