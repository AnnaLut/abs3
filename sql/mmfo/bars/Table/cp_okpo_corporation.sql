

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/CP_OKPO_CORPORATION.sql =========*** R
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to CP_OKPO_CORPORATION ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''CP_OKPO_CORPORATION'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''CP_OKPO_CORPORATION'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table CP_OKPO_CORPORATION ***
begin 
  execute immediate '
  CREATE TABLE BARS.CP_OKPO_CORPORATION 
   (	MAIN_OKPO VARCHAR2(10), 
	CHILD_OKPO VARCHAR2(10)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSSMLD ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to CP_OKPO_CORPORATION ***
 exec bpa.alter_policies('CP_OKPO_CORPORATION');


COMMENT ON TABLE BARS.CP_OKPO_CORPORATION IS 'Группування підрозділів емітента';
COMMENT ON COLUMN BARS.CP_OKPO_CORPORATION.MAIN_OKPO IS 'Головне ЗКПО';
COMMENT ON COLUMN BARS.CP_OKPO_CORPORATION.CHILD_OKPO IS 'Дочірнє ЗКПО';



PROMPT *** Create  grants  CP_OKPO_CORPORATION ***
grant SELECT                                                                 on CP_OKPO_CORPORATION to BARSREADER_ROLE;
grant ALTER,DEBUG,DELETE,FLASHBACK,INSERT,ON COMMIT REFRESH,QUERY REWRITE,SELECT,UPDATE on CP_OKPO_CORPORATION to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on CP_OKPO_CORPORATION to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/CP_OKPO_CORPORATION.sql =========*** E
PROMPT ===================================================================================== 
