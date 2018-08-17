

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table_F057.sql ========= *** Run *** =======
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to F057 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''F057'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''F057'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table F057 ***
begin 
  execute immediate '
  CREATE TABLE BARS.F057 
   (	F057 CHAR(3), 
	TXT VARCHAR2(250), 
	D_OPEN DATE, 
	D_CLOSE DATE, 
	D_MODE DATE,
        A010 VARCHAR2(20)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


PROMPT *** Create  constraint PK_F057 ***
begin   
 execute immediate '
  ALTER TABLE BARS.F057 ADD CONSTRAINT PK_F057 PRIMARY KEY (F057)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** ALTER_POLICIES to F057 ***
 exec bpa.alter_policies('F057');


COMMENT ON TABLE  BARS.F057 IS 'Вид запозичення';
COMMENT ON COLUMN BARS.F057.F057 IS 'Код виду запозичення';
COMMENT ON COLUMN BARS.F057.TXT IS 'Опис виду запозичення';
COMMENT ON COLUMN BARS.F057.D_OPEN IS 'Дата відкриття показника';
COMMENT ON COLUMN BARS.F057.D_CLOSE IS 'Дата закриття показника';
COMMENT ON COLUMN BARS.F057.D_MODE IS 'Дата модифікації показника';
COMMENT ON COLUMN BARS.F057.A010 IS 'Код файлу';



PROMPT *** Create  grants  F057 ***
grant SELECT            on F057         to BARS_ACCESS_DEFROLE;
grant SELECT            on F057         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/F057.sql ========= *** End *** =======
PROMPT ===================================================================================== 
