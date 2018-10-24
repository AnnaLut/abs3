

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/F058.sql ========= *** Run *** =======
PROMPT ===================================================================================== 

PROMPT *** ALTER_POLICY_INFO to F058 ***

BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''F058'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''F058'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table F058 ***
begin 
  execute immediate '
  CREATE TABLE BARS.F058 
   (	F058     CHAR(1), 
	TXT      VARCHAR2(80), 
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


PROMPT *** ALTER_POLICIES to F058 ***
 exec bpa.alter_policies('F058');


COMMENT ON TABLE  BARS.F058 IS 'Код підгрупи банківської групи';
COMMENT ON COLUMN BARS.F058.F058 IS 'Показник';
COMMENT ON COLUMN BARS.F058.TXT  IS 'Текстовий опис';
COMMENT ON COLUMN BARS.F058.D_OPEN  IS 'Дата відкриття показника';
COMMENT ON COLUMN BARS.F058.D_CLOSE IS 'Дата закриття показника';
COMMENT ON COLUMN BARS.F058.D_MODE  IS 'Дата модифікації показника';


PROMPT *** Create  index IDX_F058EKP ***
begin   
 execute immediate '
  CREATE INDEX BARS.IDX_F058EKP ON BARS.F058 (F058) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  F058 ***
grant SELECT            on F058         to BARS_ACCESS_DEFROLE;
grant SELECT            on F058         to START1;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/F058.sql ========= *** End *** =======
PROMPT ===================================================================================== 


