

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/PCORPSR.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to PCORPSR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''PCORPSR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''PCORPSR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''PCORPSR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table PCORPSR ***
begin 
  execute immediate '
  CREATE TABLE BARS.PCORPSR 
   (	LAST_NAME VARCHAR2(25), 
	FIRST_NAME VARCHAR2(12), 
	TOTAL NUMBER(24,2)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to PCORPSR ***
 exec bpa.alter_policies('PCORPSR');


COMMENT ON TABLE BARS.PCORPSR IS '';
COMMENT ON COLUMN BARS.PCORPSR.LAST_NAME IS '';
COMMENT ON COLUMN BARS.PCORPSR.FIRST_NAME IS '';
COMMENT ON COLUMN BARS.PCORPSR.TOTAL IS '';



PROMPT *** Create  grants  PCORPSR ***
grant SELECT                                                                 on PCORPSR         to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PCORPSR         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on PCORPSR         to START1;
grant SELECT                                                                 on PCORPSR         to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/PCORPSR.sql =========*** End *** =====
PROMPT ===================================================================================== 
