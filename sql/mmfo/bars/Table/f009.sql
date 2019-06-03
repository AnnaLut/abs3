

PROMPT ==================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table_F009.sql ========= *** Run *** ======
PROMPT ==================================================================================== 


PROMPT *** ALTER_POLICY_INFO to F009 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''F009'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''F009'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table F009 ***
begin 
  execute immediate '
  CREATE TABLE BARS.F009 
   (	F009 NUMBER(2), 
	TXT VARCHAR2(250), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	D_MODI DATE
   ) SEGMENT CREATION IMMEDIATE 
  TABLESPACE brssmld ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


PROMPT *** Create  constraint PK_F009 ***
begin   
 execute immediate '
  ALTER TABLE BARS.F009 ADD CONSTRAINT PK_F009 PRIMARY KEY (F009)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** ALTER_POLICIES to F009 ***
 exec bpa.alter_policies('F009');


COMMENT ON TABLE  BARS.F009 IS 'Тип джерела фінансування';
COMMENT ON COLUMN BARS.F009.F009 IS 'Код типу джерела фінансування';
COMMENT ON COLUMN BARS.F009.TXT IS 'Опис типу джерела фінансування';
COMMENT ON COLUMN BARS.F009.D_OPEN IS 'Дата відкриття показника';
COMMENT ON COLUMN BARS.F009.D_CLOSE IS 'Дата закриття показника';
COMMENT ON COLUMN BARS.F009.D_MODI IS 'Дата модифікації показника';



PROMPT *** Create  grants  F009 ***
grant SELECT            on F009         to BARS_ACCESS_DEFROLE;
grant SELECT            on F009         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/F009.sql ========= *** End *** =======
PROMPT ===================================================================================== 
