

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KODY1.sql =========*** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KODY1 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KODY1'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KODY1'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KODY1'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KODY1 ***
begin 
  execute immediate '
  CREATE TABLE BARS.KODY1 
   (	KOD NUMBER(*,0), 
	T CHAR(4), 
	KOMENTAR VARCHAR2(50), 
	N NUMBER(*,0)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KODY1 ***
 exec bpa.alter_policies('KODY1');


COMMENT ON TABLE BARS.KODY1 IS '';
COMMENT ON COLUMN BARS.KODY1.KOD IS '';
COMMENT ON COLUMN BARS.KODY1.T IS '';
COMMENT ON COLUMN BARS.KODY1.KOMENTAR IS '';
COMMENT ON COLUMN BARS.KODY1.N IS '';



PROMPT *** Create  grants  KODY1 ***
grant SELECT                                                                 on KODY1           to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KODY1           to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on KODY1           to START1;
grant SELECT                                                                 on KODY1           to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KODY1.sql =========*** End *** =======
PROMPT ===================================================================================== 
