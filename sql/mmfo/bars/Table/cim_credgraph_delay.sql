

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CIM_CREDGRAPH_DELAY.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CIM_CREDGRAPH_DELAY ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CIM_CREDGRAPH_DELAY'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CREDGRAPH_DELAY'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CIM_CREDGRAPH_DELAY'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CIM_CREDGRAPH_DELAY ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.CIM_CREDGRAPH_DELAY 
   (	DAT DATE, 
	S NUMBER, 
	V_DAT DATE, 
	I NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CIM_CREDGRAPH_DELAY ***
 exec bpa.alter_policies('CIM_CREDGRAPH_DELAY');


COMMENT ON TABLE BARS.CIM_CREDGRAPH_DELAY IS 'Затримки виплати нарахованих платежів ';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_DELAY.DAT IS 'Дата нарахування';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_DELAY.S IS 'Сума погашення';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_DELAY.V_DAT IS 'Дата погашення';
COMMENT ON COLUMN BARS.CIM_CREDGRAPH_DELAY.I IS 'Вид погашення 0 - тіло, 1 - проценти';



PROMPT *** Create  grants  CIM_CREDGRAPH_DELAY ***
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CREDGRAPH_DELAY to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CIM_CREDGRAPH_DELAY to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on CIM_CREDGRAPH_DELAY to CIM_ROLE;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CIM_CREDGRAPH_DELAY.sql =========*** E
PROMPT ===================================================================================== 
