

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/REPVP_NOLIMITUSR.sql =========*** Run 
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to REPVP_NOLIMITUSR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''REPVP_NOLIMITUSR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''REPVP_NOLIMITUSR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''REPVP_NOLIMITUSR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table REPVP_NOLIMITUSR ***
begin 
  execute immediate '
  CREATE TABLE BARS.REPVP_NOLIMITUSR 
   (	USERID NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to REPVP_NOLIMITUSR ***
 exec bpa.alter_policies('REPVP_NOLIMITUSR');


COMMENT ON TABLE BARS.REPVP_NOLIMITUSR IS 'Список пользователей, кот. могут выполнять выписки без ограничений на период';
COMMENT ON COLUMN BARS.REPVP_NOLIMITUSR.USERID IS '';



PROMPT *** Create  grants  REPVP_NOLIMITUSR ***
grant SELECT                                                                 on REPVP_NOLIMITUSR to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on REPVP_NOLIMITUSR to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on REPVP_NOLIMITUSR to BARS_DM;
grant DELETE,INSERT,SELECT,UPDATE                                            on REPVP_NOLIMITUSR to RPBN001;
grant SELECT                                                                 on REPVP_NOLIMITUSR to UPLD;
grant FLASHBACK,SELECT                                                       on REPVP_NOLIMITUSR to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/REPVP_NOLIMITUSR.sql =========*** End 
PROMPT ===================================================================================== 
