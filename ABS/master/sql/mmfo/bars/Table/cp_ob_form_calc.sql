

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/cp_ob_form_calc.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to cp_ob_form_calc ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''cp_ob_form_calc'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''cp_ob_form_calc'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''cp_ob_form_calc'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table cp_ob_form_calc ***
begin 
  execute immediate '
  CREATE TABLE BARS.cp_ob_form_calc 
   (	CODE VARCHAR2(2), 
	TXT VARCHAR2(70)
   ) 
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to cp_ob_form_calc ***
 exec bpa.alter_policies('cp_ob_form_calc');


COMMENT ON TABLE BARS.cp_ob_form_calc IS 'Форма проведення розрахунку';
COMMENT ON COLUMN BARS.cp_ob_form_calc.CODE IS 'Код';
COMMENT ON COLUMN BARS.cp_ob_form_calc.TXT IS 'Розшифровка';



begin   
 execute immediate 'alter table cp_ob_form_calc
  add constraint PK_CPOBFORMCALC primary key (CODE)
  using index 
  tablespace BRSSMLI';
exception when others then
  if  sqlcode=-2260 or sqlcode=-2261 or sqlcode=-2264 or sqlcode=-2275 or sqlcode=-1442 then null; else raise; end if;
 end;
/







PROMPT *** Create  grants  cp_ob_form_calc ***
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on cp_ob_form_calc    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on cp_ob_form_calc    to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on cp_ob_form_calc    to START1;
grant FLASHBACK,SELECT                                                       on cp_ob_form_calc    to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/cp_ob_form_calc.sql =========*** End *** 
PROMPT ===================================================================================== 
