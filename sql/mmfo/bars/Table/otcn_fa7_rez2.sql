

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_FA7_REZ2.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_FA7_REZ2 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_FA7_REZ2'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_FA7_REZ2'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_FA7_REZ2'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_FA7_REZ2 ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.OTCN_FA7_REZ2 
   (	ND NUMBER, 
	ACC NUMBER, 
	PR NUMBER, 
	SUM NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_FA7_REZ2 ***
 exec bpa.alter_policies('OTCN_FA7_REZ2');


COMMENT ON TABLE BARS.OTCN_FA7_REZ2 IS 'Временная таблица для дисконтов/премий';
COMMENT ON COLUMN BARS.OTCN_FA7_REZ2.ND IS '';
COMMENT ON COLUMN BARS.OTCN_FA7_REZ2.ACC IS '';
COMMENT ON COLUMN BARS.OTCN_FA7_REZ2.PR IS '';
COMMENT ON COLUMN BARS.OTCN_FA7_REZ2.SUM IS '';



PROMPT *** Create  grants  OTCN_FA7_REZ2 ***
grant SELECT                                                                 on OTCN_FA7_REZ2   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_FA7_REZ2   to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on OTCN_FA7_REZ2   to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_FA7_REZ2.sql =========*** End ***
PROMPT ===================================================================================== 
