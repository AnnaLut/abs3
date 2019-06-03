

PROMPT ====================================================================================
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table_F012.sql ========= *** Run *** ======
PROMPT ==================================================================================== 


PROMPT *** ALTER_POLICY_INFO to F012 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''F012'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''F012'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table F012 ***
begin 
  execute immediate '
  CREATE TABLE BARS.F012 
   (	F012 NUMBER(2), 
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


PROMPT *** Create  constraint PK_F012 ***
begin   
 execute immediate '
  ALTER TABLE BARS.F012 ADD CONSTRAINT PK_F012 PRIMARY KEY (F012)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** ALTER_POLICIES to F012 ***
 exec bpa.alter_policies('F012');


COMMENT ON TABLE  BARS.F012 IS 'Типу форми власності';
COMMENT ON COLUMN BARS.F012.F012 IS 'Код типу форми власності';
COMMENT ON COLUMN BARS.F012.TXT IS 'Опис типу форми власності';
COMMENT ON COLUMN BARS.F012.D_OPEN IS 'Дата відкриття показника';
COMMENT ON COLUMN BARS.F012.D_CLOSE IS 'Дата закриття показника';
COMMENT ON COLUMN BARS.F012.D_MODI IS 'Дата модифікації показника';



PROMPT *** Create  grants  F012 ***
grant SELECT            on F012         to BARS_ACCESS_DEFROLE;
grant SELECT            on F012         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/F012.sql ========= *** End *** =======
PROMPT ===================================================================================== 
