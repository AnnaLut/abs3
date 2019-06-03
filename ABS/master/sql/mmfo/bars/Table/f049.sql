

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table_F049.sql ========= *** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to F049 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''F049'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''F049'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table F049 ***
begin 
  execute immediate '
  CREATE TABLE BARS.F049 
   (	F049 VARCHAR2(2), 
	TXT VARCHAR2(250), 
	D_OPEN DATE, 
	D_CLOSE DATE
   ) SEGMENT CREATION IMMEDIATE 
  TABLESPACE brssmld ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


PROMPT *** Create  constraint PK_F049 ***
begin   
 execute immediate '
  ALTER TABLE BARS.F049 ADD CONSTRAINT PK_F049 PRIMARY KEY (F049)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** ALTER_POLICIES to F049 ***
 exec bpa.alter_policies('F049');


COMMENT ON TABLE  BARS.F049 IS 'Пояснення щодо внесення змін до договору';
COMMENT ON COLUMN BARS.F049.F049 IS 'Код пояснення щодо внесення змін до договору';
COMMENT ON COLUMN BARS.F049.TXT IS 'Опис пояснення щодо внесення змін до договору';
COMMENT ON COLUMN BARS.F049.D_OPEN IS 'Дата відкриття показника';
COMMENT ON COLUMN BARS.F049.D_CLOSE IS 'Дата закриття показника';


PROMPT *** Create  grants  F049 ***
grant SELECT            on F049         to BARS_ACCESS_DEFROLE;
grant SELECT            on F049         to START1;


PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/F049.sql ========= *** End *** =======
PROMPT ===================================================================================== 
