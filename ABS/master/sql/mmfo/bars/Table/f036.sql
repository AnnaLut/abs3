

PROMPT ==================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table_F036.sql ========= *** Run *** ======
PROMPT ==================================================================================== 


PROMPT *** ALTER_POLICY_INFO to F036 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''F036'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''F036'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table F036 ***
begin 
  execute immediate '
  CREATE TABLE BARS.F036 
   (	F036 NUMBER(2), 
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


PROMPT *** Create  constraint PK_F036 ***
begin   
 execute immediate '
  ALTER TABLE BARS.F036 ADD CONSTRAINT PK_F036 PRIMARY KEY (F036)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** ALTER_POLICIES to F036 ***
 exec bpa.alter_policies('F036');


COMMENT ON TABLE  BARS.F036 IS 'Використання процентної ставки за кредитом';
COMMENT ON COLUMN BARS.F036.F036 IS 'Код використання процентної ставки за кредитом';
COMMENT ON COLUMN BARS.F036.TXT IS 'Опис використання процентної ставки за кредитом';
COMMENT ON COLUMN BARS.F036.D_OPEN IS 'Дата відкриття показника';
COMMENT ON COLUMN BARS.F036.D_CLOSE IS 'Дата закриття показника';
COMMENT ON COLUMN BARS.F036.D_MODI IS 'Дата модифікації показника';



PROMPT *** Create  grants  F036 ***
grant SELECT            on F036         to BARS_ACCESS_DEFROLE;
grant SELECT            on F036         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/F036.sql ========= *** End *** =======
PROMPT ===================================================================================== 
