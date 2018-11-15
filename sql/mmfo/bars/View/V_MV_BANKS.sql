CREATE OR REPLACE VIEW BARS.V_MV_BANKS
(
   KF,
   NAME
)
AS
   SELECT m.kf, b.name
     FROM mv_kf m, banks_ru b
    WHERE m.kf = b.mfo;


GRANT SELECT ON BARS.V_MV_BANKS TO BARS_ACCESS_DEFROLE;