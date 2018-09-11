

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table_F090.sql ========= *** Run *** =======
PROMPT ===================================================================================== 

PROMPT *** ALTER_POLICY_INFO to F090 ***

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''F090'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''F090'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table F090 ***
begin 
  execute immediate '
  CREATE TABLE BARS.F090 
   (	F090     CHAR(3), 
	TXT      VARCHAR2(500), 
        F552     VARCHAR2(8 BYTE),
        F555     VARCHAR2(8 BYTE),
	D_OPEN    DATE, 
	D_CLOSE   DATE, 
	D_MODE    DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


PROMPT *** ALTER_POLICIES to F090 ***
 exec bpa.alter_policies('F090');


COMMENT ON TABLE  BARS.F090 IS 'Код мети надходження/переказу коштів';
COMMENT ON COLUMN BARS.F090.F090 IS 'Показник';
COMMENT ON COLUMN BARS.F090.TXT  IS 'Текстовий опис';
COMMENT ON COLUMN BARS.F090.F552 IS 'Код для форми 552 -надходження';
COMMENT ON COLUMN BARS.F090.F555 IS 'Код для форми 555 -перекази';
COMMENT ON COLUMN BARS.F090.D_OPEN  IS 'Дата відкриття показника';
COMMENT ON COLUMN BARS.F090.D_CLOSE IS 'Дата закриття показника';
COMMENT ON COLUMN BARS.F090.D_MODE  IS 'Дата модифікації показника';


PROMPT *** Create  grants  F090 ***
grant SELECT            on F090         to BARS_ACCESS_DEFROLE;
grant SELECT            on F090         to START1;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/F090.sql ========= *** End *** =======
PROMPT ===================================================================================== 

