

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/TMP_T605.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to TMP_T605 ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table TMP_T605 ***
begin 
  execute immediate '
  CREATE TABLE BARS.TMP_T605 
   (	MD NUMBER(*,0), 
	ND NUMBER, 
	G01 DATE, 
	G02 NUMBER, 
	G03 NUMBER, 
	G04 NUMBER, 
	G05 NUMBER, 
	G06 NUMBER, 
	G07 NUMBER(*,0), 
	G08 NUMBER, 
	G09 NUMBER, 
	G10 NUMBER, 
	G11 NUMBER
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to TMP_T605 ***
 exec bpa.alter_policies('TMP_T605');


COMMENT ON TABLE BARS.TMP_T605 IS 'COBUSUPABS-5819.Розрахунок простроченої заборгованості за основним боргом, ';
COMMENT ON COLUMN BARS.TMP_T605.MD IS '';
COMMENT ON COLUMN BARS.TMP_T605.ND IS 'Реф дог';
COMMENT ON COLUMN BARS.TMP_T605.G01 IS 'Дата операції';
COMMENT ON COLUMN BARS.TMP_T605.G02 IS 'Сума наданого кредиту';
COMMENT ON COLUMN BARS.TMP_T605.G03 IS 'Сума чергового платежу по кредиту';
COMMENT ON COLUMN BARS.TMP_T605.G04 IS 'Сума погашеного кредиту';
COMMENT ON COLUMN BARS.TMP_T605.G05 IS 'Залишок заборгованості';
COMMENT ON COLUMN BARS.TMP_T605.G06 IS 'Залишок простроченої заборгованості';
COMMENT ON COLUMN BARS.TMP_T605.G07 IS 'К-ть днів прострочки';
COMMENT ON COLUMN BARS.TMP_T605.G08 IS 'Розмір пені';
COMMENT ON COLUMN BARS.TMP_T605.G09 IS 'Сума пені';
COMMENT ON COLUMN BARS.TMP_T605.G10 IS '3% річних';
COMMENT ON COLUMN BARS.TMP_T605.G11 IS 'Сума 3% річних';



PROMPT *** Create  grants  TMP_T605 ***
grant SELECT                                                                 on TMP_T605        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on TMP_T605        to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/TMP_T605.sql =========*** End *** ====
PROMPT ===================================================================================== 
