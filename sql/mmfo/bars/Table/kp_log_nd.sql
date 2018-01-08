

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KP_LOG_ND.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KP_LOG_ND ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KP_LOG_ND'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KP_LOG_ND'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KP_LOG_ND'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KP_LOG_ND ***
begin 
  execute immediate '
  CREATE TABLE BARS.KP_LOG_ND 
   (	ND NUMBER(*,0), 
	LOG NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KP_LOG_ND ***
 exec bpa.alter_policies('KP_LOG_ND');


COMMENT ON TABLE BARS.KP_LOG_ND IS 'КП. Договора в лог.группах';
COMMENT ON COLUMN BARS.KP_LOG_ND.ND IS 'реф дог';
COMMENT ON COLUMN BARS.KP_LOG_ND.LOG IS 'Код лог.гр';




PROMPT *** Create  index XPK_KP_LOG_ND ***
begin   
 execute immediate '
  CREATE UNIQUE INDEX BARS.XPK_KP_LOG_ND ON BARS.KP_LOG_ND (ND, LOG) 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  TABLESPACE BRSDYNI ';
exception when others then
  if  sqlcode=-955  then null; else raise; end if;
 end;
/



PROMPT *** Create  grants  KP_LOG_ND ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KP_LOG_ND       to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KP_LOG_ND       to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KP_LOG_ND       to R_KP;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KP_LOG_ND       to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KP_LOG_ND.sql =========*** End *** ===
PROMPT ===================================================================================== 
