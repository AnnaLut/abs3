

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS_DM/Table/D_LCS_TT_TYPE.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** Create  table D_LCS_TT_TYPE ***
begin 
  execute immediate '
  CREATE TABLE BARS_DM.D_LCS_TT_TYPE 
   (	TT VARCHAR2(3), 
	TYPE NUMBER(1,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/


COMMENT ON TABLE BARS_DM.D_LCS_TT_TYPE IS 'Тип операції по переказах';
COMMENT ON COLUMN BARS_DM.D_LCS_TT_TYPE.TT IS 'Код операції';
COMMENT ON COLUMN BARS_DM.D_LCS_TT_TYPE.TYPE IS 'Тип операції ';




PROMPT *** Create  index UX_D_LCS_TT_TYPE ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS_DM.UX_D_LCS_TT_TYPE ON BARS_DM.D_LCS_TT_TYPE (TT) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  D_LCS_TT_TYPE ***
grant SELECT                                                                 on D_LCS_TT_TYPE   to BARSUPL;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS_DM/Table/D_LCS_TT_TYPE.sql =========*** End 
PROMPT ===================================================================================== 
