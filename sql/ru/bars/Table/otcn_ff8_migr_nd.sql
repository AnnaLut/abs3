

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/OTCN_FF8_MIGR_ND.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to OTCN_FF8_MIGR_ND ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''OTCN_FF8_MIGR_ND'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''OTCN_FF8_MIGR_ND'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** drop table OTCN_FF8_MIGR_ND ***
begin 
  execute immediate '
  DROP TABLE BARS.OTCN_FF8_MIGR_ND ';
exception when others then       
  if sqlcode=-942 then null; else raise; end if; 
end;
/

PROMPT *** Create  table OTCN_FF8_MIGR_ND ***
begin 
  execute immediate '
  CREATE GLOBAL TEMPORARY TABLE BARS.OTCN_FF8_MIGR_ND 
   (	ND VARCHAR2(40), 
	VID NUMBER
   ) ON COMMIT PRESERVE ROWS ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to OTCN_FF8_MIGR_ND ***
 exec bpa.alter_policies('OTCN_FF8_MIGR_ND');


COMMENT ON TABLE BARS.OTCN_FF8_MIGR_ND IS '';
COMMENT ON COLUMN BARS.OTCN_FF8_MIGR_ND.ND IS '';





PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/OTCN_FF8_MIGR_ND.sql =========*** End 
PROMPT ===================================================================================== 
