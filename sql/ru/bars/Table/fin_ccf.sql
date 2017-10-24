

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN_CCF.sql =========*** Run *** =====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN_CCF ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN_CCF'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''FIN_CCF'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN_CCF ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN_CCF 
   (	GRP NUMBER(*,0), 
	CCF NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN_CCF ***
 exec bpa.alter_policies('FIN_CCF');


COMMENT ON TABLE BARS.FIN_CCF IS 'Довідник значення коеф.конверсії';
COMMENT ON COLUMN BARS.FIN_CCF.GRP IS 'Група';
COMMENT ON COLUMN BARS.FIN_CCF.CCF IS 'Значення коеф. CCF';



PROMPT *** Create  grants  FIN_CCF ***
grant SELECT                                                                 on FIN_CCF         to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN_CCF         to RCC_DEAL;
grant SELECT                                                                 on FIN_CCF         to START1;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN_CCF.sql =========*** End *** =====
PROMPT ===================================================================================== 
