

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_FA7_TEMP.sql =========*** Run ***
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_FA7_TEMP ***


BEGIN 
        execute immediate  
          'begin  
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table OTCN_FA7_TEMP ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.OTCN_FA7_TEMP 
   (	R020 CHAR(4)
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_FA7_TEMP ***
 exec bpa.alter_policies('OTCN_FA7_TEMP');


COMMENT ON TABLE BARS.OTCN_FA7_TEMP IS 'Временная таблица для бал.счетов начисленных процентов';
COMMENT ON COLUMN BARS.OTCN_FA7_TEMP.R020 IS '';



PROMPT *** Create  grants  OTCN_FA7_TEMP ***
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_FA7_TEMP   to ABS_ADMIN;
grant SELECT                                                                 on OTCN_FA7_TEMP   to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_FA7_TEMP   to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on OTCN_FA7_TEMP   to RPBN002;
grant SELECT                                                                 on OTCN_FA7_TEMP   to UPLD;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on OTCN_FA7_TEMP   to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_FA7_TEMP.sql =========*** End ***
PROMPT ===================================================================================== 
