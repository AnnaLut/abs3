

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KURS1.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KURS1 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KURS1'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KURS1'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KURS1'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KURS1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KURS1 
   (	KV NUMBER(*,0), 
	KURS NUMBER(20,10)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KURS1 ***
 exec bpa.alter_policies('KURS1');


COMMENT ON TABLE BARS.KURS1 IS '';
COMMENT ON COLUMN BARS.KURS1.KV IS '';
COMMENT ON COLUMN BARS.KURS1.KURS IS '';



PROMPT *** Create  grants  KURS1 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KURS1           to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KURS1           to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KURS1.sql =========*** End *** =======
PROMPT ===================================================================================== 
