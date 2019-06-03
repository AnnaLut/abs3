

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table_F045.sql ========= *** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to F045 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''F045'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''F045'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table F045 ***
begin 
  execute immediate '
  CREATE TABLE BARS.F045 
   (	F045 VARCHAR2(2), 
	TXT VARCHAR2(250), 
	D_OPEN DATE, 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  TABLESPACE brssmld ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


PROMPT *** Create  constraint PK_F045 ***
begin   
 execute immediate '
  ALTER TABLE BARS.F045 ADD CONSTRAINT PK_F045 PRIMARY KEY (F045)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** ALTER_POLICIES to F045 ***
 exec bpa.alter_policies('F045');


COMMENT ON TABLE  BARS.F045 IS 'Ознаки кредиту';
COMMENT ON COLUMN BARS.F045.F045 IS 'Код ознаки кредиту';
COMMENT ON COLUMN BARS.F045.TXT IS 'Опис ознаки кредиту';
COMMENT ON COLUMN BARS.F045.D_OPEN IS 'Дата відкриття показника';
COMMENT ON COLUMN BARS.F045.D_CLOSE IS 'Дата закриття показника';


PROMPT *** Create  grants  F045 ***
grant SELECT            on F045         to BARS_ACCESS_DEFROLE;
grant SELECT            on F045         to START1;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/F045.sql ========= *** End *** =======
PROMPT ===================================================================================== 
