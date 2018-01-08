

PROMPT ===================================================================================== 
PROMPT *** Run *** ========== Scripts /Sql/BARS/Table/P_OVR_ERR.sql =========*** Run *** ===
PROMPT ===================================================================================== 


PROMPT *** ALTER_POLICY_INFO to P_OVR_ERR ***


BEGIN 
        execute immediate  
          'begin  
               bpa.alter_policy_info(''P_OVR_ERR'', ''CENTER'' , null, null, null, null);
               bpa.alter_policy_info(''P_OVR_ERR'', ''FILIAL'' , null, null, null, null);
               bpa.alter_policy_info(''P_OVR_ERR'', ''WHOLE'' , null, null, null, null);
               null;
           end; 
          '; 
END; 
/

PROMPT *** Create  table P_OVR_ERR ***
begin 
  execute immediate '
  CREATE TABLE BARS.P_OVR_ERR 
   (	FLAG NUMBER(1,0), 
	S NUMBER, 
	NLS VARCHAR2(15), 
	ERR VARCHAR2(255)
   ) SEGMENT CREATION DEFERRED 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 
 NOCOMPRESS LOGGING
  TABLESPACE BRSDYND ';
exception when others then       
  if sqlcode=-955 then null; else raise; end if; 
end; 
/




PROMPT *** ALTER_POLICIES to P_OVR_ERR ***
 exec bpa.alter_policies('P_OVR_ERR');


COMMENT ON TABLE BARS.P_OVR_ERR IS '';
COMMENT ON COLUMN BARS.P_OVR_ERR.FLAG IS '';
COMMENT ON COLUMN BARS.P_OVR_ERR.S IS '';
COMMENT ON COLUMN BARS.P_OVR_ERR.NLS IS '';
COMMENT ON COLUMN BARS.P_OVR_ERR.ERR IS '';



PROMPT *** Create  grants  P_OVR_ERR ***
grant SELECT                                                                 on P_OVR_ERR       to BARSREADER_ROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on P_OVR_ERR       to BARS_ACCESS_DEFROLE;
grant DELETE,INSERT,SELECT,UPDATE                                            on P_OVR_ERR       to START1;
grant SELECT                                                                 on P_OVR_ERR       to UPLD;



PROMPT ===================================================================================== 
PROMPT *** End *** ========== Scripts /Sql/BARS/Table/P_OVR_ERR.sql =========*** End *** ===
PROMPT ===================================================================================== 
