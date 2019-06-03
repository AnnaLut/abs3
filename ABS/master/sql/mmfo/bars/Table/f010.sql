

PROMPT ====================================================================================
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table_F010.sql ========= *** Run *** ======
PROMPT ==================================================================================== 


PROMPT *** ALTER_POLICY_INFO to F010 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''F010'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''F010'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table F010 ***
begin 
  execute immediate '
  CREATE TABLE BARS.F010 
   (	F010 NUMBER(2), 
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


PROMPT *** Create  constraint PK_F010 ***
begin   
 execute immediate '
  ALTER TABLE BARS.F010 ADD CONSTRAINT PK_F010 PRIMARY KEY (F010)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** ALTER_POLICIES to F010 ***
 exec bpa.alter_policies('F010');


COMMENT ON TABLE  BARS.F010 IS 'Тип угоди';
COMMENT ON COLUMN BARS.F010.F010 IS 'Код типу угоди';
COMMENT ON COLUMN BARS.F010.TXT IS 'Опис типу угоди';
COMMENT ON COLUMN BARS.F010.D_OPEN IS 'Дата відкриття показника';
COMMENT ON COLUMN BARS.F010.D_CLOSE IS 'Дата закриття показника';
COMMENT ON COLUMN BARS.F010.D_MODI IS 'Дата модифікації показника';



PROMPT *** Create  grants  F010 ***
grant SELECT            on F010         to BARS_ACCESS_DEFROLE;
grant SELECT            on F010         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/F010.sql ========= *** End *** =======
PROMPT ===================================================================================== 
