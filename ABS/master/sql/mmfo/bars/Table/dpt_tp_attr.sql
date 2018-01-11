

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/DPT_TP_ATTR.sql =========*** Run *** =
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to DPT_TP_ATTR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''DPT_TP_ATTR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_TP_ATTR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''DPT_TP_ATTR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table DPT_TP_ATTR ***
begin 
  execute immediate '
  CREATE TABLE BARS.DPT_TP_ATTR 
   (	TYPE_ID NUMBER(38,0), 
	ATTR_ID NUMBER(38,0), 
	LABEL_ATTR VARCHAR2(128), 
	COMMENTS VARCHAR2(128)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to DPT_TP_ATTR ***
 exec bpa.alter_policies('DPT_TP_ATTR');


COMMENT ON TABLE BARS.DPT_TP_ATTR IS '';
COMMENT ON COLUMN BARS.DPT_TP_ATTR.TYPE_ID IS '';
COMMENT ON COLUMN BARS.DPT_TP_ATTR.ATTR_ID IS '';
COMMENT ON COLUMN BARS.DPT_TP_ATTR.LABEL_ATTR IS '';
COMMENT ON COLUMN BARS.DPT_TP_ATTR.COMMENTS IS '';



PROMPT *** Create  grants  DPT_TP_ATTR ***
grant SELECT                                                                 on DPT_TP_ATTR     to BARSREADER_ROLE;
grant DELETE,FLASHBACK,INSERT,SELECT,UPDATE                                  on DPT_TP_ATTR     to BARS_ACCESS_DEFROLE;
grant SELECT                                                                 on DPT_TP_ATTR     to BARS_DM;
grant SELECT                                                                 on DPT_TP_ATTR     to UPLD;
grant DELETE,INSERT,SELECT,UPDATE                                            on DPT_TP_ATTR     to VKLAD;
grant FLASHBACK,SELECT                                                       on DPT_TP_ATTR     to WR_REFREAD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/DPT_TP_ATTR.sql =========*** End *** =
PROMPT ===================================================================================== 
