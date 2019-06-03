

PROMPT ====================================================================================
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table_F014.sql ========= *** Run *** ======
PROMPT ====================================================================================


PROMPT *** ALTER_POLICY_INFO to F014 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''F014'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''F014'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table F014 ***
begin 
  execute immediate '
  CREATE TABLE BARS.F014 
   (	F014 CHAR(1), 
	TXT VARCHAR2(25), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	D_MODI DATE
   ) SEGMENT CREATION IMMEDIATE 
  TABLESPACE brssmld ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


PROMPT *** Create  constraint PK_F014 ***
begin   
 execute immediate '
  ALTER TABLE BARS.F014 ADD CONSTRAINT PK_F014 PRIMARY KEY (F014)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** ALTER_POLICIES to F014 ***
 exec bpa.alter_policies('F014');


COMMENT ON TABLE  BARS.F014 IS 'Вид подання звіту';
COMMENT ON COLUMN BARS.F014.F014 IS 'Код виду подання звіту';
COMMENT ON COLUMN BARS.F014.TXT IS 'Опис виду подання звіту';
COMMENT ON COLUMN BARS.F014.D_OPEN IS 'Дата відкриття показника';
COMMENT ON COLUMN BARS.F014.D_CLOSE IS 'Дата закриття показника';
COMMENT ON COLUMN BARS.F014.D_MODI IS 'Дата модифікації показника';



PROMPT *** Create  grants  F014 ***
grant SELECT            on F014         to BARS_ACCESS_DEFROLE;
grant SELECT            on F014         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/F014.sql ========= *** End *** =======
PROMPT ===================================================================================== 
