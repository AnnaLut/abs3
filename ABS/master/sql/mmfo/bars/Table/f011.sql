

PROMPT ====================================================================================
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table_F011.sql ========= *** Run *** ======
PROMPT ====================================================================================


PROMPT *** ALTER_POLICY_INFO to F011 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''F011'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''F011'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table F011 ***
begin 
  execute immediate '
  CREATE TABLE BARS.F011 
   (	F011 NUMBER(2), 
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


PROMPT *** Create  constraint PK_F011 ***
begin   
 execute immediate '
  ALTER TABLE BARS.F011 ADD CONSTRAINT PK_F011 PRIMARY KEY (F011)
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSSMLI  ENABLE';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/



PROMPT *** ALTER_POLICIES to F011 ***
 exec bpa.alter_policies('F011');


COMMENT ON TABLE  BARS.F011 IS 'Графік погашення платежів';
COMMENT ON COLUMN BARS.F011.F011 IS 'Код графіка погашення платежів';
COMMENT ON COLUMN BARS.F011.TXT IS 'Опис графіка погашення платежів';
COMMENT ON COLUMN BARS.F011.D_OPEN IS 'Дата відкриття показника';
COMMENT ON COLUMN BARS.F011.D_CLOSE IS 'Дата закриття показника';
COMMENT ON COLUMN BARS.F011.D_MODI IS 'Дата модифікації показника';



PROMPT *** Create  grants  F011 ***
grant SELECT            on F011         to BARS_ACCESS_DEFROLE;
grant SELECT            on F011         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/F011.sql ========= *** End *** =======
PROMPT ===================================================================================== 
