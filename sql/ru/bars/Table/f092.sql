

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table_F092.sql ========= *** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to F092 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''F092'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''F092'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table F092 ***
begin 
  execute immediate '
  CREATE TABLE BARS.F092 
   (	F092 CHAR(3), 
	TXT VARCHAR2(250), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	D_MODE DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to F092 ***
 exec bpa.alter_policies('F092');


COMMENT ON TABLE  BARS.F092 IS 'Підстава для купівлі/ мета продажу';
COMMENT ON COLUMN BARS.F092.F092 IS 'Показник';
COMMENT ON COLUMN BARS.F092.TXT IS 'Текстовий опис';
COMMENT ON COLUMN BARS.F092.D_OPEN IS 'Дата відкриття показника';
COMMENT ON COLUMN BARS.F092.D_CLOSE IS 'Дата закриття показника';
COMMENT ON COLUMN BARS.F092.D_MODE IS 'дата модифікації показника';



PROMPT *** Create  grants  F092 ***
grant SELECT            on F092         to BARS_ACCESS_DEFROLE;
grant SELECT            on F092         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/F092.sql ========= *** End *** =======
PROMPT ===================================================================================== 
