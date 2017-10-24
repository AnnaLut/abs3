

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/KP_PRINT.sql =========*** Run *** ====
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to KP_PRINT ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''KP_PRINT'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''KP_PRINT'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''KP_PRINT'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table KP_PRINT ***
begin 
  execute immediate '
  CREATE TABLE BARS.KP_PRINT 
   (	VOB NUMBER(*,0)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to KP_PRINT ***
 exec bpa.alter_policies('KP_PRINT');


COMMENT ON TABLE BARS.KP_PRINT IS 'КП. Шаблон оттиска (тикета)';
COMMENT ON COLUMN BARS.KP_PRINT.VOB IS '';



PROMPT *** Create  grants  KP_PRINT ***
grant DELETE,INSERT,SELECT,UPDATE                                            on KP_PRINT        to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on KP_PRINT        to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on KP_PRINT        to R_KP;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on KP_PRINT        to WR_ALL_RIGHTS;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/KP_PRINT.sql =========*** End *** ====
PROMPT ===================================================================================== 
