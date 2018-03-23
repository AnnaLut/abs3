
PROMPT *** Create  view V_OW_IIC_MSGCODE ***

CREATE OR REPLACE VIEW V_OW_IIC_MSGCODE AS
select tt, mfoa, nlsa, msgcode from OW_IIC_MSGCODE;

PROMPT *** Create  grants  V_OW_IIC_MSGCODE ***
grant SELECT    on V_OW_IIC_MSGCODE      to BARS_ACCESS_DEFROLE;
grant SELECT    on V_OW_IIC_MSGCODE      to START1;

grant INSERT    on V_OW_IIC_MSGCODE      to BARS_ACCESS_DEFROLE;
grant UPDATE    on V_OW_IIC_MSGCODE      to BARS_ACCESS_DEFROLE;
grant DELETE    on V_OW_IIC_MSGCODE      to BARS_ACCESS_DEFROLE;

