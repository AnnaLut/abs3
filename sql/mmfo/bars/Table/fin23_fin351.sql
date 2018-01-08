

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/FIN23_FIN351.sql =========*** Run *** 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to FIN23_FIN351 ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''FIN23_FIN351'', ''FILIAL'' , null, ''E'', ''E'', ''E'');
               bpa.alter_policy_info(''FIN23_FIN351'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table FIN23_FIN351 ***
begin 
  execute immediate '
  CREATE TABLE BARS.FIN23_FIN351 
   (	FIN23 NUMBER(*,0), 
	KOL_MIN NUMBER(*,0), 
	KOL_MAX NUMBER(*,0), 
	FIN351 NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to FIN23_FIN351 ***
 exec bpa.alter_policies('FIN23_FIN351');


COMMENT ON TABLE BARS.FIN23_FIN351 IS 'Клас позичальника фіз.особи 351';
COMMENT ON COLUMN BARS.FIN23_FIN351.FIN23 IS 'Бал.рах.';
COMMENT ON COLUMN BARS.FIN23_FIN351.KOL_MIN IS 'К-ть днів просрочення від';
COMMENT ON COLUMN BARS.FIN23_FIN351.KOL_MAX IS 'К-ть днів просрочення від';
COMMENT ON COLUMN BARS.FIN23_FIN351.FIN351 IS 'Клас позичальника фіз.особи 351';



PROMPT *** Create  grants  FIN23_FIN351 ***
grant SELECT                                                                 on FIN23_FIN351    to BARSREADER_ROLE;
grant SELECT                                                                 on FIN23_FIN351    to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on FIN23_FIN351    to RCC_DEAL;
grant SELECT                                                                 on FIN23_FIN351    to START1;
grant SELECT                                                                 on FIN23_FIN351    to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/FIN23_FIN351.sql =========*** End *** 
PROMPT ===================================================================================== 
