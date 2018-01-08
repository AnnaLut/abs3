

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_6_7.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_6_7 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_6_7 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_6_7 
   (	REF NUMBER, 
	NLSA VARCHAR2(15), 
	NLSB VARCHAR2(15), 
	S NUMBER(24,0), 
	ERR VARCHAR2(100)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 0 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_6_7 ***
 exec bpa.alter_policies('TMP_6_7');


COMMENT ON TABLE BARS.TMP_6_7 IS 'Довiдник помилок перекриття 6,7 кл. на 5040(5041)';
COMMENT ON COLUMN BARS.TMP_6_7.REF IS 'Референс док-ту';
COMMENT ON COLUMN BARS.TMP_6_7.NLSA IS 'Рах. Дт ';
COMMENT ON COLUMN BARS.TMP_6_7.NLSB IS 'Рах. Кт ';
COMMENT ON COLUMN BARS.TMP_6_7.S IS 'Сума проводки ';
COMMENT ON COLUMN BARS.TMP_6_7.ERR IS 'Опис помилки ';



PROMPT *** Create  grants  TMP_6_7 ***
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_6_7         to ABS_ADMIN;
grant SELECT                                                                 on TMP_6_7         to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on TMP_6_7         to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on TMP_6_7         to START1;
grant SELECT                                                                 on TMP_6_7         to UPLD;
grant FLASHBACK,SELECT                                                       on TMP_6_7         to WR_REFREAD;



PROMPT *** Create SYNONYM  to TMP_6_7 ***

  CREATE OR REPLACE PUBLIC SYNONYM TMP_6_7 FOR BARS.TMP_6_7;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_6_7.sql =========*** End *** =====
PROMPT ===================================================================================== 
